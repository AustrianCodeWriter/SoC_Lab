

                            ------------------------------------------------------------------
                            --      File:               faulty_memory.vhd                   --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Block of fault-model and memory     --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.03.05                          --
                            ------------------------------------------------------------------

library IEEE;                   -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic library
use IEEE.MATH_REAL.ALL;         -- use library for mathematical functions


entity faulty_memory is
    generic(
            stuck_fault_addr: integer range 0 to 32768;
            addr_fault_addr : integer range 0 to 32768;
            addr_fault_new  : integer range 0 to 32768;
            trans_fault_addr: integer range 0 to 32768;
            mem_width       : integer range 0 to 16
    );

    Port(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            lfsr_end_i  : in  std_logic;
            we_i        : in  std_logic;
            addr_i      : in std_logic_vector((mem_width-1) downto 0);
            data_i      : in  std_logic;
            data_o      : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
end faulty_memory;



architecture Behavioral of faulty_memory is
    signal mem_data_out_sig : std_logic;


COMPONENT   blk_mem_gen_0
    PORT(
            clka        : in  std_logic;
            wea         : in  std_logic_vector(0 DOWNTO 0);
            addra       : in  std_logic_vector((mem_width-1) DOWNTO 0);
            dina        : in  std_logic_vector(0 DOWNTO 0);
            douta       : out std_logic_vector(0 DOWNTO 0)
        );
END COMPONENT;


COMPONENT   fault_models
GENERIC (
            stuck_fault_addr: integer range 0 to (2 ** mem_width)-1;
            addr_fault_addr : integer range 0 to (2 ** mem_width)-1;
            addr_fault_new  : integer range 0 to (2 ** mem_width)-1;
            trans_fault_addr: integer range 0 to (2 ** mem_width)-1;
            mem_width       : integer range 0 to 16
        );

    PORT(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            lfsr_end_i  : in  std_logic;
            din_i       : in  std_logic;
            addr_i      : in  std_logic_vector((mem_width-1) DOWNTO 0);
            addr_o      : out std_logic_vector((mem_width-1) DOWNTO 0);
            intercept_o : out std_logic
        );
END COMPONENT;



begin
Mem1:       blk_mem_gen_0
PORT MAP(
            clka        => clk_i,
            wea(0)      => we_i,
            addra       => addr_i,
            dina(0)     => data_i,
            douta(0)    => mem_data_out_sig
        );


Fault1:     fault_models
GENERIC MAP (
            stuck_fault_addr    => stuck_fault_addr,
            addr_fault_addr     => addr_fault_addr,
            addr_fault_new      => addr_fault_new,
            trans_fault_addr    => trans_fault_addr,
            mem_width   => mem_width
            )
PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_i,
            lfsr_end_i  => lfsr_end_i,
            din_i       => mem_data_out_sig,
            addr_i      => addr_i,
            addr_o      => addr_o,
            intercept_o => data_o
        );
end Behavioral;