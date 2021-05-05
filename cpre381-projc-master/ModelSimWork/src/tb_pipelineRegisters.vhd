library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pipelineRegisters is
    generic(gCLK_HPER   : time := 50 ns);
end tb_pipelineRegisters;

architecture behavior of tb_pipelineRegisters is

--Calculate the clock period as twice the half-period
constant cCLK_PER  : time := gCLK_HPER * 2;

component IFIDReg 
	port(
		d   : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    	ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
   		reset : IN STD_LOGIC; -- async. clear.
    	clk : IN STD_LOGIC; -- clock.
    	q   : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)); -- output
end component;

component IDEXReg
	port(
		d   : IN STD_LOGIC_VECTOR(159 DOWNTO 0);
    	ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
    	reset : IN STD_LOGIC; -- async. clear.
    	clk : IN STD_LOGIC; -- clock.
    	q   : OUT STD_LOGIC_VECTOR(159 DOWNTO 0)); -- output
end component;

component MEMWBReg
	port(
		d   : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    	ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
    	reset : IN STD_LOGIC; -- async. clear.
    	clk : IN STD_LOGIC; -- clock.
    	q   : OUT STD_LOGIC_VECTOR(79 DOWNTO 0)); -- output
end component;

component EXMEMReg
	port(
		d   : IN STD_LOGIC_VECTOR(111 DOWNTO 0);
    	ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
    	reset : IN STD_LOGIC; -- async. clear.
    	clk : IN STD_LOGIC; -- clock.
   		q   : OUT STD_LOGIC_VECTOR(111 DOWNTO 0)); -- output
end component;

signal s_CLK : std_logic;
--Signals to and from the IF/ID Register--

signal s_IFID_i : std_logic_vector(63 downto 0);
signal s_IFID_o : std_logic_vector(63 downto 0);
signal s_stallIFID : std_logic;
signal s_flushIFID : std_logic;
--signal s_instruction : std_logic_vector(31 downto 0);
--signal s_PCPlusFour_if : std_logic_vector(31 downto 0);

--Signals to and from the ID/EX Register--

signal s_IDEX_i : std_logic_vector(159 downto 0) := x"0000000000000000000000000000000000000000";
signal s_IDEX_o : std_logic_vector(159 downto 0);
signal s_stallIDEX : std_logic;
signal s_flushIDEX : std_logic;
--signal s_ALUSrc_rf : std_logic;
--signal s_ALUOp_rf : std_logic;
--signal s_MemToReg_rf : std_logic;
--signal s_DMemWr_rf : std_logic;
--signal s_RegWr_rf : std_logic;
--signal s_LuiCont_rf : std_logic;
--signal s_SvCont_rf : std_logic;
--signal s_jump_rf : std_logic;
--signal s_branchEQ_rf : std_logic;
--signal s_branchNE_rf : std_logic;
--signal s_JalCont_rf : std_logic;
--signal s_JrCont_rf : std_logic;
--signal s_regAddr1_rf : std_logic_vector(4 downto 0);
--signal s_regAddr2_rf : std_logic_vector(4 downto 0);
--signal s_wrAddr_rf : std_logic_vector(4 downto 0);
--signal s_regData1_rf : std_logic_vector(31 downto 0);
--signal s_regData2_rf : std_logic_vector(31 downto 0);
--signal s_immediate_rf : std_logic_vector(31 downto 0);
--signal s_PCPlusFour_rf : std_logic_vector(31 downto 0);
--signal s_shift_rf : std_logic_vector(4 downto 0);

--Signals to and from the EX/MEM Register--

signal s_EXMEM_i : std_logic_vector(111 downto 0) := x"0000000000000000000000000000";
signal s_EXMEM_o : std_logic_vector(111 downto 0);
signal s_stallEXMEM : std_logic;
signal s_flushEXMEM : std_logic;
--signal s_DMemWr_ex : std_logic;
--signal s_MemToReg_ex : std_logic;
--signal s_RegWr_ex : std_logic;
--signal s_jump_ex : std_logic;
--signal s_branchEQ_ex : std_logic;
--signal s_branchNE_ex : std_logic;
--signal s_JrCont_ex : std_logic;
--signal s_ALUOut_ex : std_logic_vector(31 downto 0);
--signal s_ALUBIn_ex : std_logic_vector(31 downto 0);
--signal s_wrAddr_ex : std_logic_vector(4 downto 0);
--signal s_PCPlusFour_ex : std_logic_vector(31 downto 0);

--Signals to and from the MEM/WB Register--

