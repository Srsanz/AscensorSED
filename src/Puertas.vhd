

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Puertas is
Port (
        abrir_cerrar: in std_logic_vector (1 downto 0);
        clk: in std_logic_vector;        
        led: out std_logic_vector (15 downto 0)       
      );
      
end Puertas;

architecture Behavioral of Puertas is
begin


end Behavioral;
