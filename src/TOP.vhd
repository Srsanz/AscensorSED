library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
port(
      btnu,btnr,btnd,btnl,btnc, clk: in std_logic;
      ca, cb, cc, cd, ce, cf, cg: out std_logic;
      reset: in std_logic; --MIRAR ESTO
      an: out std_logic_vector (0 to 7);
      led16_B, led16_G, led16_R, led17_B, led17_g, led17_r: out std_logic;
      led: out std_logic_vector(15 downto 0)
    );
end top;

architecture behavioral of top is
component cabina
      Port ( 
        b0,b1,b2,b3,bemer: in std_logic;
        abre_cierra, sube_baja: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        an: in std_logic_vector(0 to 7);
        reset: in std_logic;
        piso_destino, piso, abierto_cerrado: out std_logic_vector(1 downto 0);
        emer: out std_logic;
        led: out std_logic_vector(15 downto 0);       
        led16_r, led16_g,led16_b,led17_r,led17_g,led17_b: out std_logic;       
         ca, cb, cc, cd, ce, cf, cg: out std_logic       
        );
end component;
--component fms
signal orden_puerta: std_logic_vector (1 downto 0);
signal destino: std_logic_vector (1 downto 0);
signal movimiento: std_logic_vector (1 downto 0);
signal estado_puerta: std_logic_vector (1 downto 0);
signal display_select: std_logic_vector (0 to 7);
signal emer_i: std_logic;
begin
Cabin_inst: cabina port map (b0 => btnu, b1 => btnr, b2 => btnd, b3 => btnl, bemer => btnc,
abre_cierra => orden_puerta, sube_baja => movimiento, clk=> clk, an => display_select, piso_destino=> destino,abierto_cerrado => estado_puerta, emer => emer_i,
 led => led, led16_r=>led16_r, led16_g => led16_g, led16_b=>led16_b, led17_r => led17_r,led17_g=>led17_g,led17_b =>led17_b,
ca => ca, cb => cb, cc => cc, cd => cd, ce => ce, cf => cf, cg => cg, reset => reset); 
-- fms_inst: fms port map ();
end architecture;