

                            ------------------------------------------------------------------
                            --      File:               lfsr_tb.vhd                         --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Testbench for LFSR                  --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.01.06                          --
                            ------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic-library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components
use IEEE.MATH_REAL.ALL;         -- use library for mathematical functions


entity lfsr_testbench is
end lfsr_testbench;


architecture behavior of lfsr_testbench is

    -- Definitions for Simulation
    constant T_Period   : time := 10ns;     -- clock-period for 100MHz clock-input
    constant MEM_WIDTH  : integer := 15;    -- memory width


    -- Component Declaration for the Unit Under Test (UUT)
COMPONENT lfsr
Generic (
        mem_width   : integer := 15
        );

    Port(
        clk_i   : in  std_logic;
        reset_i : in  std_logic;
        en_i    : in  std_logic;
        pause_i : in  std_logic;
        dir_up_i: in  std_logic;
        end_o   : out std_logic;
        addr_o  : out std_logic_vector((MEM_WIDTH-1) downto 0));
END COMPONENT;


    -- Initial values for Inputs
    signal clk_i    : std_logic := '0';
    signal reset_i  : std_logic := '0';
    signal en_i     : std_logic := '1';
    signal pause_i  : std_logic := '0';
    signal dir_up_i : std_logic := '1';

    -- Simulation signals
    signal addr_sim : std_logic_vector((MEM_WIDTH-1) downto 0)  := (others => '0');


    -- Default values for Outputs
    signal end_o    : std_logic := '0';
    signal addr_o   : std_logic_vector((MEM_WIDTH-1) downto 0)  := (others => '0');

begin
    -- Connecting local signals with "Unit Under Test" (UUT)
UUT:    lfsr
Generic Map(
        mem_width => MEM_WIDTH)

    Port Map(
        clk_i   =>  clk_i,
        reset_i =>  reset_i,
        en_i    =>  en_i,
        pause_i =>  pause_i,
        dir_up_i=>  dir_up_i,
        end_o   =>  end_o,
        addr_o  =>  addr_o);


    -- Definition of "clock"
    clk_i <= NOT clk_i after (T_Period/2);  -- toggle clock-pin each half period-time (1/(T_On+T_Off) = 100MHz)



    -- Stimulus process
stim:   process
    begin
        reset_i <= '1';
        wait for (T_Period);    -- reset
        reset_i <= '0';
        wait for (T_Period);

        -- 1.Testcase: pause signal pauses the LFSR
        wait for (20*T_Period);
        pause_i <= '1';
        wait for (5*T_Period);
        addr_sim <= addr_o;
        wait for (5*T_Period);

        if(addr_o = addr_sim) then
            report "1.Test: Successful..."  severity note;
        else
            report "1.Test: Failed!"        severity failure;
        end if;

        pause_i <= '0';


        -- 2.Testcase: end signal correctly reached
        wait for ((2 ** MEM_WIDTH)*T_Period-22*T_Period);
        assert(end_o = '1')     report "2.Test: Successful..."  severity note;
        assert(end_o /= '0')    report "2.Test: Failed!"        severity failure;

        -- 3.Testcase: Initial value equals seed after enabling
        wait for (T_Period);
        en_i        <= '0'; -- disable LFSR
        dir_up_i    <= '1';
        wait for (T_Period);

        if(addr_o = "100000000000000") then
            report "3.Test: Successful..."  severity note;
        else
            report "3.Test: Failed!"        severity failure;
        end if;

        -- 4.Testcase: Enable LFSR and check if "end" signal is still zero
        wait for (3*T_Period);
        en_i        <= '1'; -- enable LFSR
        wait for (T_Period);

        if(end_o = '0') then
            report "4.Test: Successful..."  severity note;
        else
            report "4.Test: Failed!"        severity failure;
        end if;

        report "... simulation successfully finished!" severity note;
        wait;
    END process;
END;