library ieee;
use ieee.std_logic_1164.all;

entity TIMER is
  generic (
    MODULO  : positive
  );
  port ( 
    RST_N  : in   std_logic;
    CLK    : in   std_logic;
    STROBE : out  std_logic
  );
end TIMER;

architecture BEHAVIORAL of TIMER is
begin
  process (RST_N, CLK)
    subtype count_t is natural range 0 to MODULO - 1; 
    variable count : count_t;
  begin
    if RST_N = '0' then
      count := 0;
    elsif rising_edge(CLK) then
      count := (count + 1) mod MODULO;
    end if;

    if count = MODULO - 1 then
      STROBE <= '1';
    else
      STROBE <= '0';
    end if;
  end process;
end BEHAVIORAL;
