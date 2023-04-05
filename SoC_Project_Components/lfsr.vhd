

                            ------------------------------------------------------------------
                            --      File:               lfsr.vhd                            --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Linear Feedback Shift Register      --
                            --                          Fibonacci-LFSR 15-bit polynomial:   --
                            --                          x^15 + x^14 + x^13 + x^11 + 1       --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.01.07                          --
                            ------------------------------------------------------------------

library IEEE;                   -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic library
use IEEE.MATH_REAL.ALL;         -- use library for mathematical functions


entity lfsr is
    generic(
            mem_width   : integer range 0 to 16 := 15
    );

    Port(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            en_i        : in  std_logic;
            pause_i     : in  std_logic;
            dir_up_i    : in  std_logic;
            end_o       : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
end lfsr;



architecture Behavioral of lfsr is
    constant SEED           : std_logic_vector((mem_width-1) downto 0) := ((mem_width-1) => '1', others =>'0'); -- set MSB to "1"
    signal shift_reg_sig    : std_logic_vector((mem_width-1) downto 0);
    signal next_state_sig   : std_logic_vector((mem_width-1) downto 0);
    signal feedback_sig     : std_logic;
    signal unlock_end_sig   : std_logic;
    signal unlock_end_next_sig   : std_logic;
    signal end_sig          : std_logic;


begin
                          ------------------
-------------------------|  Init and clock  |-----------------------
                          ------------------
    process(clk_i, reset_i)
    begin
        if(reset_i='1') then                    -- reset (active high)
            shift_reg_sig       <= SEED;
            unlock_end_next_sig <= '0';
        elsif(clk_i='1' AND clk_i'event) then   -- rising clock-edge
            unlock_end_next_sig  <= '1';

            if(en_i = '1') then
                if(pause_i = '0') then
                    shift_reg_sig   <= next_state_sig;
                end if;
            else
                unlock_end_next_sig <= '0';
                shift_reg_sig       <= SEED;
            end if;
        end if;
    end process;

                          ------------------
-------------------------|  End detection   |-----------------------
                          ------------------
    process(shift_reg_sig, reset_i)
    begin
        if(reset_i='1') then    -- reset (active high)
            end_sig     <= '1';
        else
            if(shift_reg_sig = SEED) then
                end_sig <= '1';
            else
                end_sig <= '0';
            end if;
        end if;
    end process;

                          ------------------
-------------------------| Unlock handling  |-----------------------
                          ------------------
    process(clk_i, reset_i)
    begin
        if(reset_i='1') then                    -- reset (active high)
            unlock_end_sig  <= '0';
        elsif(clk_i='1' AND clk_i'event) then   -- rising clock-edge
            unlock_end_sig  <= unlock_end_next_sig;
        end if;
    end process;

                          ------------------
-------------------------| Shift direction  |-----------------------
                          ------------------
    with dir_up_i select
    --                  Bit15               Bit14                   Bit13               Bit11
    feedback_sig <= shift_reg_sig(14) XOR shift_reg_sig(13) XOR shift_reg_sig(12) XOR shift_reg_sig(10) when '1',   -- polynomial: x^15 + x^14 + x^13 + x^11 + 1
    --                  Bit15               Bit4                    Bit2                Bit1
                    shift_reg_sig(14) XOR shift_reg_sig(3)  XOR shift_reg_sig(1)  XOR shift_reg_sig(0)  when others;-- reciprocal polynomial: x^15 + x^4 + x^2 + x + 1


    with dir_up_i select
        addr_o  <= shift_reg_sig((mem_width-1) downto 0) when '1',  -- return shift-reg
                   shift_reg_sig(0) & shift_reg_sig(1)              -- return shift-reg in reverse order
                 & shift_reg_sig(2) & shift_reg_sig(3)
                 & shift_reg_sig(4) & shift_reg_sig(5)
                 & shift_reg_sig(6) & shift_reg_sig(7)
                 & shift_reg_sig(8) & shift_reg_sig(9)
                 & shift_reg_sig(10) & shift_reg_sig(11)
                 & shift_reg_sig(12) & shift_reg_sig(13)
                 & shift_reg_sig((mem_width-1)) when others;

    next_state_sig  <= shift_reg_sig(13 downto 0) & feedback_sig;
    end_o           <= end_sig AND unlock_end_sig AND en_i;

end Behavioral;