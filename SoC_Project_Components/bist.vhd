

                            ------------------------------------------------------------------
                            --      File:               bist.vhd                            --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Top design of built-in self-test    --
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.03.05                          --
                            ------------------------------------------------------------------

library IEEE;                               -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;                -- use default logic library




entity bist is
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
            addr_o      : out std_logic_vector(14 downto 0);
            running_o   : out std_logic
        );
end bist;




architecture Behavioral of bist is
    signal lfsr_en_sig      : std_logic;
    signal lfsr_pause_sig   : std_logic;
    signal lfsr_end_sig     : std_logic;
    signal lfsr_dir_up_sig  : std_logic;
    signal mem_wr_unlock_sig: std_logic;
    signal mem_wr_sig       : std_logic;
    signal mem_addr_sig     : std_logic_vector((mem_width-1) downto 0);
    signal mem_nominal_data_sig : std_logic;
    signal mem_data_in_sig  : std_logic;
    signal test_running_sig : std_logic;
    signal error_flag_sig   : std_logic;
    signal error_sig        : std_logic;
    signal ctrl_pause_sig   : std_logic;
    signal intercept_dat_sig: std_logic;
    signal intercept_addr_sig   : std_logic_vector((mem_width-1) downto 0);



COMPONENT   lfsr
GENERIC (
            mem_width   : integer range 0 to 16
        );

    PORT(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            en_i        : in  std_logic;
            pause_i     : in  std_logic;
            dir_up_i    : in  std_logic;
            end_o       : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
END COMPONENT;


COMPONENT   controller
    PORT(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            enable_i    : in  std_logic;
            sel_mpp_i   : in  std_logic;
            lfsr_end_i  : in  std_logic;
            lfsr_en_o   : out std_logic;
            lfsr_pause_o: out std_logic;
            lfsr_dir_o  : out std_logic;
            mem_data_o  : out std_logic;
            mem_nominal_data_o  : out std_logic;
            mem_we_o    : out std_logic;
            running_test_o      : out std_logic
        );
END COMPONENT;


COMPONENT   faulty_memory
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
            we_i        : in  std_logic;
            addr_i      : in  std_logic_vector((mem_width-1) downto 0);
            data_i      : in  std_logic;
            data_o      : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
END COMPONENT;


COMPONENT   misr
GENERIC (
            mem_width   : integer range 0 to 16
        );

    PORT(
            clk_i       : in  std_logic;
            reset_i     : in  std_logic;
            hold_i      : in  std_logic;
            mem_nominal_data_i  : in  std_logic;
            mem_data_i  : in std_logic;
            addr_i      : in  std_logic_vector((mem_width-1) downto 0);
            error_o     : out std_logic;
            addr_o      : out std_logic_vector((mem_width-1) downto 0)
        );
END COMPONENT;



begin
D1:         lfsr
GENERIC MAP (
            mem_width   => mem_width
            )
PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_i,
            en_i        => lfsr_en_sig,
            pause_i     => lfsr_pause_sig,
            dir_up_i    => lfsr_dir_up_sig,
            end_o       => lfsr_end_sig,
            addr_o      => mem_addr_sig
        );


D2:         controller
PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_i,
            enable_i    => enable_i,
            sel_mpp_i   => sel_mpp_i,
            lfsr_end_i  => lfsr_end_sig,
            lfsr_en_o   => lfsr_en_sig,
            lfsr_pause_o=> ctrl_pause_sig,
            lfsr_dir_o  => lfsr_dir_up_sig,
            mem_data_o  => mem_data_in_sig,
            mem_nominal_data_o  => mem_nominal_data_sig,
            mem_we_o    => mem_wr_unlock_sig,
            running_test_o      => test_running_sig
        );


D3:         faulty_memory
GENERIC MAP (
            stuck_fault_addr    => 16#7FFD#,
            addr_fault_addr     => 16#71C7#,
            addr_fault_new      => 16#47FD#,
            trans_fault_addr    => 16#7F83#,
            mem_width   => mem_width
            )
PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_i,
            lfsr_end_i  => lfsr_end_sig,
            we_i        => mem_wr_sig,
            addr_i      => mem_addr_sig,
            data_i      => mem_data_in_sig,
            data_o      => intercept_dat_sig,
            addr_o      => intercept_addr_sig
        );


D4:         misr
GENERIC MAP (
            mem_width   => mem_width
            )
PORT MAP(
            clk_i       => clk_i,
            reset_i     => reset_i,
            hold_i      => lfsr_pause_sig,
            mem_nominal_data_i  => mem_nominal_data_sig,
            mem_data_i  => intercept_dat_sig,
            addr_i      => intercept_addr_sig,
            error_o     => error_sig,
            addr_o      => addr_o
        );


    lfsr_pause_sig  <= (stop_on_err_i AND error_flag_sig AND (NOT continue_i)) OR ctrl_pause_sig;
    running_o       <= test_running_sig;
    mem_wr_sig      <= mem_wr_unlock_sig AND (NOT lfsr_pause_sig);
    error_flag_sig  <= error_sig AND test_running_sig;
    error_o         <= error_flag_sig;

end Behavioral;