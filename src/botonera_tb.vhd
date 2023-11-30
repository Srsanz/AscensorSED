library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Testbench_Botonera is
end Testbench_Botonera;

architecture tb_arch of Testbench_Botonera is
    signal b0_tb, b1_tb, b2_tb, b3_tb: std_logic := '0';
    signal piso_deseado_tb: std_logic_vector(1 downto 0);

    component Botonera
        port (
            b0, b1, b2, b3: in std_logic;
            piso_deseado: out std_logic_vector(1 downto 0)
        );
    end component;

begin
    UUT: Botonera port map (b0 => b0_tb, b1=>b1_tb, b2=>b2_tb, b3=>b3_tb, piso_deseado=>piso_deseado_tb);

    process
    begin
        b0_tb <= '1';
        b1_tb <= '0';
        b2_tb <= '0';
        b3_tb <= '0';
        wait for 50 ns;
        assert piso_deseado_tb = "00" report "Error en el Test Case 1" severity failure;

        b0_tb <= '0';
        b1_tb <= '1';
        b2_tb <= '0';
        b3_tb <= '0';
        wait for 50 ns;
        assert piso_deseado_tb = "01" report "Error en el Test Case 2" severity failure;

        b0_tb <= '0';
        b1_tb <= '0';
        b2_tb <= '1';
        b3_tb <= '0';
        wait for 50 ns;
        assert piso_deseado_tb = "10" report "Error en el Test Case 3" severity failure;

        b0_tb <= '0';
        b1_tb <= '0';
        b2_tb <= '0';
        b3_tb <= '1';
        wait for 50 ns;
        assert piso_deseado_tb = "11" report "Error en el Test Case 4" severity failure;
        assert false -- Forzar fallo
        report "[SUCCESS]: Fin Test"
        severity failure;
        wait;
    end process;
end tb_arch;
