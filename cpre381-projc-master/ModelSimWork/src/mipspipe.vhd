-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
  signal s_DMemRE       : std_logic;
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_RegReadAddr1 : std_logic_vector(4 downto 0);
  signal s_RegReadAddr2 : std_logic_vector(4 downto 0);
  signal s_ShiftAmount : std_logic_vector(4 downto 0);
  signal s_ShiftAmount32 : std_logic_vector(31 downto 0);
  signal s_Immediate    : std_logic_vector(15 downto 0);
  signal s_ALUSrc       : std_logic;
  signal s_ALUOp        : std_logic_vector(5 downto 0); 
  signal s_Sign         : std_logic;
  signal s_luiCont      : std_logic;
  signal s_slvCont      : std_logic;
  signal s_RegData1     : std_logic_vector(31 downto 0);
  signal s_RegData2     : std_logic_vector(31 downto 0);
  signal s_Extended     : std_logic_vector(31 downto 0);
  signal s_luiShifted   : std_logic_vector(31 downto 0);
  signal s_LuiSelectOut : std_logic_vector(31 downto 0);
  signal s_ALUInB       : std_logic_vector(31 downto 0);
  signal s_selectedShift : std_logic_vector(31 downto 0);
  signal s_Zero         : std_logic;
  signal s_overflow     : std_logic;
  signal s_Zero1         : std_logic;
  signal s_overflow1     : std_logic;
  signal s_ALUOutToDmemMux : std_logic_vector(31 downto 0);

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal
  signal s_IMemToAdd    : std_logic_vector(N-1 downto 0); 
  signal s_IAddr	    : std_logic_vector(N-1 downto 0);
  signal s_BranchALU_Out : std_logic_vector(N-1 downto 0);	-- output of branch alu
  signal s_BranchMUX_Out : std_logic_vector(N-1 downto 0);
  signal s_BranchCtrl	: std_logic;
  signal s_branchEQ 	: std_logic;
  signal s_branchNE		:  std_logic;
  signal s_jump			: std_logic;
  signal s_jumpAddress	: std_logic_vector(N-1 downto 0);
  signal s_InstShift	: std_logic_vector(N-1 downto 0);
  signal s_jumpMUX_Out	: std_logic_vector(N-1 downto 0);
  signal s_jalCont 		: std_logic;
  signal s_JALmux_Out   : std_logic_vector(N-1 downto 0);
  signal s_memMuxResult : std_logic_vector(N-1 downto 0);
  signal s_jumpReg      : std_logic;
  signal s_jumpRegMuxOut: std_logic_vector(N-1 downto 0);
  signal s_jalAddr      : std_logic_vector(N-1 downto 0);
  
  -- output signals of IFID Register 
  signal s_Instr_IFID   : std_logic_vector(31 downto 0);
  signal s_PC_IFID		: std_logic_vector(31 downto 0);
  
  -- output signals of IDEX Register
  signal s_wb_IDEX		:  std_logic_vector(1 downto 0);
  signal s_mem_IDEX 	:  std_logic_vector(2 downto 0);
  signal s_ex_IDEX  	:  std_logic_vector(17 downto 0);
  signal s_PC_IDEX  	:  std_logic_vector(31 downto 0);
  signal s_reg1Data_IDEX :  std_logic_vector(31 downto 0);
  signal s_reg2Data_IDEX :  std_logic_vector(31 downto 0);
  signal s_extended_IDEX :  std_logic_vector(31 downto 0);
  
  -- output signals of EXMEM register 
  signal s_zero_EXMEM  	:  std_logic;
  signal s_wb_EXMEM		:  std_logic_vector(1 downto 0);
  signal s_mem_EXMEM 	:  std_logic_vector(2 downto 0);
  signal s_PC_EXMEM  	:  std_logic_vector(31 downto 0);
  signal s_aluResult_EXMEM 	:  std_logic_vector(31 downto 0);
  signal s_wrData_EXMEM 	:  std_logic_vector(31 downto 0);
  signal s_regDest_EXMEM 	:  std_logic_vector(4 downto 0);
  
  -- output signals of MEMWB Register
  signal s_wb_MEMWB	:  std_logic_vector(1 downto 0);
  signal s_dMemOut_MEMWB :  std_logic_vector(31 downto 0);
  signal s_aluResult_MEMWB :  std_logic_vector(31 downto 0);
  signal s_regDest_MEMWB :  std_logic_vector(4 downto 0);
  
  signal s_Stall, s_Flush : std_logic;
  signal s_branchExt : std_logic_vector(31 downto 0);
  
  
  -- signals needed in order for there to be no errors in modelSim
  signal branchExt : std_logic_vector(31 downto 0);
  signal s_wb : std_logic_vector(1 downto 0);
  signal s_mem : std_logic_vector(2 downto 0);
  signal s_ex  : std_logic_vector(17 downto 0);
  signal s_jumpInB : std_logic_vector(31 downto 0);
  signal s_LUI_inB	: std_logic_vector(31 downto 0);
  
  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));

    end component;
	
	-- IF/ID Pipeline Register 
	component IFIDReg IS 
	PORT(
		PC   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Instr   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
		reset : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		PC_IFID   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- output
		Instr_IFID   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
		);
	END component;

   component register32 is

      port(clk        : in std_logic;     -- Clock input
		   reset        : in std_logic;     -- Reset input
		   ld         : in std_logic;     -- Write enable input
		   d          : in std_logic_vector(31 downto 0);     -- Data value input
		   q          : out std_logic_vector(31 downto 0));

   end component;

   component registerFile is

      port(clk              : in std_logic;
	     readOne, readTwo : in std_logic_vector(4 downto 0);
	     writeAddress     : in std_logic_vector(4 downto 0);
	     writeData        : in std_logic_vector(31 downto 0);
	     reset            : in std_logic;
	     we               : in std_logic;
	     readDataOne      : out std_logic_vector(31 downto 0);
	     readDataTwo      : out std_logic_vector(31 downto 0);
		 regTwoData       : out std_logic_vector(31 downto 0));

   end component;
   
   component IDEXReg IS PORT(
		wb	: in std_logic_vector(1 downto 0);
		mem : in std_logic_vector(2 downto 0);
		ex  : in std_logic_vector(17 downto 0);
		PC  : in std_logic_vector(31 downto 0);
		reg1Data : in std_logic_vector(31 downto 0);
		reg2Data : in std_logic_vector(31 downto 0);
		extended : in std_logic_vector(31 downto 0);
		ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
		reset : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		wb_IDEX	: out std_logic_vector(1 downto 0);
		mem_IDEX : out std_logic_vector(2 downto 0);
		ex_IDEX  : out std_logic_vector(17 downto 0);
		PC_IDEX  : out std_logic_vector(31 downto 0);
		reg1Data_IDEX : out std_logic_vector(31 downto 0);
		reg2Data_IDEX : out std_logic_vector(31 downto 0);
		extended_IDEX : out std_logic_vector(31 downto 0)
		);
	END component;
	
	component EXMEMReg IS 
		PORT(
		wb	: in std_logic_vector(1 downto 0);
		mem : in std_logic_vector(2 downto 0);
		PC  : in std_logic_vector(31 downto 0);
		aluResult : in std_logic_vector(31 downto 0);
		wrData : in std_logic_vector(31 downto 0);
		regDest : in std_logic_vector(4 downto 0);
		zero : in std_logic;
		ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
		reset : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		zero_EXMEM  : out std_logic;
		wb_EXMEM	: out std_logic_vector(1 downto 0);
		mem_EXMEM : out std_logic_vector(2 downto 0);
		PC_EXMEM  : out std_logic_vector(31 downto 0);
		aluResult_EXMEM : out std_logic_vector(31 downto 0);
		wrData_EXMEM : out std_logic_vector(31 downto 0);
		regDest_EXMEM : out std_logic_vector(4 downto 0)
		);
	end component;
	
	
	component MEMWBReg IS 
		PORT(
		wb	: in std_logic_vector(1 downto 0);
		dMemOut : in std_logic_vector(31 downto 0);
		aluResult : in std_logic_vector(31 downto 0);
		regDest : in std_logic_vector(4 downto 0);
		ld  : IN STD_LOGIC; -- load/enable.
		rd  : IN STD_LOGIC; --read from reg enable
		reset : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		wb_MEMWB	: out std_logic_vector(1 downto 0);
		dMemOut_MEMWB : out std_logic_vector(31 downto 0);
		aluResult_MEMWB : out std_logic_vector(31 downto 0);
		regDest_MEMWB : out std_logic_vector(4 downto 0)
		);
	END component;
	
   component control is

      port(i_Instr : in std_logic_vector(31 downto 0);
           o_Raddr1 : out std_logic_vector(4 downto 0);
           o_Raddr2 : out std_logic_vector(4 downto 0);
           o_Waddr : out std_logic_vector(4 downto 0);
           o_Shamt : out std_logic_vector(4 downto 0);
           o_Imme : out std_logic_vector(15 downto 0);
           o_ALUSrc : out std_logic;
           o_ALUOp : out std_logic_vector(5 downto 0);
           o_MemRead : out std_logic;
           o_MemWrite : out std_logic;
           o_RegWrite : out std_logic;
           o_signCont : out std_logic;
           o_luiCont  : out std_logic;
           o_slvCont  : out std_logic;
		   o_branchEQ : out std_logic;
		   o_branchNE : out std_logic;
		   o_jump	  : out std_logic;
		   o_jalCont  : out std_logic;
		   o_jumpReg  : out std_logic);

   end component;

   component FullALU is

      port(op_ALU		:	in std_logic_vector(2 downto 0);
	   op_Shifter         	:	in std_logic_vector(1 downto 0);
	   op_Select	        :	in std_logic;
	   i_A			: 	in std_logic_vector(31 downto 0);
	   i_B			:	in std_logic_vector(31 downto 0);
	   i_Shamt	        :	in std_logic_vector(4 downto 0);
	   o_F			:	out std_logic_vector(31 downto 0);
       o_Zero		:	out std_logic;
	   o_Overflow	        :	out std_logic);

   end component;

   component mux_df is
      
      port(iA 		:	in std_logic_vector(31 downto 0);
	   iB 		: 	in std_logic_vector(31 downto 0);
	   iCtrl	: 	in std_logic;
	   Q		: 	out std_logic_vector(31 downto 0));

   end component;

   component shifter is

      port(i_A : in std_logic_vector(31 downto 0);
           i_ShiftAmount : in std_logic_vector(4 downto 0);
           i_Select : in std_logic_vector(1 downto 0);
           o_F : out std_logic_vector(31 downto 0));

   end component;

   component extender is

      port(input : in std_logic_vector(15 downto 0);
           sel  : in std_logic;
           output: out std_logic_vector(31 downto 0));

   end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
			 
