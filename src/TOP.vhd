library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
port(
      btnu,btnr,btnd,btnl,btnc, clk: in std_logic;
      ca, cb, cc, cd, ce, cf, cg: out std_logic;
      an: out std_logic_vector (7 downto 0);
      led16_B, led16_G, led16_R, led17_B, led17_g, led17_r: out std_logic;
      led: std_logic_vector(15 downto 0)
    );
end top;

architecture behavioral of top is
component cabina
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
end component;
--component fms
signal orden_puerta, movimiento, estado_puerta, destino: std_logic_vector (1 downto 0);
begin
Cabina: cabina port map (b0 => btnu, b1 => btnr, b2 => btnd =>, b3 => btnl , bemer => btnc,
abre_cierra => orden_puerta, sube_baja => movimiento, clk=> clk, an => an, piso_destino=> destino,
abierto_cerrado => estado_puerta, emer => btnc, led => led, led_16_r=>led_16_r, led_16_g =>  led_16_g, 
led_16_b=>led_16_b, led_17_r => led_17_r,led_17_g=>led_17_g,led_17_b=>led_17_b,
ca => ca, cb=> cb, cc=> cc, cd=> cd, ce=>ce, cf=> cf, cg=> cg); --Hay que instanciarlo bien. me voy a dormir.crear un vector de an que coja todos los displays de 7 segmentos y elegir cual esta encendido para que se muestre en la fpga el piso actual. Osease, establecer todos a 1 (creo que es activo a nivel bajo) y el que se quiera usar a 0
-- fms: fms port map ();
end architecture;