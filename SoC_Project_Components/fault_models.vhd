

                            ------------------------------------------------------------------
                            --      File:               fault_models.vhd                    --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Fault model to test BIST            --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.02.18                          --
                            ------------------------------------------------------------------

library IEEE;                   -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components


entity fault_models is
    generic(
            stuck_fault_addr: integer range 0 to 32768;
            addr_fault_addr : integer range 0 to 32768;
            addr_fault_new  : integer range 0 to 32768;
            trans_fault_addr: integer range 0 to 32768;
            mem_width       : integer range 0 to 16
    );

    port (
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            lfsr_end_i  : in  std_logic;
            din_i       : in  std_logic;
            addr_i      : in  std_logic_vector((mem_width-1) DOWNTO 0);
            addr_o      : out std_logic_vector((mem_width-1) DOWNTO 0);
            intercept_o : out std_logic
    );
end fault_models;




architecture Behavioral of fault_models is
    TYPE   STATE_TYPE IS (STATE_IDLE, STATE_W0, STATE_R0_W1, STATE_R1_W0);
    signal state_sig    : STATE_TYPE;
    signal intercept_sig: std_logic;

begin
    process(clk_i, reset_i)
    begin
        if(reset_i='1') then                    -- reset (active high)
            state_sig       <= STATE_W0;
            intercept_sig   <= '0';
            addr_o         <= (others => '0');
        elsif(clk_i='1' AND clk_i'event) then   -- rising clock-edge
            addr_o  <= addr_i;

            case state_sig is
                when STATE_W0 =>
                    if(lfsr_end_i='1') then
                        state_sig   <= STATE_R0_W1;
                    end if;


                when STATE_R0_W1 =>
                    -- Stuck at 1 fault: not able to read the correct value at this address
                    if(addr_i = std_logic_vector(to_unsigned(stuck_fault_addr, addr_i'length))) then
                        intercept_sig   <= '1';
                    -- Address Faults: if this address is selected, write to another address
                    elsif(addr_i = std_logic_vector(to_unsigned(addr_fault_addr, addr_i'length))) then     -- memory cell with this address never will be accessed
                        addr_o          <= std_logic_vector(to_unsigned(addr_fault_new, addr_i'length));
                        intercept_sig   <= '1';
                    elsif(addr_i = std_logic_vector(to_unsigned(addr_fault_new, addr_i'length))) then
                        intercept_sig   <= '1';
                    else
                        intercept_sig   <= '0';
                    end if;

                    if(lfsr_end_i='1') then
                        state_sig   <= STATE_R1_W0;
                    end if;


                when STATE_R1_W0 =>
                    -- Stuck at 0 fault: not able to read the correct value at this address
                    if(addr_i = std_logic_vector(to_unsigned(stuck_fault_addr, addr_i'length))) then
                        intercept_sig   <= '1';
                    -- Transition fault -up transient -- not able to make transition from 1 to 0 at this address (for MATS++ test)
                    -- elsif(addr_i = std_logic_vector(to_unsigned(trans_fault_addr, addr_i'length))) then
                        -- intercept_sig   <= '1';
                    -- Stuck at 1 fault: memory cell with this address never will be accessed (for MATS++ test)
                    -- elsif(addr_i = std_logic_vector(to_unsigned(stuck_fault_addr, addr_i'length))) then
                        -- intercept_sig   <= '1';
                    else
                        intercept_sig   <= '0';
                    end if;

                    if(lfsr_end_i='1') then
                        state_sig   <= STATE_IDLE;
                    end if;


                when others =>
                    state_sig   <= STATE_IDLE;
            end case;
        end if;
    end process;

    intercept_o <= din_i XOR intercept_sig;

end Behavioral;