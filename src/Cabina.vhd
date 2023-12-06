library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.strobe_generation.all;



entity Cabina is
    Port ( 
        b0,b1,b2,b3,bemer: in std_logic;
        abre_cierra, sube_baja: in std_logic_vector(1 downto 0);
        clk, strobe_1, strobe_2: in std_logic;
        reset: in std_logic;
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
component Puertas
        generic (n_leds:integer:=8);
Port (
        abrir_cerrar: in std_logic_vector (1 downto 0);
        clk, strobe_1: in std_logic;        
        abierto_cerrado: out std_logic_vector (1 downto 0);
        led: out std_logic_vector (15 downto 0)       
      );
end component;

component motor is
    Port ( UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset : in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (1 downto 0);
           SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
           LED16 : out STD_LOGIC_VECTOR (2 downto 0);
           LED17 : out STD_LOGIC_VECTOR (2 downto 0)
           );
end component;

signal segment_i: std_logic_vector (6 downto 0):= "111111";
signal led_16_i: std_logic_vector (2 downto 0):="000";
signal led_17_i: std_logic_vector (2 downto 0):="000";
signal strobe_signals : std_logic_vector(1 downto 0);
--constant moduli: positive_vector := (250000000, 500000000); TIEMPOS PLACA
constant moduli: positive_vector := (2500, 50000);
begin
strobe_gen_inst : strobe_generator
        generic map (
                     MODULI => moduli -- Valores en unidades de 0.1 nanosegundos (100 MHz)
        )
        port map (
                     RST_N => reset,
                     CLK => clk,
                     STROBES => strobe_signals
        );
inst_motor: motor            
    port map(
                UPDOWN => sube_baja,
                reset => reset,
                strobe_2 => strobe_signals(1),
                clk => clk,
                PISO => piso,
                segment => segment_i,
                led16 => led_16_i,
                led17 => led_17_i
            );
inst_botonera: botonera port map (b0 => b0, b1 => b1,b2 => b2, b3 => b3, piso_deseado => piso_destino);
inst_puertas: puertas 
    port map(
                abrir_cerrar => abre_cierra,
                clk => clk,
                strobe_1 => strobe_signals(0),
                abierto_cerrado => abierto_cerrado,
                led => led
            );

    ca <= segment_i(0);
    cb <= segment_i(1);
    cc <= segment_i(2);
    cd <= segment_i(3);
    ce <= segment_i(4);
    cf <= segment_i(5);
    cg <= segment_i(6);

    led16_r <= led_16_i(2);
    led16_g <= led_16_i(1);
    led16_b <= led_16_i(0);   
    
    led17_r <= led_17_i(2);
    led17_g <= led_17_i(1);
    led17_b <= led_17_i(0);       
end architecture;