library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECODER_2 is
    Port ( UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           LED16 : out STD_LOGIC_VECTOR (2 downto 0);
           LED17 : out STD_LOGIC_VECTOR (2 downto 0)
           );
end DECODER_2;

architecture dataflow of DECODER_2 is

begin
    WITH UPDOWN SELECT
        LED16<= "010" WHEN "10",
                "100" WHEN "01",
                "011" WHEN "00",
                "111" WHEN OTHERS;
                
     WITH UPDOWN SELECT        
        LED17<= "010" WHEN "01",
                "100" WHEN "10",
                "011" WHEN "00",
                "111" WHEN OTHERS;
                               
end architecture dataflow;
