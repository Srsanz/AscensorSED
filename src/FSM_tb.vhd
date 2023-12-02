library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_Testbench is
end FSM_Testbench;

architecture tb_architecture of FSM_Testbench is

  -- Constants declaration
  constant CLK_PERIOD : time := 10 ns;

  -- Signals declaration
  signal clk, reset, emer : std_logic := '0';
  signal piso_actual, piso_dest, abierto_cerrado : std_logic_vector(1 downto 0) := "00";
  signal abre_cierra, sube_baja : std_logic_vector(1 downto 0);

begin

  -- Component instantiation
  UUT : entity work.FSM
    port map (
      clk => clk,
      piso_actual => piso_actual,
      piso_dest => piso_dest,
      abierto_cerrado => abierto_cerrado,
      emer => emer,
      reset => reset,
      abre_cierra => abre_cierra,
      sube_baja => sube_baja
    );

  -- Clock process
  clk_process: process
  begin
    while now < 1000 ns loop  -- Simulate for 1000 ns
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
    wait;
  end process clk_process;

  -- Stimulus process
  stimulus : process
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';

    -- Test case 1: Moving from E0 to E1
    piso_actual <= "00";
    piso_dest <= "01";
    wait for 100 ns;

    -- Test case 2: Emergency scenario
    emer <= '1';
    wait for 50 ns;

    -- Test case 3: Resuming after emergency
    emer <= '0';
    abierto_cerrado <= "10";
    wait for 200 ns;

    -- Test case 4: Set piso_dest to "11"
    piso_dest <= "11";
    wait for 100 ns;

    wait;
  end process stimulus;

end tb_architecture;