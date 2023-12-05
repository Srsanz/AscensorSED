LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY motor_tb IS
END motor_tb;

ARCHITECTURE behavior OF motor_tb IS

    -- Component declaration for the motor
    COMPONENT motor
        PORT (
            UPDOWN   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
            reset    : IN  STD_LOGIC;
            STROBE_2 : IN  STD_LOGIC;
            CLK      : IN  STD_LOGIC;
            PISO     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            SEGMENT  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            LED16    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            LED17    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL UPDOWN_tb   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL reset_tb    : STD_LOGIC := '0';
    SIGNAL STROBE_2_tb : STD_LOGIC := '0';
    SIGNAL CLK_tb     : STD_LOGIC := '0';
    SIGNAL PISO_tb     : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL SEGMENT_tb  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL LED16_tb    : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL LED17_tb    : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- Instantiate the motor
    UUT : motor
        PORT MAP (
            UPDOWN   => UPDOWN_tb,
            reset    => reset_tb,
            STROBE_2 => STROBE_2_tb,
            CLK      => CLK_tb,
            PISO     => PISO_tb,
            SEGMENT  => SEGMENT_tb,
            LED16    => LED16_tb,
            LED17    => LED17_tb
        );

    -- Clock process
    CLK_PROCESS : PROCESS
    BEGIN
        WAIT FOR 10 ns; -- Adjust the clock period as needed
        CLK_tb <= NOT CLK_tb;
    END PROCESS CLK_PROCESS;
    
    -- STROBE PROCESS
    STROBE_2_PROCESS : PROCESS
    BEGIN
        for i in 1 to 50000 loop
          wait until clk_tb = '1';
         end loop;
        STROBE_2_tb <= NOT STROBE_2_tb;
    END PROCESS STROBE_2_PROCESS;
        
        
    
    -- Stimulus process
    STIMULUS_PROCESS : PROCESS
    BEGIN
        -- Initialize inputs
        UPDOWN_tb   <= "00";
        reset_tb    <= '1';

        -- Apply stimulus
        WAIT FOR 20 ns;
        reset_tb <= '0';

        WAIT FOR 20 ns;
        UPDOWN_tb <= "10";

        WAIT FOR 6 ms;
        UPDOWN_tb <= "01";
        --WAIT FOR 50 ns; -- Allow some time for the simulation to run

        -- Add more stimulus as needed

        WAIT;
    END PROCESS STIMULUS_PROCESS;

END behavior;
