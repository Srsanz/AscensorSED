library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DECODER_1 is
    Port ( PISO : in STD_LOGIC_VECTOR (1 downto 0);
           an: out std_logic_vector (7 downto 0);
           segment: out STD_LOGIC_vector(6 downto 0)
           );
end DECODER_1;

architecture dataflow of DECODER_1 is
signal an_i: std_logic_vector (7 downto 0):= "11111110";
begin
    WITH PISO SELECT
        SEGMENT <= "0000001" WHEN "00",
                   "1001111" WHEN "01",
                   "0010010" WHEN "10",
                   "0000110" WHEN "11",
                   "1111110" WHEN OTHERS;
an <= an_i;                           
end architecture dataflow;
