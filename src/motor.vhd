library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity motor is
    Port ( UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset : in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           an : out std_logic_vector (7 downto 0);
           CLK : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (1 downto 0);
           SEGMENT : out STD_LOGIC_VECTOR (6 downto 0);
           LED16 : out STD_LOGIC_VECTOR (2 downto 0);
           LED17 : out STD_LOGIC_VECTOR (2 downto 0)
           );
end motor;

architecture Behavioral of motor is
signal piso_i: std_logic_vector(piso'range):= "00";

COMPONENT DECODER_1
PORT(           
           PISO : in STD_LOGIC_VECTOR (1 downto 0);
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
PORT(
           UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset: in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (1 downto 0)
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
PISO=>PISO
);

end Behavioral;
