-------------------------------------------------------------------------
-- Daniel Rosenhamer
-------------------------------------------------------------------------
-- HazardUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of our hazard 
--              detection unit.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit is
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
end ForwardingUnit;

architecture structural of ForwardingUnit is

    component comparator_5 is
        port(i_d0 : in std_logic_vector(4 downto 0);
             i_d1 : in std_logic_vector(4 downto 0);
             o_o  : out std_logic);
    end component;

    signal ID_Rs,
           ID_Rt,
           EX_Rs,
           EX_Rt : std_logic_vector(4 downto 0);

    signal cond1,
           cond2,
           cond3,
           cond4,
           cond5,
           cond6,
           cond7,
           cond8 : std_logic;

    signal eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10 : std_logic;

    begin

        ID_Rs <= i_ID_Inst(25 downto 21);
        ID_Rt <= i_ID_Inst(20 downto 16);
        EX_Rs <= i_EX_Inst(25 downto 21);
        EX_Rt <= i_EX_Inst(20 downto 16);

        o_muxASel <= b"00";
        o_muxBSel <= b"00";
        o_muxReadData1Sel <= b"00";
        o_muxReadData2Sel <= b"00";


        -- MUX A Selector

        g_c1: comparator_5
            port map(i_d0 => i_MEM_RegWrAddr,
                     i_d1 => b"00000",
                     o_o  => eq1);
        
        g_c2: comparator_5
            port map(i_d0 => i_MEM_RegWrAddr,
                     i_d1 => EX_Rs,
                     o_o  => eq2);

        cond1 <= (i_MEM_RegWr and (not eq1) and eq2);
        
        g_c3: comparator_5
            port map(i_d0 => i_WB_RegWrAddr,
                     i_d1 => b"00000",
                     o_o  => eq3);
        
        g_c4: comparator_5
            port map(i_d0 => i_WB_RegWrAddr,
                     i_d1 => EX_Rs,
                     o_o  => eq4);

        cond2 <= (i_WB_RegWr and (not eq3) and (not (i_MEM_RegWr and (not eq1) and eq2)) and eq4);

        with (cond1 & cond2) select
            o_muxASel <= "10" when b"10",
                         "01" when b"01",
                         "00" when others;

        -- MUX B Selector

        g_c5: comparator_5
            port map(i_d0 => i_MEM_RegWrAddr,
                     i_d1 => EX_Rt,
                     o_o  => eq5);

        g_c6: comparator_5
            port map(i_d0 => i_WB_RegWrAddr,
                     i_d1 => EX_Rt,
                     o_o  => eq6);

        cond3 <= (i_MEM_RegWr and (not eq1) and eq5);

        cond4 <= (i_WB_RegWr and (not eq3) and (not cond3) and eq6);

        with (cond3 & cond4) select
            o_muxBSel <= "10" when b"10",
                         "01" when b"01",
                         "00" when others;

        -- MUX Read Data2 Selector

        g_c7: comparator_5
        port map(i_d0 => i_EX_RegWrAddr,
                 i_d1 => ID_Rt,
                 o_o  => eq7);

        cond5 <= (i_BranchSel and eq7);

        g_c8: comparator_5
        port map(i_d0 => i_MEM_RegWrAddr,
                 i_d1 => ID_Rt,
                 o_o  => eq8);

        cond6 <= (i_BranchSel and eq8);

        with cond5 & cond6 select
            o_muxReadData2Sel <= b"10" when b"10",
                                 b"01" when b"01",
                                 b"00" when others;

        -- MUX Read Data1 Selector

        g_c9: comparator_5
        port map(i_d0 => i_EX_RegWrAddr,
                 i_d1 => ID_Rs,
                 o_o  => eq9);

        cond7 <= (i_BranchSel and eq9);

        g_c10: comparator_5
        port map(i_d0 => i_MEM_RegWrAddr,
                 i_d1 => ID_Rs,
                 o_o  => eq10);

        cond8 <= (i_BranchSel and eq10);

        with cond7 & cond8 select
            o_muxReadData1Sel <= b"10" when b"10",
                                 b"01" when b"01",
                                 b"00" when others;

end structural;