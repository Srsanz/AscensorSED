library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM is
    port (
        clk             : in  STD_LOGIC;
        piso_actual     : in  STD_LOGIC_VECTOR (1 downto 0);
        piso_dest       : in  STD_LOGIC_VECTOR (2 downto 0);
        abierto_cerrado : in  STD_LOGIC_VECTOR (1 downto 0);
        emer            : in  STD_LOGIC;
        reset           : in  STD_LOGIC;
        abre_cierra     : out STD_LOGIC_VECTOR (1 downto 0);
        ce_1, ce_2      : out std_logic;
        sube_baja       : out STD_LOGIC_VECTOR (1 downto 0)
    );
end FSM;

architecture fsm_ascensor of FSM is

    type estado is (E0, E1, E2, E3, E4, E5, E6);
    signal E_actual ,E_siguiente : estado ;
    signal current_destino: std_logic_vector (1 downto 0);
    signal next_destino: std_logic_vector (current_destino'range);    
    alias but_prssd : std_logic is piso_dest(2);
    alias but_code  : std_logic_vector(1 downto 0) is piso_dest(1 downto 0);

begin
    
    sync_proc : process (clk ,E_siguiente, E_actual , reset )
    begin
        if ( reset = '0') then
            E_actual <= E0;
            current_destino <= "00";
        elsif ( rising_edge (clk)) then
            E_actual <= E_siguiente;
            current_destino <= next_destino;
        end if;
    end process sync_proc ;
       
    fsm_ascensor : process (E_actual, piso_dest, piso_actual, emer, abierto_cerrado, current_destino)
    begin
        E_siguiente <= E_actual;
        next_destino <= current_destino;
        case E_actual is
            when E0 =>
                sube_baja   <= "00";
                abre_cierra <= "00"; -- Salida Moore
                ce_1 <= '0'; 
                ce_2 <= '0';
                if but_prssd = '1' and but_code /= piso_actual then
                    next_destino <= but_code;            
                    E_siguiente <= E1;
                end if;
            
            when E1 =>
                sube_baja <= "00";
                abre_cierra <= "01"; -- Salida Moore
                ce_1 <= '1';
                ce_2 <= '0';
                if emer = '1' then
                    E_siguiente <= E2;
                elsif abierto_cerrado = "01" then
                    E_siguiente <= E3;
                end if;
                
            when E2 =>
                sube_baja <= "00";
                abre_cierra <= "10"; -- Salida Moore
                ce_1 <= '1';
                ce_2 <= '0';
                if emer = '0' then 
                    if abierto_cerrado = "10" then 
                        E_siguiente <= E1;
                    end if;    
                end if;
                
            when E3 =>
                sube_baja <= "00";
                abre_cierra <= "00"; -- Salida Moore
                ce_1 <= '0';
                ce_2 <= '0';
                if current_destino > piso_actual then 
                    E_siguiente <= E4;
                elsif current_destino < piso_actual then
                    E_siguiente <= E5;
                end if;
                
            when E4 =>
                sube_baja <= "10";
                abre_cierra <= "00"; -- Salida Moore
                ce_1 <= '0';
                ce_2 <= '1';
                if piso_actual = current_destino then 
                    E_siguiente <= E6;         
                end if;     
            
            when E5 =>
                sube_baja <= "01";
                abre_cierra <= "00"; -- Salida Moore
                ce_1 <= '0';
                ce_2 <= '1';
                if piso_actual = current_destino then 
                    E_siguiente <= E6;
                end if;
            
            when E6 =>
                sube_baja <= "00";
                abre_cierra <= "10"; -- Salida Moore
                ce_1 <= '1';
                ce_2 <= '0';
                if abierto_cerrado = "10" then 
                    E_siguiente <= E0;
                end if; 
        end case;
    end process fsm_ascensor ;
end;
