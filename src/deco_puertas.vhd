library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco_puertas is
    generic (n_leds: integer:= 8);
    Port (
            count: in integer range 0 to n_leds;
            led: out std_logic_vector(15 downto 0)
         );
end deco_puertas;

architecture dataflow of deco_puertas is
begin
with count select
    led <= "1111111111111111" when 0,
           "1111111001111111" when 1,
           "1111110000111111" when 2,
           "1111100000011111" when 3,
           "1111000000001111" when 4,
           "1110000000000111" when 5,
           "1100000000000011" when 6,
           "1000000000000001" when 7,
           "0000000000000000" when others;   
end dataflow;
