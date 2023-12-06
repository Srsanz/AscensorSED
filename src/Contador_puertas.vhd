library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador_puertas is
        generic ( n_leds: integer := 8);
Port (
        abre_cierra: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        abierto_cerrado: out std_logic_vector(1 downto 0);
        count: out integer range 0 to n_leds
     );
end Contador_puertas;

architecture Behavioral of Contador_puertas is
signal count_i: integer range 0 to n_leds;
begin
process (clk)
begin
    if rising_edge(clk) then
        if abre_cierra = "01" and count_i /= n_leds then --abrir
            count_i <= (count_i + 1); 
        elsif abre_cierra ="10" and count_i/= 0 then --CERRAR
              count_i <= (count_i - 1); 
        end if;
    end if;
end process;
abierto_cerrado <= "01" when count_i=n_leds else
                   "10" when count_i=0 else
                   "00";
--count <= std_logic_vector(to_unsigned(count_i,count'length));                                       
count<= count_i;
end Behavioral;
