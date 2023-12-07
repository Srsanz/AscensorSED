library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    Port ( clk : in STD_LOGIC;
           piso_actual : in STD_LOGIC_VECTOR (1 downto 0);
           piso_dest : in STD_LOGIC_VECTOR (1 downto 0);
           abierto_cerrado : in STD_LOGIC_VECTOR (1 downto 0);
           emer : in STD_LOGIC;
           reset : in STD_LOGIC;
           abre_cierra : out STD_LOGIC_VECTOR (1 downto 0);
           sube_baja : out STD_LOGIC_VECTOR (1 downto 0));
end FSM;

architecture fsm_ascensor of FSM is

 type estado is (E0, E1, E2, E3, E4, E5, E6);
   signal E_actual ,E_siguiente : estado ;

begin

 sync_proc : process (clk ,E_siguiente , reset )
   begin
      if ( reset = '0') then
      E_actual <= E0;
   elsif ( rising_edge (clk)) then
      E_actual <= E_siguiente;
   end if;
   
   end process sync_proc ;
   
    fsm_ascensor : process (E_actual ,piso_dest)
   begin
      abre_cierra <= "00";
      sube_baja <= "00";  -- Valores preasignados
      
      
   case E_actual is
   
      when E0 =>
         sube_baja <= "00";
         abre_cierra <= "00"; -- Salida Moore
         if (piso_dest /= piso_actual) then
            E_siguiente <= E1;
         elsif (piso_dest=piso_actual) then
            E_siguiente <= E0;
         end if;
         
      when E1 =>
         sube_baja <= "00";
         abre_cierra <= "01"; -- Salida Moore
         if (emer='1') then
            E_siguiente <= E2;
         else
            E_siguiente <= E3;
         end if;
         
      when E2 =>
         sube_baja <= "00";
         abre_cierra <= "10"; -- Salida Moore
         if (emer='0' and abierto_cerrado="10") then 
            E_siguiente <= E1;
         else
            E_siguiente <= E2;
         end if;
         
         when E3 =>
         sube_baja <= "00";
         abre_cierra <= "00"; -- Salida Moore
         if (piso_dest>piso_actual) then 
            E_siguiente <= E4;
         elsif (piso_dest<piso_actual) then
            E_siguiente <= E5;
         end if;
         
         when E4 =>
         sube_baja <= "10";
         abre_cierra <= "00"; -- Salida Moore
         if (piso_actual=piso_dest) then 
            E_siguiente <= E6;
         else
            E_siguiente <= E4;
         end if;     
         
         when E5 =>
         sube_baja <= "01";
         abre_cierra <= "00"; -- Salida Moore
         if (piso_actual=piso_dest) then 
            E_siguiente <= E6;
         else
            E_siguiente <= E5;
         end if;
         
         when E6 =>
         sube_baja <= "00";
         abre_cierra <= "10"; -- Salida Moore
         if (abierto_cerrado="10") then 
            E_siguiente <= E0;
         else
            E_siguiente <= E6;
         end if;
      end case;
   end process fsm_ascensor ;

end;
