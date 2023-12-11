library ieee;
use ieee.std_logic_1164.all;

entity reg_en is
Port (
        clk, strobe: in std_logic;
        EN: out std_logic
     );
end reg_en;

architecture Behavioral of reg_en is
signal valor_actual, valor_anterior: std_logic;
begin

process (clk)
begin
    if rising_edge(clk) then
        valor_anterior <= valor_actual;
        valor_actual <= strobe;   
    end if;      
end process;
en <= '1' when valor_actual = '1' and valor_anterior = '0' else '0';
end Behavioral;
