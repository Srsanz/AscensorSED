LIBRARY IEEE;
library work;
USE ieee.std_logic_1164.ALL;
use work.simulacion.all;
use work.reloj.all;

ENTITY motor_tb IS
END motor_tb;

ARCHITECTURE behavior OF motor_tb IS

    -- Component declaration for the motor
--    COMPONENT motor
--        generic (n_pisos: integer := 3);
--        PORT (
--            UPDOWN   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
--            reset    : IN  STD_LOGIC;
--            STROBE_2 : IN  STD_LOGIC;
--            CLK      : IN  STD_LOGIC;
--            PISO     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--            an       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--            SEGMENT  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
--            LED16    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--            LED17    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
--        );
--    END COMPONENT;

    -- Signal declarations
    SIGNAL UPDOWN_tb   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL reset_tb    : STD_LOGIC := '0';
    SIGNAL STROBE_2_tb : STD_LOGIC := '0';
    SIGNAL CLK_tb      : STD_LOGIC := '0';
    signal an_tb       : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PISO_tb     : STD_LOGIC_VECTOR(2 DOWNTO 0) := "00";
    SIGNAL SEGMENT_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL LED16_tb    : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL LED17_tb    : STD_LOGIC_VECTOR(2 DOWNTO 0);

--    procedure strobe_gnrtr(
--        signal strobe : out std_logic;
--        signal clk : in std_logic;
--        constant factor : in positive) is
--    begin
--        strobe <= '0';
--        for i in 1 to factor - 1 loop
--          wait until clk = '1';
--        end loop;
--        strobe <= '1';
--        wait until clk = '1';
--    end procedure;
BEGIN

    -- Instantiate the motor
    UUT : entity work.motor
        generic map (n_pisos => 3)
        PORT MAP (
            UPDOWN   => UPDOWN_tb,
            reset    => reset_tb,
            STROBE_2 => STROBE_2_tb,
            CLK      => CLK_tb,
            PISO     => PISO_tb,
            SEGMENT  => SEGMENT_tb,
            LED16    => LED16_tb,
            LED17    => LED17_tb,
            an       => an_tb
        );

    -- Clock process
--    CLK_PROCESS : PROCESS
--    BEGIN
--        WAIT FOR 10 ns; -- Adjust the clock period as needed
--        CLK_tb <= NOT CLK_tb;
--    END PROCESS CLK_PROCESS;
    clk_period: periodo(clk_tb, 10 ns); 
    
    -- STROBE PROCESS
    STROBE_2_PROCESS: strobe_gnrtr(STROBE_2_tb, clk_tb, 4);    
    
    -- Stimulus process
    STIMULUS_PROCESS : PROCESS
    BEGIN
        -- Initialize inputs
        UPDOWN_tb   <= "00";
        reset_tb    <= '0';
        an_tb <= "11111110";
        -- Apply stimulus
        WAIT FOR 20 ns;
        wait until clk_tb = '1';
        reset_tb <= '1';

        for i in 1 to 2 loop
          wait until clk_tb = '1';
        end loop;
        UPDOWN_tb <= "10";

        for i in 1 to 16 loop
          wait until clk_tb = '1';
        end loop;
        UPDOWN_tb <= "01";
        --WAIT FOR 50 ns; -- Allow some time for the simulation to run

        -- Add more stimulus as needed
        for i in 1 to 2 loop
          wait until clk_tb = '1';
        end loop;
        assert false
          report "[PASSED]: simulation finished."
          severity failure;
    END PROCESS STIMULUS_PROCESS;

END behavior;
