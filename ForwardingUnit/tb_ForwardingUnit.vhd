-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_ForwardingUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- forwarding unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ForwardingUnit is

    generic(gCLK_HPER   : time := 50 ns);

end tb_ForwardingUnit;

architecture mixed of tb_ForwardingUnit is
  
    constant cCLK_PER  : time := gCLK_HPER * 2;
    
    component ForwardingUnit is
        port(i_ID_Inst  : in std_logic_vector(31 downto 0);
             i_EX_Inst  : in std_logic_vector(31 downto 0);
            
             i_MEM_RegWr : in std_logic;
             i_WB_RegWr  : in std_logic;

             i_EX_RegWrAddr  : in std_logic_vector(4 downto 0);
             i_MEM_RegWrAddr : in std_logic_vector(4 downto 0);
             i_WB_RegWrAddr  : in std_logic_vector(4 downto 0);
 
             i_BranchSel : in std_logic;
 
             o_muxASel : out std_logic_vector(1 downto 0);
             o_muxBSel : out std_logic_vector(1 downto 0);
 
             o_muxReadData1Sel : out std_logic_vector(1 downto 0);
             o_muxReadData2Sel : out std_logic_vector(1 downto 0)); 
    end component;

    signal s_ID_Inst,
           s_EX_Inst : std_logic_vector(31 downto 0) := x"0000_0000";
        
    signal s_MEM_RegWr,
           s_WB_RegWr,
           s_BranchSel : std_logic := '0';

    signal s_EX_RegWrAddr,
           s_MEM_RegWrAddr,
           s_WB_RegWrAddr : std_logic_vector(4 downto 0) := b"00000";

    signal s_muxASel,
           s_muxBSel,
           s_muxReadData1Sel,
           s_muxReadData2Sel : std_logic_vector(1 downto 0);

    begin
        DUT0: ForwardingUnit
        port map(i_ID_Inst          => s_ID_Inst,
                 i_EX_Inst          => s_EX_Inst,
                 i_MEM_RegWr        => s_MEM_RegWr,
                 i_WB_RegWr         => s_WB_RegWr,
                 i_EX_RegWrAddr     => s_EX_RegWrAddr,
                 i_MEM_RegWrAddr    => s_MEM_RegWrAddr,
                 i_WB_RegWrAddr     => s_WB_RegWrAddr,
                 i_BranchSel        => s_BranchSel,
                 o_muxASel          => s_muxASel,
                 o_muxBSel          => s_muxBSel,
                 o_muxReadData1Sel  => s_muxReadData1Sel,
                 o_muxReadData2Sel  => s_muxReadData2Sel);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

------------------------------------------------
--------------- Shift Left Tests ---------------
------------------------------------------------

            -- Test case 0:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0030_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '1';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00001";
            s_BranchSel     <= '0';

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
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '1';

            -- o_muxReadData1Sel should equal 10

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_ID_Inst       <= x"0000_0000";
            s_EX_Inst       <= x"0000_0000";
            s_MEM_RegWr     <= '0';
            s_WB_RegWr      <= '0';
            s_EX_RegWrAddr  <= b"00000";
            s_MEM_RegWrAddr <= b"00000";
            s_WB_RegWrAddr  <= b"00000";
            s_BranchSel     <= '0';

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