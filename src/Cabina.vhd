library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Cabina is
    Port ( 
        b0,b1,b2,b3,bemer: in std_logic;
        abre_cierra, sube_baja: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        an: in std_logic_vector(7 downto 0);
        piso_destino, piso, abierto_cerrado: out std_logic_vector(1 downto 0);
        emer: out std_logic;
        led: out std_logic_vector(15 downto 0);
        --led16,led17: out std_logic_vecor (2 downto 0);
        led16_r,led16_g,led16_b,led17_r,led17_g,led17_b: out std_logic;
        --segment: out std_logic_vector(7 donwto 0);
         ca, cb, cc, cd, ce, cf, cg: out std_logic       
        );
end Cabina; 

architecture Behavioral of Cabina is
begin
end architecture;