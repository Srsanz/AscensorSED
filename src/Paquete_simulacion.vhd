library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package simulacion is
    procedure strobe_gnrtr(
        signal strobe : out std_logic;
        signal clk : in std_logic;
        constant factor : in positive);       
end package;

package body simulacion is
    procedure strobe_gnrtr(
        signal strobe : out std_logic;
        signal clk : in std_logic;
        constant factor : in positive
    ) is
    begin
        strobe <= '0';
        for i in 1 to factor - 1 loop
            wait until clk = '1';
        end loop;
        strobe <= '1';
        wait until clk = '1';
    end procedure;   
end package body; 

--entity Paquete_simulacion is
----  Port ( );
--end Paquete_simulacion;

--architecture Behavioral of Paquete_simulacion is

--begin


--end Behavioral;
