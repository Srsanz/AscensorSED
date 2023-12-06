library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_Testbench is
end FSM_Testbench;

architecture tb_arch of FSM_Testbench is

    -- Component Declaration
    component FSM is
        Port (
            clk : in STD_LOGIC;
            piso_actual : in STD_LOGIC_VECTOR (1 downto 0);
            piso_dest : in STD_LOGIC_VECTOR (1 downto 0);
            abierto_cerrado : in STD_LOGIC_VECTOR (1 downto 0);
            emer : in STD_LOGIC;
            reset : in STD_LOGIC;
            abre_cierra : out STD_LOGIC_VECTOR (1 downto 0);
            sube_baja : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;

    -- Signals Declaration
    signal clk_tb : STD_LOGIC := '0';
    signal piso_actual_tb, piso_dest_tb, abierto_cerrado_tb : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal emer_tb, reset_tb : STD_LOGIC := '0';
    signal abre_cierra_tb, sube_baja_tb : STD_LOGIC_VECTOR (1 downto 0);

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
    clk_process: process
    begin
        while now < 1000 ns loop  -- Simulation duration
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process clk_process;

    -- Stimulus Process
    stimulus_process : process
    begin
        -- Reset initial values
        emer_tb <= '0';
        reset_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';
        wait for 10 ns;

        -- Test Case 1: Moving from E0 to E1
        piso_dest_tb <= "01"; -- Example destination floor
        wait for 100 ns;

        -- Test Case 2: Moving from E1 to E2
        emer_tb <= '1'; -- Example emergency situation
        wait for 100 ns;

        -- Test Case 3: Moving from E2 to E1
        emer_tb <= '0'; -- Reset emergency situation
        abierto_cerrado_tb <= "10"; -- Example doors closed
        wait for 100 ns;

        -- Test Case 4: Moving from E1 to E3
        piso_dest_tb <= "10"; -- Example destination floor
        wait for 100 ns;

        -- Test Case 5: Moving from E3 to E4
        piso_actual_tb <= "01"; -- Example current floor
        wait for 100 ns;

        -- Test Case 6: Moving from E4 to E6
        piso_actual_tb <= "10"; -- Example current floor
        wait for 100 ns;

        -- Test Case 7: Moving from E6 to E0
        abierto_cerrado_tb <= "10"; -- Example doors closed
        wait for 100 ns;

        wait;
    end process stimulus_process;

end tb_arch;