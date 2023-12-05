library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Testbench_Contador_puertas is
end Testbench_Contador_puertas;

architecture tb_architecture of Testbench_Contador_puertas is
    signal abre_cierra_tb       : std_logic_vector(1 downto 0) := "01";
    signal clk_tb              : std_logic := '0';
    signal emer_tb             : std_logic := '0';
    signal abierto_cerrado_tb  : std_logic_vector(1 downto 0);
    signal count_tb            : integer range 0 to 8;

    constant CLOCK_PERIOD   : time := 10 ns; -- constante de tiempo que se utilizará
begin
    -- Instancio la unidad a testear (UUT)
    uut: entity work.Contador_puertas
        generic map (
            n_leds => 8
        )
        port map (
            abre_cierra      => abre_cierra_tb,
            clk                 => clk_tb,
            
            abierto_cerrado  => abierto_cerrado_tb,
            count            => count_tb
        );

    -- Genero el reloj
    clk_process: process
    begin
            clk_tb <= '0';
            wait for CLOCK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLOCK_PERIOD / 2;
    end process;

    -- Proceso de estimulación
    stimulus_process: process
    begin
        wait for 5 ns; -- Asegura que la simulación ha comenzado antes de cambiar las señales

        -- Abrir hasta que esté abierto
        while abierto_cerrado_tb /= "01" loop
            abre_cierra_tb <= "01";
            wait for CLOCK_PERIOD;
        end loop;
        assert abierto_cerrado_tb = "01" report "Error en la apertura" severity failure;

        -- Cerrar hasta que esté cerrado
        while abierto_cerrado_tb /= "10" loop
            abre_cierra_tb <= "10";
            wait for CLOCK_PERIOD;
        end loop;
        assert abierto_cerrado_tb = "10" report "Error en el cierre" severity failure;

        -- Continuar simulación después de cerrar
        --wait for 100 ns;

        assert false
           report "[SUCCESS]: Fin Test"
           severity failure;

        wait;
    end process;

end tb_architecture;
