

                            ------------------------------------------------------------------
                            --      File:               controller.vhd                      --
                            --      Contains:           DIGILENT ZedBoard FPGA Application  --
                            --      Description:        Controller of the build-in self-test--
                            --      System:             ZedBoard (Rev D.2)                  --
                            --      FPGA:               XC7Z020-CLG484-1                    --
                            --      Clock:              100MHz                              --
                            --      IDE:                Vivado 2022.2 (x64)                 --
                            --      Date:               2023.01.08                          --
                            ------------------------------------------------------------------

library IEEE;                   -- use IEEE-library
use IEEE.STD_LOGIC_1164.ALL;    -- use default logic library
use IEEE.NUMERIC_STD.ALL;       -- use library for numeric-components


entity controller is
    Port(
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
end controller;



architecture Behavioral of controller is
    TYPE   STATE_TYPE IS (STATE_IDLE, STATE_W0, STATE_R0_W1, STATE_R1_W0, STATE_R1_W0_R0_A, STATE_R1_W0_R0_B);
    signal state_sig    : STATE_TYPE;


begin
    process(clk_i, reset_i)
    begin
        if(reset_i='1') then                    -- reset (active high)
            state_sig   <= STATE_W0;
            lfsr_dir_o  <= '1';
            lfsr_en_o   <= '0';
            lfsr_pause_o<= '0';
            mem_data_o  <= '0';
            mem_nominal_data_o  <= '0';
            mem_we_o    <= '0';
            running_test_o<= '0';
        elsif(clk_i='1' AND clk_i'event) then   -- rising clock-edge
            if(enable_i = '1') then     -- BIST is enabled

                if(sel_mpp_i = '0') then
--              ====== Test-Algorithm:  "MATS+" ======
                    case state_sig is
                        when STATE_W0 =>
                            running_test_o<= '1';
                            lfsr_dir_o  <= '1';
                            lfsr_en_o   <= '1';
                            mem_data_o  <= '0';
                            mem_we_o    <= '1';

                            if(lfsr_end_i='1') then
                                lfsr_dir_o  <= '1';
                                mem_nominal_data_o  <= '0';
                                mem_data_o  <= '1';
                                state_sig   <= STATE_R0_W1;
                            end if;


                        when STATE_R0_W1 =>

                            if(lfsr_end_i='1') then
                                lfsr_dir_o  <= '0';
                                mem_data_o  <= '0';
                                state_sig   <= STATE_R1_W0;
                            end if;


                        when STATE_R1_W0 =>
                            mem_nominal_data_o  <= '1';

                            if(lfsr_end_i='1') then
                                lfsr_en_o   <= '0';
                                state_sig   <= STATE_IDLE;
                            end if;


                        when others =>
                            mem_we_o    <= '0';
                            running_test_o<= '0';
                            state_sig   <= STATE_IDLE;
                    end case;
                else
--              ====== Test-Algorithm:  "MATS++" ======
                    case state_sig is
                        when STATE_W0 =>
                            running_test_o<= '1';
                            lfsr_dir_o  <= '1';
                            lfsr_en_o   <= '1';
                            mem_data_o  <= '0';
                            mem_we_o    <= '1';

                            if(lfsr_end_i='1') then
                                lfsr_dir_o  <= '1';
                                mem_nominal_data_o  <= '0';
                                mem_data_o  <= '1';
                                state_sig   <= STATE_R0_W1;
                            end if;


                        when STATE_R0_W1 =>

                            mem_nominal_data_o  <= '0';
                            if(lfsr_end_i='1') then
                                lfsr_dir_o  <= '0';
                                mem_data_o  <= '0';
                                state_sig   <= STATE_R1_W0_R0_A;
                                mem_nominal_data_o  <= '0';
                                lfsr_pause_o<= '1';
                                mem_we_o    <= '1';
                            end if;


                        when STATE_R1_W0_R0_A =>
                            lfsr_pause_o    <= '0';
                            mem_nominal_data_o  <= '1';
                            state_sig       <= STATE_R1_W0_R0_B;
                            mem_we_o        <= '0';


                        when STATE_R1_W0_R0_B =>
                            mem_nominal_data_o  <= '0';
                            if(lfsr_end_i='1') then
                                lfsr_en_o   <= '0';
                                state_sig   <= STATE_IDLE;
                            else
                                mem_data_o  <= '0';
                                state_sig   <= STATE_R1_W0_R0_A;
                                lfsr_pause_o<= '1';
                                mem_we_o    <= '1';
                            end if;


                        when others =>
                            mem_we_o    <= '0';
                            running_test_o<= '0';
                            state_sig   <= STATE_IDLE;
                    end case;
                end if;

            else    -- BIST is disabled
                state_sig       <= STATE_W0;
                lfsr_dir_o      <= '1';
                lfsr_en_o       <= '0';
                mem_data_o      <= '0';
                mem_nominal_data_o  <= '0';
                mem_we_o        <= '0';
                running_test_o  <= '0';
            end if;
        end if;
    end process;


end Behavioral;