

                            ------------------------------------------------------------------
                            --      File:               design_top.vhd                      --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Top design of the design            --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.02.18                          --
                            ------------------------------------------------------------------

library IEEE;                               -- use IEEE-library
use IEEE.std_logic_1164.ALL;                -- use default logic library




entity design_top is
    PORT(
            clk_i       : in  std_logic;
            BTNC        : in  std_logic;    -- BTNC works as (active high) reset-button
            LED         : out std_logic_vector(0 downto 0);

            DDR_addr    : inout std_logic_vector(14 downto 0);
            DDR_ba      : inout std_logic_vector(2 downto 0);
            DDR_cas_n   : inout std_logic;
            DDR_ck_n    : inout std_logic;
            DDR_ck_p    : inout std_logic;
            DDR_cke     : inout std_logic;
            DDR_cs_n    : inout std_logic;
            DDR_dm      : inout std_logic_vector(3 downto 0);
            DDR_dq      : inout std_logic_vector(31 downto 0);
            DDR_dqs_n   : inout std_logic_vector(3 downto 0);
            DDR_dqs_p   : inout std_logic_vector(3 downto 0);
            DDR_odt     : inout std_logic;
            DDR_ras_n   : inout std_logic;
            DDR_reset_n : inout std_logic;
            DDR_we_n    : inout std_logic;
            FIXED_IO_ddr_vrn    : inout std_logic;
            FIXED_IO_ddr_vrp    : inout std_logic;
            FIXED_IO_mio        : inout std_logic_vector(53 downto 0);
            FIXED_IO_ps_clk     : inout std_logic;
            FIXED_IO_ps_porb    : inout std_logic;
            FIXED_IO_ps_srstb   : inout std_logic
        );
end design_top;




architecture Behavioral of design_top is
    constant MEM_WIDTH  : integer range 0 to 16 := 15;

    signal en_sig       : std_logic;
    signal err_sig      : std_logic;
    signal addr_sig     : std_logic_vector((MEM_WIDTH-1) downto 0);
    signal running_sig  : std_logic;
    signal continue_sig : std_logic;
    signal reset_sig    : std_logic;
    signal rst_fb_sig   : std_logic;
    signal sel_mpp_sig  : std_logic;


COMPONENT   bist
GENERIC (
            mem_width   : integer range 0 to 16 := 15
        );

    PORT(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            stop_on_err_i   : in  std_logic;
            continue_i  : in  std_logic;
            enable_i    : in  std_logic;
            sel_mpp_i   : in  std_logic;
            error_o     : out std_logic;
            addr_o      : out std_logic_vector((MEM_WIDTH-1) downto 0);
            running_o   : out std_logic
        );
END COMPONENT;


COMPONENT   zynq_block is
    PORT(
            DDR_addr    : inout std_logic_vector((MEM_WIDTH-1) downto 0);
            DDR_ba      : inout std_logic_vector(2 downto 0);
            DDR_cas_n   : inout std_logic;
            DDR_ck_n    : inout std_logic;
            DDR_ck_p    : inout std_logic;
            DDR_cke     : inout std_logic;
            DDR_cs_n    : inout std_logic;
            DDR_dm      : inout std_logic_vector(3 downto 0);
            DDR_dq      : inout std_logic_vector(31 downto 0);
            DDR_dqs_n   : inout std_logic_vector(3 downto 0);
            DDR_dqs_p   : inout std_logic_vector(3 downto 0);
            DDR_odt     : inout std_logic;
            DDR_ras_n   : inout std_logic;
            DDR_reset_n : inout std_logic;
            DDR_we_n    : inout std_logic;
            FIXED_IO_ddr_vrn    : inout std_logic;
            FIXED_IO_ddr_vrp    : inout std_logic;
            FIXED_IO_mio        : inout std_logic_vector(53 downto 0);
            FIXED_IO_ps_clk     : inout std_logic;
            FIXED_IO_ps_porb    : inout std_logic;
            FIXED_IO_ps_srstb   : inout std_logic;
            GPIO_0_0_tri_i      : in std_logic_vector(21 downto 0);
            GPIO_0_0_tri_o      : out std_logic_vector(21 downto 0);
            GPIO_0_0_tri_t      : out std_logic_vector(21 downto 0)
    );
