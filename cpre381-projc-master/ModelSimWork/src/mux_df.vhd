-------------------------------------------------------------------------
-- Ehren Fox
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- 2_1_Mux_df.vhd 
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input mux  
-- circuit with a select bit. 
--
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_df is
	generic(N	:	integer := 32);
	port(iA 	:	in std_logic_vector(N-1 downto 0);
		 iB 	: 	in std_logic_vector(N-1 downto 0);
		 iCtrl	: 	in std_logic;
		 Q		: 	out std_logic_vector(N-1 downto 0));
 
end mux_df;
	
	
architecture dataflow of mux_df is	
	
begin	
	Q <= iA when (iCtrl='0') else iB;

end dataflow;
	