regIFID: IFIDReg
	port map(
		PC   => s_IAddr,
		Instr   => s_Inst,
		ld  => s_Stall, -- load/enable.
		rd  => s_Stall, --read from reg enable
		reset => s_Flush, -- async. clear.
		clk => iCLK, -- clock.
		PC_IFID   => s_PC_IFID, -- output
		Instr_IFID  => s_Instr_IFID);



DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_aluResult_EXMEM(11 downto 2),
             data => s_wrData_EXMEM,
             we   => s_mem_EXMEM(0),
             q    => s_DMemOut);

s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

	-- Register used to store PC
  PC : register32
     port map(clk 	=> iCLK,
              reset => iRST,
              ld 	=> '1',
              d 	=> s_jumpRegMuxOut,
              q 	=> s_NextInstAddr);
  
  
  -- Mux used in chain of PC logic that selects the register for a jr instruction
  jumpRegMux : mux_df
    port map(iA 	=> s_jumpMUX_OUT,												-- output of the read1 port - this will 
	     iB 		=> s_RegData1,													-- address in instruction memory where we will jump to 
	     iCtrl 		=> s_jumpReg,													-- jr instruction control signal
	     Q 			=> s_jumpRegMuxOut);											-- output of the jump multiplexer that will be fed into the jump and link mux
  
  pcAdd4 : FullALU
    port map(op_ALU => "010",						
	     op_Shifter => "00",
	     op_Select 	=> '1',
	     i_A 		=> s_NextInstAddr,
	     i_B 		=> x"00000004",
	     i_Shamt 	=> "00000",
	     o_F 		=> s_IAddr,
         o_Zero 	=> s_Zero1,
	     o_Overflow => s_overflow1);
	
	
	branchExt <= s_extended_IDEX(29 downto 0) & "00";
	-- Adder ALU unit that is used for calculating branch address on a branch instruction
  branchALU : FullALU
    port map(op_ALU => "010",
	     op_Shifter => "00",
	     op_Select 	=> '1',
	     i_A 		=> s_PC_EXMEM,														-- input of branch ALU is PC+4
	     i_B 		=> branchExt,
	     i_Shamt 	=> "00000",
	     o_F 		=> s_BranchALU_Out,												-- output of branch ALU that will be sent to 1 port of branch mux
         o_Zero 	=> open,														-- don't need this zero output
	     o_Overflow => open);														-- don't care about overflow here


  s_BranchCtrl <= (s_mem_EXMEM(2) and s_zero_EXMEM) or (s_mem_EXMEM(1) and (not s_zero_EXMEM));

	-- mux in chain of PC counter logic used for branch instructions
  branchMux : mux_df
	port map(iA 	=> s_PC_EXMEM,														-- immediate extended
	     iB 		=> s_BranchALU_Out,												-- output of the branch ALU that has the branch address 
	     iCtrl 		=> s_BranchCtrl,												-- branch instruction control
	     Q 			=> s_BranchMUX_Out);											-- output of the multiplexer that will be fed into the jump mux


	s_jumpInB <= s_PC_EXMEM(31 downto 28) & (s_Inst(25 downto 0) & "00");
	-- mux in chain of PC counter logic used for jump instructions
  jumpMUX : mux_df
    port map(iA 	=> s_BranchMUX_Out,												-- output of the branch mux - which will be either the branch address or PC + 4
	     iB 		=> s_jumpInB,		-- address in instruction memory where we will jump to 
	     iCtrl 		=> s_jump,														-- jump instruction control
	     Q 			=> s_jumpMUX_Out);												-- output of the jump multiplexer that will be fed into the jump and link mux


	-- Control unit component that drives all of the signals in the processor
   controller :  control
      port map(i_Instr 		=> s_Instr_IFID,
               o_Raddr1 	=> s_RegReadAddr1,
               o_Raddr2 	=> s_RegReadAddr2,
               o_Waddr 		=> s_RegWrAddr,
               o_Shamt 		=> s_ShiftAmount,
               o_Imme 		=> s_Immediate,
               o_ALUSrc 	=> s_ALUSrc,
               o_ALUOp 		=> s_ALUOp,
               o_MemRead 	=> s_DMemRE,
               o_MemWrite 	=> s_DMemWr,
               o_RegWrite 	=> s_RegWr,
               o_signCont 	=> s_Sign,
               o_luiCont	=> s_luiCont,
               o_slvCont 	=> s_slvCont,
			   o_branchEQ 	=> s_branchEQ,
			   o_branchNE 	=> s_branchNE,
			   o_jump	  	=> s_jump,
			   o_jalCont  	=> s_jalCont,
			   o_jumpReg  	=> s_jumpReg);
	
	-- register file component. Address inputs and enable controls come from control component, data input from JAL mux/ 
  registers : registerFile
    port map(clk 		=> iCLK,
	     readOne 		=> s_RegReadAddr1,
         readTwo 		=> s_RegReadAddr2,
	     writeAddress 	=> s_regDest_MEMWB,		-- will be sent at end of last pipeline stage
	     writeData 		=> s_RegWrData,
	     reset 			=> iRST,
	     we 			=> s_wb_MEMWB(1),				-- will be the sent at the end of last pipeline stage.. not there yet
	     readDataOne 	=> s_RegData1,
	     readDataTwo 	=> s_RegData2,
		 regTwoData 	=> v0);
		 
		 
		 
	s_wb <= s_RegWr & s_DMemRE;
	s_mem <= s_branchEQ & s_branchNE & s_DMemWr;
	s_ex <= s_ALUSrc & s_ALUOp & s_slvCont & s_ShiftAmount & s_RegWrAddr;
	
	regIDEX: IDEXReg 
	PORT map(
		wb	=> s_wb,											-- control signals needed for write back stage 
		mem => s_mem,							-- control signals needed for mem stage
		ex  => s_ex, -- control signals needed for EX stage
		PC  => s_PC_IFID,													-- PC continues through pipeline
		reg1Data => s_RegData1,												
		reg2Data => s_RegData2,
		extended => s_LuiSelectOut,											-- might have issues with this
		ld  => s_Stall, -- load/enable.
		rd  => s_Stall, --read from reg enable
		reset => s_Flush, -- async. clear.
		clk => iCLK, -- clock.
		wb_IDEX	=> s_wb_IDEX,				-- regWriteEnable & s_DMemRE Control signals
		mem_IDEX => s_mem_IDEX,				-- s_branchEQ & s_branchNE & s_DMemWr Control Signals
		ex_IDEX  => s_ex_IDEX,				-- aluSrc & aluOpcode & s_slvCont & shamt & regDestAddr
		PC_IDEX  => s_PC_IDEX,				-- value of original PC+4, branch or jump address will be calculated in ex stage 
		reg1Data_IDEX => s_reg1Data_IDEX,
		reg2Data_IDEX => s_reg2Data_IDEX,
		extended_IDEX => s_extended_IDEX
		);
		 
	-- sign extender component
  extend :  extender
    port map(input 		=> s_Immediate,
             sel 		=> s_Sign,
             output 	=> s_Extended);

	s_LUI_inB <= s_Immediate & x"0000";
	-- Mux to help with LUI instructions
  luiSelector : mux_df
    port map(iA 		=> s_Extended,					-- immediate extended
	     iB 			=> s_LUI_inB,		-- upper immediate
	     iCtrl 			=> s_luiCont,
	     Q 				=> s_LuiSelectOut);

	-- ALU Source Mux
  aluSourceSelector :  mux_df
    port map(iA 		=> s_reg2Data_IDEX,
	     iB 			=> s_LuiSelectOut,
	     iCtrl 			=> s_ex_IDEX(17),
	     Q 				=> s_ALUInB);


   s_ShiftAmount32 <= (31 downto 5 => '0') & s_ex_IDEX(9 downto 5); --5bit mux wasnt working, make the 5 bit shift amount 32 bits and only select the first 5 bits later


	-- Component that helps with srav/srlv shifts
  shiftVarSelect :  mux_df
    port map(iA 		=> s_ShiftAmount32,
	     iB 			=> s_reg2Data_IDEX,
	     iCtrl 			=> s_ex_IDEX(10),
	     Q 				=> s_selectedShift);


	-- Main ALU component that performs various arithmetic, output sent to input of dMemory and also to the input of memToRegMux
  alu : FullAlu
    port map(op_ALU 	=> s_ex_IDEX(16 downto 14),
	     op_Shifter 	=> s_ex_IDEX(13 downto 12),
	     op_Select 		=> s_ex_IDEX(11),
	     i_A		 	=> s_reg1Data_IDEX,
	     i_B 			=> s_ALUInB,
	     i_Shamt 		=> s_selectedShift(4 downto 0),
	     o_F 			=> s_DmemAddr,
         o_Zero 		=> s_Zero,
	     o_Overflow 	=> s_overflow);

  s_DmemData 		<= s_reg2Data_IDEX;
  s_ALUOutToDmemMux <= s_DmemAddr;


	regEXMEM: EXMEMReg
		PORT map(
		wb	=> s_wb_IDEX,
		mem => s_mem_IDEX,
		PC  => s_PC_IDEX,
		aluResult => s_ALUOutToDmemMux,
		wrData => s_DMemData,
		regDest => s_ex_IDEX(4 downto 0),
		zero => s_Zero,
		ld  => s_Stall, -- load/enable.
		rd  => s_Stall, --read from reg enable
		reset => s_Flush, -- async. clear.
		clk => iCLK, -- clock.
		zero_EXMEM  => s_zero_EXMEM,
		wb_EXMEM	=> s_wb_EXMEM,
		mem_EXMEM => s_mem_EXMEM,
		PC_EXMEM  => s_PC_EXMEM,
		aluResult_EXMEM => s_aluResult_EXMEM,
		wrData_EXMEM => s_wrData_EXMEM,
		regDest_EXMEM => s_regDest_EXMEM
		);
	
	
	regMEMWB: MEMWBReg  
		PORT map(
		wb  => s_wb_EXMEM,
		dMemOut => s_dMemOut,
		aluResult => s_aluResult_EXMEM,
		regDest => s_regDest_EXMEM,
		ld  => s_Stall,
		rd  => s_Stall,
		reset => s_Flush,
		clk => iCLK,
		wb_MEMWB => s_wb_MEMWB,
		dMemOut_MEMWB => s_dMemOut_MEMWB,
		aluResult_MEMWB => s_aluResult_MEMWB,
		regDest_MEMWB => s_regDest_MEMWB
		);

	-- Component that sends either the ALU output or the dMemory output into the input of the JALmux
  memToRegMux : mux_df
    port map(iA 		=> s_aluResult_MEMWB,
	     iB 			=> s_dMemOut_MEMWB,
	     iCtrl 			=> s_wb_MEMWB(0), 		-- will be a new signal in a little bit
	     Q 				=> s_memMuxResult);
	
	
	-- may have problems here after pipelining 
	process(s_IAddr)
		begin
		if( s_IAddr(22) = '1') then
			s_jalAddr <= s_IAddr;
		else
			s_jalAddr <= x"00400000" or s_IAddr;
		end if;
	end process;
	
	-- This component selects if we write to the return address register ($31) or just do a normal write to the reg file
  jalMux : mux_df
	port map(iA 		=> s_memMuxResult,		-- will select normal write data when control is zero 
	     iB 			=> s_jalAddr,			-- will select PC + 4 to write data when control is 1
	     iCtrl 			=> s_jalCont,			-- control for jump and link instruction
	     Q 				=> s_RegWrData);		-- output of the jump multiplexer that will be fed into the jump and link mux

end structure;