END COMPONENT;



begin
B1:         bist
GENERIC MAP (
            mem_width   => MEM_WIDTH
            )

PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_sig,
            stop_on_err_i   => '1',
            continue_i  => continue_sig,
            enable_i    => en_sig,
            sel_mpp_i   => sel_mpp_sig,
            error_o     => err_sig,
            addr_o      => addr_sig,
            running_o   => running_sig
        );


ZYNQ: component zynq_block
PORT MAP(
            DDR_addr            => DDR_addr,
            DDR_ba              => DDR_ba,
            DDR_cas_n           => DDR_cas_n,
            DDR_ck_n            => DDR_ck_n,
            DDR_ck_p            => DDR_ck_p,
            DDR_cke             => DDR_cke,
            DDR_cs_n            => DDR_cs_n,
            DDR_dm              => DDR_dm,
            DDR_dq              => DDR_dq,
            DDR_dqs_n           => DDR_dqs_n,
            DDR_dqs_p           => DDR_dqs_p,
            DDR_odt             => DDR_odt,
            DDR_ras_n           => DDR_ras_n,
            DDR_reset_n         => DDR_reset_n,
            DDR_we_n            => DDR_we_n,
            FIXED_IO_ddr_vrn    => FIXED_IO_ddr_vrn,
            FIXED_IO_ddr_vrp    => FIXED_IO_ddr_vrp,
            FIXED_IO_mio        => FIXED_IO_mio,
            FIXED_IO_ps_clk     => FIXED_IO_ps_clk,
            FIXED_IO_ps_porb    => FIXED_IO_ps_porb,
            FIXED_IO_ps_srstb   => FIXED_IO_ps_srstb,
            -- 21 20 . 19 18 17 16 . 15 14 13 12 . 11 10 9 8 . 7 6 5 4 . 3 2 1 0
            --  |  |    |  |  |  |    |  |                                     |
            --  |  |    |  |  |  |    |  +------------------+------------------+
            --  |  |    |  |  |  |    |                     |
            --  |  |    |  |  |  |    |                     +---- Address [Zynq-Input]
            --  |  |    |  |  |  |    +-------------------------- Running [Zynq-Input]
            --  |  |    |  |  |  +------------------------------- Error   [Zynq-Input]
            --  |  |    |  |  +---------------------------------- Enable  [Zynq-Output]
            --  |  |    |  +------------------------------------- LD0     [Zynq-Output]
            --  |  |    +---------------------------------------- Reset-Button (BTNC) [Zynq-Input]
            --  |  +--------------------------------------------- Continue [Zynq-Output]
            --  +------------------------------------------------ Select MATS++ Test [Zynq-Output]
            GPIO_0_0_tri_i(21)  => '0',
            GPIO_0_0_tri_i(20)  => '0',
            GPIO_0_0_tri_i(19)  => reset_sig,
            GPIO_0_0_tri_i(18)  => '0',
            GPIO_0_0_tri_i(17)  => '0',
            GPIO_0_0_tri_i(16)  => err_sig,
            GPIO_0_0_tri_i(15)  => running_sig,
            GPIO_0_0_tri_i((MEM_WIDTH-1) downto 0)  => addr_sig,
            GPIO_0_0_tri_t      => open,
            GPIO_0_0_tri_o(21)  => sel_mpp_sig,
            GPIO_0_0_tri_o(20)  => continue_sig,
            GPIO_0_0_tri_o(19)  => rst_fb_sig,
            GPIO_0_0_tri_o(18)  => LED(0),
            GPIO_0_0_tri_o(17)  => en_sig,
            GPIO_0_0_tri_o(16 downto 0) => open
        );


    reset_sig   <= BTNC OR rst_fb_sig;

end Behavioral;