----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2023 10:52:22
-- Design Name: 
-- Module Name: CONTADOR_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
        IF reset = '1' THEN
            cnt <= (others  => '0');
           
        ELSIF STROBE_2'EVENT AND STROBE_2='1' THEN
            IF UPDOWN="10" THEN
                cnt <= cnt + 1;
            ELSIF UPDOWN="01" THEN
                cnt <= cnt - 1;
                END IF;
            END IF;
    END PROCESS;
    
PISO <= std_logic_vector(cnt);
end Behavioral;
