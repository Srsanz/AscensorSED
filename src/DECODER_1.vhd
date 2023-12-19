library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DECODER_1 is
    generic (n_pisos: integer := 3);
    Port ( PISO : in STD_LOGIC_VECTOR (1 downto 0);
           an: out std_logic_vector (0 to 7);
           segment: out STD_LOGIC_vector(6 downto 0)
           );
end DECODER_1;

architecture dataflow of DECODER_1 is
begin
    an <= "01111111";
    WITH PISO SELECT
        SEGMENT <= "1000000" WHEN "00",
                   "1111001" WHEN "01",
                   "0100100" WHEN "10",
                   "0110000" WHEN "11",
                   "0111111" WHEN OTHERS;
end architecture dataflow;
