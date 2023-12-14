library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package reloj is
    procedure periodo(
        signal clk: out STD_LOGIC; 
        constant factor: in time);        
end reloj;

package body reloj is
    procedure periodo(
        signal clk: out STD_LOGIC; 
        constant factor: time) is
    begin
        for i in 0 to 200 loop
            clk <= '0';
            wait for factor / 2;
            clk <= '1';
            wait for factor / 2;
        end loop;
    end procedure;    
end package body;
