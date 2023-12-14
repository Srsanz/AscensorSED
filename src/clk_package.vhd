library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package reloj is
    procedure periodo(
        signal clk: in STD_LOGIC; 
        constant factor: in positive);
end reloj;

package body reloj is
    procedure periodo(
        signal clk_signal: in STD_LOGIC; 
        constant factor: positive) is
    begin
        wait for factor / 2;
        clk <= not clk;
end reloj;
end reloj;
