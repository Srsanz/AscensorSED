library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity deco_puertas_tb is
end deco_puertas_tb;

architecture tb_architecture of deco_puertas_tb is
signal count_tb: integer range 0 to 8:=0;
signal led_tb: std_logic_vector(15 downto 0);

begin
uut: entity work.deco_puertas
    generic map (n_leds => 8)
    Port map(
            count => count_tb,
            led => led_tb
         );
process
begin
    count_tb <= 0;
    wait for 10 ns;
    assert led_tb = "1111111111111111" report "Error en el Test 0" severity failure;

    count_tb <= 1;
    wait for 10 ns;
    assert led_tb = "1111111001111111" report "Error en el Test 1" severity failure;
    
    count_tb <= 2;
    wait for 10 ns;
    assert led_tb = "1111110000111111" report "Error en el Test 2" severity failure;
    
    count_tb <= 3;
    wait for 10 ns;
    assert led_tb = "1111100000011111" report "Error en el Test 3" severity failure;
    
    count_tb <= 4;
    wait for 10 ns;
    assert led_tb = "1111000000001111" report "Error en el Test 4" severity failure;
    
    count_tb <= 5;
    wait for 10 ns;
    assert led_tb = "1110000000000111" report "Error en el Test 5" severity failure;
    
    count_tb <= 6;
    wait for 10 ns;
    assert led_tb = "1100000000000011" report "Error en el Test 6" severity failure;
    
    count_tb <= 7;
    wait for 10 ns;
    assert led_tb = "1000000000000001" report "Error en el Test 7" severity failure;
    
    count_tb <= 8;
    wait for 10 ns;
    assert led_tb = "0000000000000000" report "Error en el Test 8" severity failure;
    
    assert false -- Forzar fallo
    report "[SUCCESS]: Fin Test"
    severity failure;
wait;
end process;
end tb_architecture;
