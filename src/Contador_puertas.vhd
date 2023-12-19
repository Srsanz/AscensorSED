library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador_puertas is
        generic ( n_leds: integer := 8);
Port (
        reset_n : in std_logic;
        abre_cierra: in std_logic_vector(1 downto 0);
        clk, strobe_1: in std_logic;
        abierto_cerrado: out std_logic_vector(1 downto 0);
        count: out integer range 0 to n_leds
     );
end Contador_puertas;

architecture Behavioral of Contador_puertas is
    signal count_i: integer range 0 to n_leds:= n_leds;
    signal en_i   : std_logic;
begin
    process (clk, reset_n)
    begin
        if reset_n = '0' then
            count_i <= n_leds;
        elsif rising_edge(clk) then
      if strobe_1 = '1' then
        if abre_cierra = "10"  then
            if count_i /= n_leds then --abrir
                count_i <= count_i + 1;
            end if;    
        elsif abre_cierra ="01" then
            if count_i/= 0 then  --CERRAR
                count_i <= count_i - 1;
            end if;     
        end if;
      end if;
    end if;
end process;
abierto_cerrado <= "10" when count_i = n_leds else
                   "01" when count_i =      0 else
                   "00";
--count <= std_logic_vector(to_unsigned(count_i,count'length));                                       
count <= count_i;
end Behavioral;