signal s_MEMWB_i : std_logic_vector(79 downto 0) := x"00000000000000000000";
signal s_MEMWB_o : std_logic_vector(79 downto 0);
signal s_stallMEMWB : std_logic;
signal s_flushMEMWB : std_logic;
--signal s_MemToReg_mem : std_logic;
--signal s_RegWr_mem : std_logic;
--signal s_memData_mem : std_logic_vector(31 downto 0);
--signal s_ALUOut_mem : std_logic_vector(31 dowtno 0);
--signal s_WrAddr_mem : std_logic_vector(4 downto 0);

begin

IFID: IFIDReg
	port map(
		d   => s_IFID_i,
    	ld  => s_stallIFID,
		rd  => s_stallIFID,
   		reset => s_flushIFID,
    	clk => s_CLK,
    	q   => s_IFID_o);

--Fill in the rest of the data since we dont actually have a register file or control unit to fill these in

IDEX : IDEXReg
	port map(
		d  => s_IDEX_i,
    	ld  => s_stallIDEX,
		rd  => s_stallIDEX,
    	reset => s_flushIDEX,
    	clk => s_CLK,
    	q  => s_IDEX_o);
		
s_EXMEM_i <= s_IDEX_o(159 downto 48);
		
EXMEM : EXMEMReg
	port map(
		d   => s_EXMEM_i,
    	ld  => s_stallEXMEM,
		rd  => s_stallEXMEM,
    	reset => s_flushEXMEM,
    	clk => s_CLK,
   		q   => s_EXMEM_o);
		
s_MEMWB_i <= s_EXMEM_o(111 downto 32);

MEMWB : MEMWBReg
	port map(
		d   => s_MEMWB_i,
    	ld  => s_stallMEMWB,
		rd  => s_stallMEMWB,
    	reset => s_flushMEMWB,
    	clk => s_CLK,
   		q   => s_MEMWB_o);
		
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
end process;

P_TB: process
begin
	s_flushIFID <= '1';
	s_flushIDEX <= '1';
	s_flushEXMEM <= '1';
	s_flushMEMWB <= '1';
	wait for cCLK_PER;
	

	s_IFID_i <= x"0123456789ABCDEF";
	s_IDEX_i <= s_IFID_o(31 downto 0) & (127 downto 0 => '0');
	s_stallIFID <= '1';
	s_flushIFID <= '0';
	s_stallIDEX <= '1';
	s_flushIDEX <= '0';
	s_stallEXMEM <= '1';
	s_flushEXMEM <= '0';
	s_stallMEMWB <= '1';
	s_flushMEMWB <= '0';
	wait for cCLK_PER;

	s_IFID_i <= x"F0F0F0F0F0F0F0F0";
	s_IDEX_i <= s_IFID_o(31 downto 0) & (127 downto 0 => '0');
	s_stallIFID <= '1';
	s_flushIFID <= '0';
	s_stallIDEX <= '1';
	s_flushIDEX <= '0';
	s_stallEXMEM <= '1';
	s_flushEXMEM <= '0';
	s_stallMEMWB <= '1';
	s_flushMEMWB <= '0';
	wait for cCLK_PER;

	s_IFID_i <= x"FFFFFFFFFFFFFFFF";
	s_IDEX_i <= s_IFID_o(31 downto 0) & (127 downto 0 => '0');
	s_stallIFID <= '1';
	s_flushIFID <= '0';
	s_stallIDEX <= '1';
	s_flushIDEX <= '0';
	s_stallEXMEM <= '1';
	s_flushEXMEM <= '0';
	s_stallMEMWB <= '1';
	s_flushMEMWB <= '0';
	wait for cCLK_PER;

	s_IFID_i <= x"14362850194A458F";
	s_IDEX_i <= s_IFID_o(31 downto 0) & (127 downto 0 => '0');
	s_stallIFID <= '1';
	s_flushIFID <= '0';
	s_stallIDEX <= '1';
	s_flushIDEX <= '0';
	s_stallEXMEM <= '1';
	s_flushEXMEM <= '0';
	s_stallMEMWB <= '1';
	s_flushMEMWB <= '0';
	wait for cCLK_PER;
	
	-- stall 
	s_stallIFID <= '0';
	wait for cCLK_PER;
	s_stallIDEX <= '0';
	wait for cCLK_PER;
	s_stallEXMEM <= '0';
	wait for cCLK_PER;
	s_stallMEMWB <= '0';
	wait for cCLK_PER;
	
	
	-- flush
	s_flushIFID <= '1';
	wait for cCLK_PER;
	s_flushIDEX <= '1';
	wait for cCLK_PER;
	s_flushEXMEM <= '1';
	wait for cCLK_PER;
	s_flushMEMWB <= '1';
	wait for cCLK_PER;
	
	

	wait;
  end process;
end behavior;
    