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

architecture mixed of ForwardingUnit is

    --component comparator_5 is
    --    port(i_d0 : in std_logic_vector(4 downto 0);
    --         i_d1 : in std_logic_vector(4 downto 0);
    --         o_o  : out std_logic);
    --end component;

    component gen_comparator_5 is 
        port(i_d0   : in std_logic_vector(4 downto 0);
             i_d1   : in std_logic_vector(4 downto 0);
             o_o    : out std_logic);
    end component;

    --signal ID_Rs,
    --       ID_Rt,
    --       EX_Rs,
    --       EX_Rt : std_logic_vector(4 downto 0);

    signal cond1,
           cond2,
           cond3,
           cond4,
           cond5,
           cond6,
           cond7,
           cond8 : std_logic;

    signal eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10 : std_logic;

    signal cat1, cat2, cat3, cat4 : std_logic_vector(1 downto 0);

    signal bInstr : std_logic;

    begin

        bInstr <= '1' when (i_ID_Inst(31 downto 26) = "000100" or 
                            i_ID_Inst(31 downto 26) = "000101") else
                  '0';

        --ID_Rs <= i_ID_Inst(25 downto 21);
        --ID_Rt <= i_ID_Inst(20 downto 16);
        --EX_Rs <= i_EX_Inst(25 downto 21);
        --EX_Rt <= i_EX_Inst(20 downto 16);

        o_muxASel <= b"00";
        o_muxBSel <= b"00";
        o_muxReadData1Sel <= b"00";
        o_muxReadData2Sel <= b"00";


        -- MUX A Selector

        --g_c1: gen_comparator_5
        --    port map(i_d0 => i_MEM_RegWrAddr,
        --             i_d1 => b"00000",
        --             o_o  => eq1);
        --
        --g_c2: gen_comparator_5
        --    port map(i_d0 => i_MEM_RegWrAddr,
        --             i_d1 => i_EX_Inst(25 downto 21),
        --             o_o  => eq2);
        --
        --g_c3: gen_comparator_5
        --    port map(i_d0 => i_WB_RegWrAddr,
        --             i_d1 => b"00000",
        --             o_o  => eq3);
        --
        --g_c4: gen_comparator_5
        --    port map(i_d0 => i_WB_RegWrAddr,
        --             i_d1 => i_EX_Inst(25 downto 21),
        --             o_o  => eq4);
--
        ----cond1 <= (i_MEM_RegWr and (not eq1) and eq2);
        --cond1 <= '1' when (i_MEM_RegWr = '1' and (not(eq1 = '1')) and eq2 = '1') else 
        --         '0';
--
        ----cond2 <= (i_WB_RegWr and (not eq3) and (not (i_MEM_RegWr and (not eq1) and eq2)) and eq4);
        --cond2 <= '1' when (i_WB_RegWr = '1' and (not(eq3 = '1')) and (not(i_MEM_RegWr = '1' and (not(eq1 = '1')) and eq2 = '1')) and eq4 = '1') else
        --         '0';
        --cat1 <= cond1 & cond2;
--
        --with cat1 select
        --    o_muxASel <= "10" when b"10",
        --                 "01" when b"01",
        --                 "00" when others;
--
        ---- MUX B Selector
--
        --g_c5: gen_comparator_5
        --    port map(i_d0 => i_MEM_RegWrAddr,
        --             i_d1 => i_EX_Inst(20 downto 16),
        --             o_o  => eq5);
--
        --g_c6: gen_comparator_5
        --    port map(i_d0 => i_WB_RegWrAddr,
        --             i_d1 => i_EX_Inst(20 downto 16),
        --             o_o  => eq6);
--
        ----cond3 <= (i_MEM_RegWr and (not eq1) and eq5);
        --cond3 <= '1' when (i_MEM_RegWr = '1' and (not(eq1 = '1')) and eq5 = '1') else
        --         '0';
        ----cond4 <= (i_WB_RegWr and (not eq3) and (not cond3) and eq6);
        --cond4 <= '1' when (i_WB_RegWr = '1' and (not(eq3 = '1')) and (not(i_MEM_RegWr = '1' and (not(eq1 = '1')) and eq5 = '1')) and eq6 = '1') else
        --         '0';
        --cat2 <= cond3 & cond4;
--
        --with cat2 select
        --    o_muxBSel <= "10" when b"10",
        --                 "01" when b"01",
        --                 "00" when others;
--
        ---- MUX Read Data2 Selector
--
        --g_c7: gen_comparator_5
        --port map(i_d0 => i_EX_RegWrAddr,
        --         i_d1 => i_ID_Inst(20 downto 16),
        --         o_o  => eq7);
--
        --g_c8: gen_comparator_5
        --port map(i_d0 => i_MEM_RegWrAddr,
        --         i_d1 => i_ID_Inst(20 downto 16),
        --         o_o  => eq8);
--
        ----cond5 <= (i_BranchSel = '1' and bInstr = '1' and eq7);
        --cond5 <= '1' when (i_BranchSel = '1' and bInstr = '1' and eq7 = '1') else
        --         '0';
        ----cond6 <= (i_BranchSel = '1' and bInstr = '1' and eq8);
        --cond6 <= '1' when (i_BranchSel = '1' and bInstr = '1' and eq8 = '1') else
        --         '0';
        --cat3 <= cond5 & cond6;
--
        --with cat3 select
        --    o_muxReadData2Sel <= b"10" when b"10",
        --                         b"01" when b"01",
        --                         b"00" when others;
--
        ---- MUX Read Data1 Selector
--
        --g_c9: gen_comparator_5
        --port map(i_d0 => i_EX_RegWrAddr,
        --         i_d1 => i_ID_Inst(25 downto 21),
        --         o_o  => eq9);
--
        --g_c10: gen_comparator_5
        --port map(i_d0 => i_MEM_RegWrAddr,
        --         i_d1 => i_ID_Inst(25 downto 21),
        --         o_o  => eq10);
--
        ----cond7 <= (i_BranchSel = '1' and bInstr = '1' and eq9);
        --cond7 <= '1' when (i_BranchSel = '1' and bInstr = '1' and eq9 = '1') else 
        --         '0';
        ----cond8 <= (i_BranchSel = '1' and bInstr = '1' and eq10);
        --cond8 <= '1' when (i_BranchSel = '1' and bInstr = '1' and eq10 = '1') else 
        --         '0';
        --cat4 <= cond7 & cond8;
--
        --with cat4 select
        --    o_muxReadData1Sel <= b"10" when b"10",
        --                         b"01" when b"01",
        --                         b"00" when others;

end mixed;