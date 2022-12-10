-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_HazardUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- hazard unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_HazardUnit is

    generic(gCLK_HPER   : time := 50 ns);

end tb_HazardUnit;

architecture mixed of tb_HazardUnit is
  
    constant cCLK_PER  : time := gCLK_HPER * 2;
    
    component HazardUnit is
        port(i_ID_Inst  : in std_logic_vector(31 downto 0);
             i_EX_Inst  : in std_logic_vector(31 downto 0);
             i_MEM_Inst : in std_logic_vector(31 downto 0);
             i_WB_Inst  : in std_logic_vector(31 downto 0);
             
             i_JumpInstr  : in std_logic;
             i_BranchSel  : in std_logic;
             i_JumpReg    : in std_logic;
             
             i_EX_jal  : in std_logic;
             i_MEM_jal : in std_logic;
             i_WB_jal  : in std_logic;
             
             o_PC_Stall     : out std_logic;
             o_IF_ID_Stall  : out std_logic;
             o_ID_EX_Stall  : out std_logic;
             o_EX_MEM_Stall : out std_logic;
             o_MEM_WB_Stall : out std_logic;
             
             o_IF_Flush     : out std_logic;
             o_ID_EX_Flush  : out std_logic;
             o_EX_MEM_Flush : out std_logic;
             o_MEM_WB_Flush : out std_logic); 
    end component;

    signal s_ID_Inst,
           s_EX_Inst,
           s_MEM_Inst,
           s_WB_Inst : std_logic_vector(31 downto 0) := x"0000_0000";

    signal s_JumpInstr,
           s_BranchSel,
           s_JumpReg,
           s_EX_jal,
           s_MEM_jal,
           s_WB_jal : std_logic := '0';

    signal s_PC_Stall,     
           s_IF_ID_Stall,  
           s_ID_EX_Stall,  
           s_EX_MEM_Stall, 
           s_MEM_WB_Stall, 
           s_IF_Flush,     
           s_ID_EX_Flush,  
           s_EX_MEM_Flush, 
           s_MEM_WB_Flush : std_logic;

    begin
        DUT0: ForwardingUnit
        port map(i_ID_Inst  => s_ID_Inst,
                 i_EX_Inst  => s_EX_Inst,
                 i_MEM_Inst => s_MEM_Inst,
                 i_WB_Inst  => s_WB_Inst,
                              
                 i_JumpInstr  => s_JumpInstr,
                 i_BranchSel  => s_BranchSel,
                 i_JumpReg    => s_JumpReg,
                              
                 i_EX_jal  => s_EX_jal,
                 i_MEM_jal => s_MEM_jal,
                 i_WB_jal  => s_WB_jal,
                              
                 o_PC_Stall     => s_PC_Stall,
                 o_IF_ID_Stall  => s_IF_ID_Stall,
                 o_ID_EX_Stall  => s_ID_EX_Stall,
                 o_EX_MEM_Stall => s_EX_MEM_Stall,
                 o_MEM_WB_Stall => s_MEM_WB_Stall, 
                              
                 o_IF_Flush     => s_IF_Flush,
                 o_ID_EX_Flush  => s_ID_EX_Flush,
                 o_EX_MEM_Flush => s_EX_MEM_Flush,
                 o_MEM_WB_Flush => s_MEM_WB_Flush);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

------------------------------------------------
--------------- Shift Left Tests ---------------
------------------------------------------------

            -- Test case 0:
            s_ID_Inst   <= x"0000_0000";
            s_EX_Inst   <= x"0000_0000";
            s_MEM_Inst  <= x"0000_0000";
            s_WB_Inst   <= x"0000_0000";
            s_JumpInstr <= '0';
            s_BranchSel <= '0'; 
            s_JumpReg   <= '0'; 
            s_EX_jal    <= '0'; 
            s_MEM_jal   <= '0'; 
            s_WB_jal    <= '0'; 

            -- o_muxASel should equal 01

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0020_0000";
            s_MEM_RegWr     <= '1';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00001";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            -- o_muxASel should equal 10

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_ID_Inst       <= x"0020_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00001";
            s_MEM_RegWrAddr <= b"00001";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '1';

            -- o_muxReadData1Sel should equal 10

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_ID_Inst       <= x"0001_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00001";
            s_MEM_RegWrAddr <= b"00001";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '1';

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

            wait for gCLK_HPER*2;
    end process;

end mixed;