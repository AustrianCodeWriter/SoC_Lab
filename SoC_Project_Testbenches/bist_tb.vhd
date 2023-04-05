

                            ------------------------------------------------------------------
                            --      File:               bist_tb.vhd                         --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Testbench for Top-entity            --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.01.08                          --
                            ------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic-library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components
use IEEE.MATH_REAL.ALL;         -- use library for mathematical functions


entity BIST_testbench is
end BIST_testbench;


architecture behavior of BIST_testbench is

    -- Definitions for Simulation
    -- Simulation-Time: about: 20ms
    --constant T_Period   : time := 100ns;     -- clock-period for 10MHz clock-input

    -- Simulation-Time: about: 1500000ns
    constant T_Period   : time := 10ns;     -- clock-period for 100MHz clock-input
    constant MEM_WIDTH  : integer := 15;    -- memory width


    -- Component Declaration for the Unit Under Test (UUT)
COMPONENT bist
Generic (
        mem_width   : integer := 15
        );

    Port(
        clk_i           : in  std_logic;
        reset_i         : in  std_logic;
        stop_on_err_i   : in  std_logic;
        continue_i      : in  std_logic;
        enable_i        : in  std_logic;
        sel_mpp_i       : in  std_logic;
        error_o         : out std_logic;
        addr_o          : out std_logic_vector((MEM_WIDTH-1) downto 0);
        running_o       : out std_logic);
END COMPONENT;


    -- Initial values for Inputs
    signal clk_i        : std_logic := '0';
    signal reset_i      : std_logic := '0';
    signal stop_on_err_i: std_logic := '1';
    signal continue_i   : std_logic := '0';
    signal enable_i     : std_logic := '0';
    signal sel_mpp_i    : std_logic := '0'; -- need to be changed to select the corresponding test (0... MATS+, 1... MATS++)


    -- Default values for Outputs
    signal error_o  : std_logic := '0';
    signal addr_o   : std_logic_vector((MEM_WIDTH-1) downto 0)  := (others => '0');
    signal running_o: std_logic := '0';


begin
    -- Connecting local signals with "Unit Under Test" (UUT)
UUT:    bist
Generic Map(
        mem_width => MEM_WIDTH)

    Port Map(
        clk_i           =>  clk_i,
        reset_i         =>  reset_i,
        stop_on_err_i   =>  stop_on_err_i,
        continue_i      =>  continue_i,
        enable_i        =>  enable_i,
        sel_mpp_i       =>  sel_mpp_i,
        error_o         =>  error_o,
        addr_o          =>  addr_o,
        running_o       =>  running_o);


    -- Definition of "clock"
    clk_i <= NOT clk_i after (T_Period/2);  -- toggle clock-pin each half period-time (1/(T_On+T_Off) = 100MHz)



    -- Stimulus process
stim:   process
    begin
        reset_i <= '1';
        wait for (T_Period);    -- reset
        reset_i <= '0';

        wait for (T_Period);
        enable_i<= '1';

        -- 1.Testcase
        wait for (T_Period);

        if(running_o = '1') then
            report "1.Test: Successful..."  severity note;
        else
            report "1.Test: Failed!" severity failure;
        end if;


        for i in 0 to (3*(2 ** MEM_WIDTH)) loop
            wait for (T_Period);

            if( (stop_on_err_i = '1') AND (error_o = '1')) then
                wait for (10*T_Period);
                continue_i <= '1';
                wait for (20*T_Period);
            end if;
        end loop;


        -- 2.Testcase
        -- wait for (3*(2 ** MEM_WIDTH)*T_Period);

        -- if(addr_o = "100000000000000") then
            -- report "2.Test: Successful..."  severity note;
        -- else
            -- report "2.Test: Failed!" severity failure;
        -- end if;

        report "... simulation successfully finished!" severity note;
        wait;
    END process;
END;