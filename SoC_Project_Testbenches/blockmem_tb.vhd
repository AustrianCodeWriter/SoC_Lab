

                            ------------------------------------------------------------------
                            --      File:               blockmem_tb.vhd                     --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Testbench for LFSR                  --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.02.27                          --
                            ------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic-library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components
use IEEE.MATH_REAL.ALL;         -- use library for mathematical functions


entity blockmem_testbench is
end blockmem_testbench;


architecture behavior of blockmem_testbench is

    -- Definitions for Simulation
    constant T_Period   : time      := 10ns;-- clock-period for 100MHz clock-input
    constant MEM_WIDTH  : integer   := 15;  -- memory width


    -- Component Declaration for the Unit Under Test (UUT)
COMPONENT blk_mem_gen_0
    Port(
        clka    : in  std_logic;
        wea     : in  std_logic_vector(0 downto 0);
        addra   : in  std_logic_vector((MEM_WIDTH-1) downto 0);
        dina    : in  std_logic_vector(0 downto 0);
        douta   : out std_logic_vector(0 downto 0));
END COMPONENT;


    -- Initial values for Inputs
    signal clka     : std_logic := '0';
    signal wea      : std_logic_vector(0 downto 0)  := (others => '0');
    signal addra    : std_logic_vector((MEM_WIDTH-1) downto 0)  := (others => '0');
    signal dina     : std_logic_vector(0 downto 0)  := (others => '0');


    -- Default values for Outputs
    signal douta    : std_logic_vector(0 downto 0)  := (others => '0');


begin
    -- Connecting local signals with "Unit Under Test" (UUT)
UUT:    blk_mem_gen_0
    Port Map(
        clka    =>  clka,
        wea     =>  wea,
        addra   =>  addra,
        dina    =>  dina,
        douta   =>  douta);


    -- Definition of "clock"
    clka <= NOT clka after (T_Period/2);  -- toggle clock-pin each half period-time (1/(T_On+T_Off) = 100MHz)



    -- Stimulus process
stim:   process
    begin

        -- wea(0)  <= '1';

        -- dina(0) <= '0';
        -- wait for(T_Period*1.5);
        -- addra <= "111111111111110";
        -- wait for(T_Period);

        -- dina(0) <= '1';
        -- wait for(2*T_Period);

        -- dina(0) <= '0';
        -- wait for(4*T_Period);

        -- dina(0) <= '1';
        -- wait for(2*T_Period);

        -- dina(0) <= '0';
        -- wait for(4*T_Period);


        wea(0)  <= '1';

    --  Testing: STATE_W0
        dina(0) <= '0';
        wait for(T_Period*1.5);

        for tmpIndex in 0 to (2 ** MEM_WIDTH)-1 loop
            addra <= std_logic_vector(to_unsigned(tmpIndex, MEM_WIDTH));
            if(douta(0) /= '0') then
                report "1.Test (STATE_W0): Failed!"     severity failure;
            end if;
            wait for(2*T_Period);
        end loop;
        report "1.Test (STATE_W0): Finished"  severity note;

    --  Testing: STATE_R0_W1
        dina(0) <= '1';
        wait for(T_Period);

        for tmpIndex in 0 to (2 ** MEM_WIDTH)-1 loop
            addra <= std_logic_vector(to_unsigned(tmpIndex, MEM_WIDTH));
            if(douta(0) /= '0') then
                report "2.Test (STATE_R0_W1): Failed!"  severity failure;
            end if;
            wait for(T_Period);
        end loop;
        report "2.Test (STATE_R0_W1): Finished"  severity note;

    --  Testing: STATE_R1_W0
        dina(0) <= '0';
        wait for(T_Period);

        for tmpIndex in 0 to (2 ** MEM_WIDTH)-1 loop
            addra <= std_logic_vector(to_unsigned(tmpIndex, MEM_WIDTH));
            if(douta(0) /= '1') then
                report "3.Test (STATE_R1_W0): Failed!"  severity failure;
            end if;
            wait for(T_Period);
        end loop;
        report "3.Test (STATE_R1_W0): Finished"  severity note;

        report "... simulation successfully finished!" severity note;
        wait;
    END process;
END;