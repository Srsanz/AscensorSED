library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Puertas is
    generic (n_leds:integer:=8);
    Port (
        abrir_cerrar: in std_logic_vector (1 downto 0);
        clk, strobe_1: in std_logic;
        reset_n: in std_logic;        
        abierto_cerrado: out std_logic_vector (1 downto 0);
        led: out std_logic_vector (15 downto 0)       
    );    
end Puertas;

architecture Behavioral of Puertas is
    
    component Contador_puertas
        generic ( n_leds: integer := 8);
        Port (
            abre_cierra: in std_logic_vector(1 downto 0);
            clk, strobe_1: in std_logic;
            reset_n: in std_logic;
            abierto_cerrado: out std_logic_vector(1 downto 0):= "01";
            count: out integer range 0 to n_leds
        );
    end component;

    component deco_puertas
        generic (n_leds: integer:= 8);
        Port (
            count: in integer range 0 to n_leds:= n_leds;
            led: out std_logic_vector(15 downto 0)
        );
    end component;

    signal count_i: integer range 0 to n_leds;

begin
    inst_deco: deco_puertas port map(count=> count_i, led => led);
    inst_contador_puertas: contador_puertas
        port map(
            reset_n => reset_n,
            abre_cierra=>abrir_cerrar,   
            strobe_1 => strobe_1,
            clk => clk,
            abierto_cerrado => abierto_cerrado,
            count => count_i);
            
end Behavioral;
