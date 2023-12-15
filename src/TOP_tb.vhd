library IEEE;
library work;
use work.simulacion.all;
use work.reloj.all;
use IEEE.STD_LOGIC_1164.ALL;


entity TOP_tb is
--  Port ( );
end TOP_tb;

architecture Behavioral of TOP_tb is
    component TOP
        port(
            BTNU,BTNR,BTND,BTNL,BTNC, CLK100MHZ: in std_logic;
            CA, CB, CC, CD, CE, CF, CG: out std_logic;
            CPU_RESETN: in std_logic; --MIRAR ESTO
            AN: out std_logic_vector (0 to 7);
            LED16_B, LED16_G, LED16_R, LED17_B, LED17_G, LED17_R: out std_logic;
            LED: out std_logic_vector(15 downto 0)
        );
    end component;
    signal BTNU_tb,BTNR_tb,BTND_tb,BTNL_tb,BTNC_tb, CLK100MHZ_tb: std_logic;
    signal CA_tb, CB_tb, CC_tb, CD_tb, CE_tb, CF_tb, CG_tb: std_logic;
    signal CPU_RESETN_tb: std_logic;
    signal AN_tb: std_logic_vector (0 to 7);
    signal LED16_B_tb, LED16_G_tb, LED16_R_tb, LED17_B_tb, LED17_G_tb, LED17_R_tb: std_logic;
    signal LED_tb: std_logic_vector(15 downto 0);
    constant clk_period: time:= 10 ns;
begin
    uut: TOP port map(
        BTNU => BTNU_tb, BTNR => BTNR_tb, BTND => BTND_tb, BTNL => BTNL_tb, BTNC => BTNC_tb,
        CLK100MHZ => CLK100MHZ_tb,
        CA => CA_tb, CB => CB_tb, CC => CC_tb, CD => CD_tb, CE => CE_tb, CF => CF_tb, CG => CG_tb,
        CPU_RESETN => CPU_RESETN_tb,
        AN => AN_tb,
        LED16_B => LED16_B_tb, LED16_G => LED16_G_tb, LED16_R => LED16_R_tb, 
        LED17_B => LED17_B_tb, LED17_G => LED17_G_tb, LED17_R => LED17_R_tb,
        LED => LED_tb
    );

    periodo(CLK100MHZ_tb, clk_period);
    

end Behavioral;
