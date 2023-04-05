

                            ------------------------------------------------------------------
                            --      File:               misr.vhd                            --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Multiple Input Signature Register   --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.01.08                          --
                            ------------------------------------------------------------------

library IEEE;                   -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components



entity misr is
    generic(
            mem_width     : integer range 0 to 16 := 15
    );

    Port(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            hold_i      : in  std_logic;
            mem_nominal_data_i  : in  std_logic;
            mem_data_i  : in  std_logic;
            addr_i      : in  std_logic_vector((mem_width-1) downto 0);
            error_o     : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
end misr;



architecture Behavioral of misr is

begin
    process(clk_i, reset_i)
    begin
        if(reset_i='1') then                    -- reset (active high)
            error_o     <= '0';
            addr_o      <= (others => '0');
        elsif(clk_i='1' AND clk_i'event) then   -- rising clock-edge
            if(hold_i /= '1') then
                addr_o  <= addr_i;
            end if;

            error_o <= (mem_nominal_data_i XOR mem_data_i) OR hold_i;
        end if;
    end process;

end Behavioral;