library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
port(
      BTNU,BTNR,BTND,BTNL,BTNC, CLK100MHZ: in std_logic;
      CA, CB, CC, CD, CE, CF, CG: out std_logic;
      CPU_RESETN: in std_logic; --MIRAR ESTO
      AN: out std_logic_vector (0 to 7);
      LED16_B, LED16_G, LED16_R, LED17_B, LED17_G, LED17_R: out std_logic;
      LED: out std_logic_vector(15 downto 0)
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

component fsm
    port(
        clk, emer, reset: in std_logic;
        piso_actual, abierto_cerrado, piso_dest: in std_logic_vector (1 downto 0);
        abre_cierra, sube_baja: out std_logic_vector (1 downto 0)
        );
end component;
--component fms
signal orden_puerta: std_logic_vector (1 downto 0);
signal destino: std_logic_vector (1 downto 0);
signal movimiento: std_logic_vector (1 downto 0);
signal estado_puerta: std_logic_vector (1 downto 0);
signal display_select: std_logic_vector (0 to 7);
signal piso_i: std_logic_vector (1 downto 0);
signal emer_i: std_logic;
begin
Cabina_inst: cabina port map (b0 => btnu, b1 => btnr, b2 => btnd, b3 => btnl, bemer => btnc, piso => piso_i,
abre_cierra => orden_puerta, sube_baja => movimiento, clk=> CLK100MHZ, an => display_select, piso_destino=> destino, abierto_cerrado => estado_puerta, emer => emer_i,
 led => led, led16_r=>led16_r, led16_g => led16_g, led16_b=>led16_b, led17_r => led17_r,led17_g=>led17_g,led17_b =>led17_b,
ca => ca, cb => cb, cc => cc, cd => cd, ce => ce, cf => cf, cg => cg, reset => CPU_RESETN); 
fms_inst: fsm port map (
                clk => CLK100MHZ,
                piso_actual => piso_i,
                abierto_cerrado => estado_puerta,
                emer => emer_i,
                piso_dest => destino,
                abre_cierra => orden_puerta,
                reset => CPU_RESETN,
                sube_baja => movimiento
            );
end architecture;