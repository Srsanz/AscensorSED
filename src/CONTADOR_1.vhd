library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity CONTADOR_1 is
    Port ( UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset: in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           PISO : out STD_LOGIC_VECTOR (1 downto 0));         
end CONTADOR_1;

architecture Behavioral of CONTADOR_1 is
SIGNAL cnt: UNSIGNED(1 downto 0);
begin
process(STROBE_2, RESET)
    begin
        IF reset = '0' THEN
            cnt <= (others  => '0');
           
        ELSIF STROBE_2'EVENT AND STROBE_2='1' THEN
            IF UPDOWN="10" THEN
                cnt <= cnt + 1;
            ELSIF UPDOWN="01" THEN
                cnt <= cnt - 1;
                END IF;
                else
                    cnt<=cnt;
            END IF;
    END PROCESS;
    
PISO <= std_logic_vector(cnt);
end Behavioral;
