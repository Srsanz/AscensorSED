library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package strb_reg is
component Strobe_enable
Port (
        clk, strobe: in std_logic;
        EN: out std_logic
     );
end component;
end package strb_reg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.strb_reg.all;

entity strobe_enable is
port   (clk, strobe: in std_logic;
        EN: out std_logic);
end strobe_enable;

architecture structural of strobe_enable is
component reg_en 
port   (clk, strobe: in std_logic;
        EN: out std_logic);
end component;
begin
inst_enable: reg_en port map(clk=>clk, strobe=> strobe, EN => en);
end structural;


