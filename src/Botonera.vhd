library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Botonera is
    port (
        b0, b1, b2, b3: in std_logic;
        piso_deseado: out std_logic_vector(1 downto 0)
    );
end Botonera;

architecture dataflow of Botonera is
    signal botones: std_logic_vector(3 downto 0);
begin
botones <= b3 & b2 & b1 & b0;
    with botones select
        piso_deseado<= "00" when "0001",
                       "01" when "0010",
                       "10" when "0100",
                       "11" when "1000",
                       "ZZ" when others;
end dataflow;

