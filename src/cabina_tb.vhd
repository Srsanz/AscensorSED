library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.strobe_generation.all;
entity cabina_tb is
end cabina_tb;

architecture Behavioral of cabina_tb is
component Cabina
    Port ( 
        b0,b1,b2,b3,bemer: in std_logic;
        abre_cierra, sube_baja: in std_logic_vector(1 downto 0);
        clk, strobe_1, strobe_2: in std_logic;
        reset: in std_logic;
        an: in std_logic_vector(7 downto 0);
        piso_destino, piso, abierto_cerrado: out std_logic_vector(1 downto 0);
        emer: out std_logic;
        led: out std_logic_vector(15 downto 0);
        led16_r,led16_g,led16_b,led17_r,led17_g,led17_b: out std_logic;
         ca, cb, cc, cd, ce, cf, cg: out std_logic       
        );
end component;

signal b0_tb:std_logic := '0';
signal b1_tb: std_logic := '0';
signal b2_tb: std_logic := '0'; 
signal b3_tb: std_logic := '0'; 
signal bemer_tb: std_logic := '0'; 
signal abre_cierra_tb, sube_baja_tb: std_logic_vector (1 downto 0) := "00";
signal reset_tb: std_logic := '0';
signal clk_tb: std_logic := '0';
signal strobe_1_tb, strobe_2_tb: std_logic := '0';
signal an_tb: std_logic_vector(7 downto 0) := "11111110";
signal piso_destino_tb, piso_tb: std_logic_vector(1 downto 0);
signal abierto_cerrado_tb: std_logic_vector(1 downto 0):="10";
signal led_tb: std_logic_vector(15 downto 0);
signal led16_r_tb, led16_g_tb, led16_b_tb, led17_r_tb, led17_g_tb, led17_b_tb: std_logic;
signal ca_tb, cb_tb, cc_tb, cd_tb, ce_tb, cf_tb, cg_tb: std_logic;
signal emer_tb: std_logic;
constant CLOCK_PERIOD   : time := 20 ns;
begin
    uut: cabina port map(
                    b0 => b0_tb,
                    b1 => b1_tb,
                    b2 => b2_tb,
                    b3 => b3_tb,
                    bemer => bemer_tb,
                    abre_cierra=> abre_cierra_tb,
                    sube_baja => sube_baja_tb,
                    clk => clk_tb,
                    strobe_1 => strobe_1_tb,
                    strobe_2 => strobe_2_tb,
                    an => an_tb,
                    piso_destino => piso_destino_tb,
                    piso => piso_tb,
                    reset => reset_tb,
                    abierto_cerrado=>abierto_cerrado_tb,
                    emer=>emer_tb,
                    led=>led_tb,
                    led16_r=>led16_r_tb,
                    led16_g=>led16_g_tb,
                    led16_b=>led16_b_tb,
                    led17_r=>led17_r_tb,
                    led17_g=>led17_g_tb,
                    led17_b=>led17_b_tb,
                    ca=>ca_tb,
                    cb=>cb_tb,
                    cc=>cc_tb,
                    cd=>cd_tb,
                    ce=>ce_tb,
                    cf=>cf_tb,
                    cg=>cg_tb
                    );
    
     CLK_PROCESS : PROCESS
    BEGIN
        WAIT FOR clock_period/2; -- Adjust the clock period as needed
        clk_tb <= NOT clk_tb;
    END PROCESS CLK_PROCESS;
    
       
    
  stimulus_process: process
begin
    -- abierto_cerrado_tb <= "10"; -- Cambiado de "10" a "01"
    b0_tb <= '0';
    b1_tb <= '0';
    b2_tb <= '0';
    b3_tb <= '0';
    bemer_tb <= '0';
    abre_cierra_tb <= "00";
    sube_baja_tb <= "00";
    an_tb <= "11111110";
    wait for clock_period/2;
    
    reset_tb<='1';
    
    wait for clock_period;
    b1_tb<='1';
    sube_baja_tb<="00";
    abre_cierra_tb<="01";
    while abierto_cerrado_tb /= "01" loop
            abre_cierra_tb <= "01";
    wait for clock_period;
    end loop;
    assert abierto_cerrado_tb<="01" report "error al cerrar" severity failure;    
    sube_baja_tb<="10";
    abre_cierra_tb<="00";
    wait for clock_period;
    
    while piso_tb /= "01" loop
        sube_baja_tb<= "10";
    wait for clock_period;
    end loop;
    --sube_baja_tb<="00";

    --wait for clock_period;
    assert piso_tb<="01" report "error al subir" severity failure;    

    
    -- assert piso_tb<="01" report "error en el piso" severity failure;
    
    -- wait for 20 ns;
    
end process;

        
          
        
    
end Behavioral;
