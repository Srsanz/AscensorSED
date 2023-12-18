library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use work.simulacion.all;
entity motor is
    generic (n_pisos: integer := 3);
    Port ( UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset : in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           an : out std_logic_vector (7 downto 0);
           CLK : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (2 downto 0);
           SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
           LED16 : out STD_LOGIC_VECTOR (2 downto 0);
           LED17 : out STD_LOGIC_VECTOR (2 downto 0)
           );
end motor;

architecture Behavioral of motor is
signal piso_i: std_logic_vector(piso'range):= "000";

COMPONENT DECODER_1
generic (n_pisos: integer := 3);
PORT(           
           PISO : in STD_LOGIC_VECTOR (2 downto 0);
           an: out std_logic_vector (7 downto 0);
           SEGMENT : out STD_LOGIC_VECTOR (6 downto 0)
);
END COMPONENT;

COMPONENT DECODER_2
PORT(
           UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           LED16 : out STD_LOGIC_VECTOR (2 downto 0);
           LED17 : out STD_LOGIC_VECTOR (2 downto 0)
);
END COMPONENT;

COMPONENT CONTADOR_1
generic (n_pisos: integer := 3);
PORT(
           UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset, clk: in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (2 downto 0):= "000"
);
END COMPONENT;

begin
    INST_DECODER_1: DECODER_1 PORT MAP(
    PISO=>PISO_i,
    SEGMENT=>SEGMENT,
    an => an
    );

    INST_DECODER_2: DECODER_2 PORT MAP(
    UPDOWN=>UPDOWN,
    LED16=>LED16,
    LED17=>LED17
    );

    INST_CONTADOR_1: CONTADOR_1 PORT MAP(
    UPDOWN=>UPDOWN,
    reset=>reset,
    STROBE_2=>STROBE_2,
    PISO=>PISO_i,
    clk => clk
    );

    PISO <= PISO_i;
end Behavioral;
