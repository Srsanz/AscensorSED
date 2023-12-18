library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DECODER_1 is
    generic (n_pisos: integer := 3);
    Port ( PISO : in STD_LOGIC_VECTOR (2 downto 0);
           an: out std_logic_vector (0 to 7);
           segment: out STD_LOGIC_vector(6 downto 0)
           );
end DECODER_1;

architecture dataflow of DECODER_1 is
begin
    an <= "11111110";
    WITH PISO SELECT
        SEGMENT <= "0000001" WHEN "100",
                   "1001111" WHEN "101",
                   "0010010" WHEN "110",
                   "0000110" WHEN "111",
                   "1111110" WHEN OTHERS;
end architecture dataflow;
