LIBRARY IEEE;
LIBRARY WORK;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.RELOJ.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
entity FSM_Testbench is
end FSM_Testbench;

architecture tb_arch of FSM_Testbench is

    -- Component Declaration
    component FSM is
        Port (
            clk : in STD_LOGIC;
            piso_actual : in STD_LOGIC_VECTOR (2 downto 0);
            piso_dest : in STD_LOGIC_VECTOR (2 downto 0);
            abierto_cerrado : in STD_LOGIC_VECTOR (1 downto 0);
            emer : in STD_LOGIC;
            reset : in STD_LOGIC;
            abre_cierra : out STD_LOGIC_VECTOR (1 downto 0);
            sube_baja : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;

    -- Signals Declaration
    signal clk_tb : STD_LOGIC := '0';
    signal piso_actual_tb, piso_dest_tb:STD_LOGIC_VECTOR (2 downto 0) := "100"; 
    signal abierto_cerrado_tb : STD_LOGIC_VECTOR (1 downto 0) := "10";
    signal emer_tb, reset_tb : STD_LOGIC := '0';
    signal abre_cierra_tb, sube_baja_tb : STD_LOGIC_VECTOR (1 downto 0);
    constant CLOCK_PERIOD   : time := 10 ns;
 

begin

    -- DUT (Device Under Test) Instantiation
    DUT : FSM
        port map (
            clk => clk_tb,
            piso_actual => piso_actual_tb,
            piso_dest => piso_dest_tb,
            abierto_cerrado => abierto_cerrado_tb,
            emer => emer_tb,
            reset => reset_tb,
            abre_cierra => abre_cierra_tb,
            sube_baja => sube_baja_tb
        );

    -- Clock Process
    periodo(clk_tb, clock_period);

    -- Stimulus Process
    stimulus_process : process
    begin
        -- Reset initial values
        reset_tb <= '1';
        emer_tb <= '0';
        wait for clock_period * 2;       
        -- Test Case 1: Subir
        piso_dest_tb <= "100"; -- Example destination floor
        wait until clk_tb = '1';
        piso_dest_tb <= "110"; -- Example destination floor
        wait for clock_period;
        piso_dest_tb <= "000";
        wait for clock_period;        
        abierto_cerrado_tb <= "01";
        wait for clock_period;
        piso_actual_tb <= "101";
        wait for clock_period;
        piso_actual_tb <= "110";
        wait for clock_period * 2;
        abierto_cerrado_tb <= "10";
        wait for clock_period; 
        -- Test Case 2: Bajar        
        piso_dest_tb <= "100";
        wait for clock_period;
        emer_tb <= '1';
        wait for clock_period;
        emer_tb <= '0';
        abierto_cerrado_tb <= "10";
        wait for clock_period;
        abierto_cerrado_tb <= "01";
        wait for clock_period;
        piso_actual_tb <= "101";
        wait for clock_period;
        piso_actual_tb <= "100";
        wait for clock_period * 2;
        abierto_cerrado_tb <= "10";
        wait for clock_period;  
        assert false
        report "[SUCCESS]: Fin Test"
        severity failure;
        -- Test Case 2: Moving from E1 to E2
--        emer_tb <= '1'; -- Example emergency situation
--        wait for 100 ns;

--        -- Test Case 3: Moving from E2 to E1
--        emer_tb <= '0'; -- Reset emergency situation
--        abierto_cerrado_tb <= "10"; -- Example doors closed
--        wait for 100 ns;

--        -- Test Case 4: Moving from E1 to E3
--        piso_dest_tb <= "110"; -- Example destination floor
--        wait for 100 ns;

--        -- Test Case 5: Moving from E3 to E4
--        piso_actual_tb <= "101"; -- Example current floor
--        wait for 100 ns;

--        -- Test Case 6: Moving from E4 to E6
--        piso_actual_tb <= "110"; -- Example current floor
--        wait for 100 ns;

--        -- Test Case 7: Moving from E6 to E0
--        abierto_cerrado_tb <= "10"; -- Example doors closed
--        wait for 100 ns;

        wait;
    end process stimulus_process;

end tb_arch;