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
        --led16,led17: out std_logic_vecor (2 downto 0); usad lo que querais para programar. para asignar vector a señal fijaos en la botonera
        led16_r,led16_g,led16_b,led17_r,led17_g,led17_b: out std_logic;
        --segment: out std_logic_vector(7 donwto 0);  usad lo que querais para programar. para asignar vector a señal fijaos en la botonera
         ca, cb, cc, cd, ce, cf, cg: out std_logic       
        );
end Cabina; 

architecture Behavioral of Cabina is
component Botonera
port(
        b0,b1,b2,b3: in std_logic;
        piso_deseado: out std_logic_vector(1 downto 0)
    );
end component;
begin
piso_seleccion: botonera port map (b0 => b0, b1 => b1,b2 => b2, b3 => b3, piso_deseado => piso_destino);
end architecture;