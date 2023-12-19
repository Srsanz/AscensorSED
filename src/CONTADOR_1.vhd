library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity CONTADOR_1 is
    generic (n_pisos: integer := 3);
    Port (UPDOWN : in STD_LOGIC_VECTOR (1 downto 0);
           reset: in STD_LOGIC;
           STROBE_2 : in STD_LOGIC;
           clk: in std_logic;
           PISO : out STD_LOGIC_VECTOR (1 downto 0)
           );         
end CONTADOR_1;

architecture Behavioral of CONTADOR_1 is
SIGNAL cnt: integer range 0 to n_pisos := 0;
begin
    process(clk, RESET)
    begin
        IF reset = '0' THEN
            cnt <= 0;
        elsif rising_edge(clk) then
            IF STROBE_2 = '1' then
                IF UPDOWN = "10" THEN
                    if cnt /= 3 then
                        cnt <= cnt + 1;
                    end if;
                ELSIF UPDOWN = "01" THEN
                    if cnt /= 0 then                    
                        cnt <= cnt - 1;                    
                    end if;   
                END IF;
            END IF;
        END IF;
    END PROCESS;
    
    PISO <= "00" when cnt = 0 else
            "01" when cnt = 1 else
            "10" when cnt = 2 else
            "11" when cnt = n_pisos else
            "00";
end Behavioral;
