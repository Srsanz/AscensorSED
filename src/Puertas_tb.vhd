library ieee;
use IEEE.STD_LOGIC_1164.ALL;


entity Puertas_tb is

end Puertas_tb;

architecture Behavioral of Puertas_tb is
signal abrir_cerrar_tb: std_logic_vector (1 downto 0):="00";
signal abierto_cerrado_tb: std_logic_vector (1 downto 0):="10";
signal strobe_1_tb, clk_tb: std_logic:= '0' ;
signal led_tb: std_logic_vector (15 downto 0);
constant CLOCK_PERIOD   : time := 20 ns;

begin
uut: entity work.Puertas
        generic map (n_leds => 8)
Port map (
        abrir_cerrar => abrir_cerrar_tb,
        clk => clk_tb, strobe_1 => strobe_1_tb,        
        abierto_cerrado => abierto_cerrado_tb,
        led => led_tb       
      );
    clk_process: process
    begin
            clk_tb <= '0';
            wait for CLOCK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLOCK_PERIOD / 2;
    end process;
    
    -- STROBE PROCESS
    STROBE_1_PROCESS : PROCESS
    BEGIN
        for i in 1 to 10 loop
          wait until clk_tb = '1';
         end loop;
        STROBE_1_tb <= NOT STROBE_1_tb;
    END PROCESS STROBE_1_PROCESS;     

stimulus_process:process
begin
wait for clock_period/2;

while abierto_cerrado_tb /= "01" loop
            abrir_cerrar_tb <= "01";
            wait for clock_period;
end loop;
assert abierto_cerrado_tb = "01" report "Error apertura" severity failure;

while abierto_cerrado_tb /= "10" loop
            abrir_cerrar_tb <= "10";
            wait for CLOCK_PERIOD;
        end loop;
assert abierto_cerrado_tb = "10" report "Error en la apertura" severity failure;

for i in 1 to 10 loop
          wait until clk_tb = '1';
end loop;

assert false
           report "[SUCCESS]: Fin Test"
           severity failure;

end process;
end Behavioral;
