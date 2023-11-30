library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
port(
      btnu,btnr,btnd,btnl,btnc: in std_logic;
      ca, cb, cc, cd, ce, cf, cg: out std_logic;
      an: out std_logic_vector (7 downto 0);
      led16_B, led16_G, led16_R, led17_B, led17_g, led17_r: out std_logic;
      led: std_logic_vector(15 downto 0)
    );
end top;

architecture behavioral of top is
begin
end architecture;