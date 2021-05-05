library IEEE;
use IEEE.std_logic_1164.all;

entity forward_unit is
	port(
		    EXMEM_RegWr, MEMWB_RegWr : in std_logic;
			EXMEM_RegRd, MEMWB_RegRd : in std_logic_vector(4 downto 0);
			IDEX_RegRs : in std_logic_vector(4 downto 0);
			IDEX_RegRt : in std_logic_vector(4 downto 0);
			ForwardA, ForwardB : out std_logic_vector(1 downto 0)
		);
end forward_unit;
	
architecture behavior of forward_unit is
	begin
	
	process(EXMEM_RegWr, MEMWB_RegWr, EXMEM_RegRd, MEMWB_RegRd, IDEX_RegRs, IDEX_RegRt, ForwardA, ForwardB)
	begin
		
		

		if((MEMWB_RegWr ='1') and (EXMEM_RegWr ='1') and (IDEX_RegRs = EXMEM_RegRd)
		and (IDEX_RegRs /= IDEX_RegRt) and (IDEX_RegRt = "00000") and (MEMWB_RegRd /= "00000") and (EXMEM_RegRd /= IDEX_RegRs) and (EXMEM_RegRd /= "00000")
		and (IDEX_RegRs /= "00000") and (IDEX_RegRt /= EXMEM_RegRd)) then
			ForwardA <= "00";

		--MEMWB to EX RegistersRS Check
		elsif((MEMWB_RegWr  = '1') AND (MEMWB_RegRd /= "00000")
		AND NOT ((EXMEM_RegWr = '1') AND (EXMEM_RegRd /= "00000")
		AND (EXMEM_RegRd = IDEX_RegRs))
		AND (MEMWB_RegRd = IDEX_RegRs)) then
			ForwardA <= "01";
		
		elsif((MEMWB_RegWr ='1') and (EXMEM_RegWr ='1') and (IDEX_RegRt = MEMWB_RegRd)
		and (IDEX_RegRs /= IDEX_RegRt) and (IDEX_RegRt = "00000") and (MEMWB_RegRd /= "00000") and (EXMEM_RegRd /= IDEX_RegRs) and (EXMEM_RegRd /= "00000")
		and (IDEX_RegRs /= "00000")) then
			ForwardA <= "00";
		
		elsif((MEMWB_RegWr ='1') and (EXMEM_RegWr ='1') and (IDEX_RegRt = MEMWB_RegRd)
		and (IDEX_RegRt /= "00000") and (MEMWB_RegRd /= "00000") and (EXMEM_RegRd /= IDEX_RegRs) and (EXMEM_RegRd /= "00000")
		and (IDEX_RegRs /= "00000")) then
			ForwardA <= "01";
		
		
		--EXMEM to EX RegisterRS Check
		elsif(( EXMEM_RegWr = '1' and (EXMEM_RegRd /= "00000") and (EXMEM_RegRd = IDEX_RegRs))) then
			ForwardA <= "10";
			
		-- default
		else
			ForwardA <= "00";
		end if;
		
		--EXMEM to EX RegisterRT Check
		if(( EXMEM_RegWr = '1' and (EXMEM_RegRd /= "00000") and (EXMEM_RegRd = IDEX_RegRt))) then
			ForwardB <= "10";
			
		--MEMWB to EX RegistersRS Check
		elsif((MEMWB_RegWr = '1') AND (MEMWB_RegRd /= "00000")
		AND NOT ((EXMEM_RegWr = '1') AND (EXMEM_RegRd /= "00000")
		AND (EXMEM_RegRd = IDEX_RegRt))
		AND (MEMWB_RegRd = IDEX_RegRt)) then
			ForwardB <= "01";
			
		elsif((MEMWB_RegWr ='1') and (EXMEM_RegWr ='1') and (IDEX_RegRs = MEMWB_RegRd)
		and (MEMWB_RegRd /= "00000") and (EXMEM_RegRd /= IDEX_RegRt) and (EXMEM_RegRd /= "00000")
		and (IDEX_RegRt /= "00000")) then
			ForwardB <= "01";
			
		-- default
		else
			ForwardB <= "00";
		end if;
		
	end process;
end behavior;