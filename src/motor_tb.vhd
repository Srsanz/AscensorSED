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
            PISO     : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            SEGMENT  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            LED16    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            LED17    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL UPDOWN   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL reset    : STD_LOGIC := '0';
    SIGNAL STROBE_2 : STD_LOGIC := '0';
    SIGNAL CLK     : STD_LOGIC := '0';
    SIGNAL PISO     : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL SEGMENT  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL LED16    : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL LED17    : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- Instantiate the motor
    UUT : motor
        PORT MAP (
            UPDOWN   => UPDOWN,
            reset    => reset,
            STROBE_2 => STROBE_2,
            CLK      => CLK,
            PISO     => PISO,
            SEGMENT  => SEGMENT,
            LED16    => LED16,
            LED17    => LED17
        );

    -- Clock process
    CLK_PROCESS : PROCESS
    BEGIN
        WAIT FOR 10 ns; -- Adjust the clock period as needed
        CLK <= NOT CLK;
    END PROCESS CLK_PROCESS;
    
    -- STROBE PROCESS
    STROBE_2_PROCESS : PROCESS
    BEGIN
        for i in 1 to 50000 loop
          wait until clk = '1';
         end loop;
        STROBE_2 <= NOT STROBE_2;
    END PROCESS STROBE_2_PROCESS;
        
        
    
    -- Stimulus process
    STIMULUS_PROCESS : PROCESS
    BEGIN
        -- Initialize inputs
        UPDOWN   <= "00";
        reset    <= '1';

        -- Apply stimulus
        WAIT FOR 20 ns;
        reset <= '0';

        WAIT FOR 20 ns;
        UPDOWN <= "10";

        WAIT FOR 6 ms;
        UPDOWN <= "01";
        --WAIT FOR 50 ns; -- Allow some time for the simulation to run

        -- Add more stimulus as needed

        WAIT;
    END PROCESS STIMULUS_PROCESS;

END behavior;
