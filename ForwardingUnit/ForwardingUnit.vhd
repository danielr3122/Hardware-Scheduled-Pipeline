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

        -- cond1 <= ((i_MEM_RegWr = '1') and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rs));
        
        g_c1: comparator_5
            port map(i_d0 => i_MEM_RegWrAddr,
                     i_d1 => b"00000",
                     o_o  => eq1);
        
        g_c2: comparator_5
            port map(i_d0 => i_MEM_RegWrAddr,
                     i_d1 => EX_Rs,
                     o_o  => eq2);

        cond1 <= (i_MEM_RegWr and (not eq1) and eq2);

        -- cond2 <= ((i_WB_RegWr = '1')  and (i_WB_RegWrAddr /= "00000") and (not(cond1))  and (i_WB_RegWrAddr = EX_Rs));
        
        g_c3: comparator_5
            port map(i_d0 => i_WB_RegWrAddr,
                     i_d1 => b"00000",
                     o_o  => eq3);
        
        g_c4: comparator_5
            port map(i_d0 => i_WB_RegWrAddr,
                     i_d1 => EX_Rs,
                     o_o  => eq4);

        cond2 <= (i_WB_RegWr and (not eq3) and (not cond1) and eq4);

        o_muxASel <= (cond1 & cond2);

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

        -- cond3 <= ((i_MEM_RegWr = '1')  and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rt));

        cond4 <= (i_WB_RegWr and (not eq3) and (not cond3) and eq6);

        o_muxBSel <= cond3 & cond4;

        -- cond4 <= ((i_WB_RegWr = '1')  and  (i_WB_RegWrAddr /= "00000") and (not(cond3))  and (i_WB_RegWrAddr = EX_Rt));

        -- with cond3 & cond4 select
        --     o_muxBSel <= b"10" when b"10",
        --                  b"01" when b"01",
        --                  b"00" when others;

        -- MUX Read Data2 Selector

        g_c7: comparator_5
        port map(i_d0 => i_EX_RegWrAddr,
                 i_d1 => ID_Rt,
                 o_o  => eq7);

        cond5 <= (i_BranchSel and eq7);

        -- cond5 <= ((i_BranchSel = '1') and (i_EX_RegWrAddr = ID_Rt));

        g_c8: comparator_5
        port map(i_d0 => i_MEM_RegWrAddr,
                 i_d1 => ID_Rt,
                 o_o  => eq8);

        cond6 <= (i_BranchSel and eq8);

        o_muxReadData2Sel <= (cond5 & cond6);

        -- cond6 <= ((i_BranchSel = '1') and (i_MEM_RegWrAddr = ID_Rt));

        -- with cond5 & cond6 select
        --     o_muxReadData2Sel <= b"10" when b"10",
        --                          b"01" when b"01",
        --                          b"00" when others;

        -- MUX Read Data1 Selector

        g_c9: comparator_5
        port map(i_d0 => i_EX_RegWrAddr,
                 i_d1 => ID_Rs,
                 o_o  => eq9);

        cond7 <= (i_BranchSel and eq9);

        -- cond7 <= ((i_BranchSel = '1') and (i_EX_RegWrAddr = ID_Rs));

        g_c10: comparator_5
        port map(i_d0 => i_MEM_RegWrAddr,
                 i_d1 => ID_Rs,
                 o_o  => eq10);

        cond8 <= (i_BranchSel and eq10);

        o_muxReadData1Sel <= (cond7 & cond8);

        -- cond8 <= ((i_BranchSel = '1') and (i_MEM_RegWrAddr = ID_Rs));

        -- with cond7 & cond8 select
        --     o_muxReadData1Sel <= b"10" when b"10",
        --                          b"01" when b"01",
        --                          b"00" when others;

        -- process(EX_Rs, EX_Rt, i_MEM_RegWr, i_WB_RegWr, i_MEM_RegWrAddr, i_WB_RegWrAddr, ID_Rs, ID_Rt, i_BranchSel) is
            
            -- begin

                -- o_muxASel <= b"00";
                -- o_muxBSel <= b"00";
                -- o_muxReadData1Sel <= b"00";
                -- o_muxReadData2Sel <= b"00";

                -- if(i_MEM_RegWr = '1' and (i_MEM_RegWrAddr /= "00000") and i_MEM_RegWrAddr = EX_Rs) then
                --     o_muxASel <= "10";
                -- elsif(i_WB_RegWr = '1'  and (i_WB_RegWrAddr /= "00000") and not(i_MEM_RegWr = '1' and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rs))  and i_WB_RegWrAddr = EX_Rs) then
                --     o_muxASel <= "01";
                -- end if;

                -- if(i_MEM_RegWr = '1'  and (i_MEM_RegWrAddr /= "00000") and i_MEM_RegWrAddr = EX_Rt) then
                --     o_muxBSel <= "10";
                -- elsif(i_WB_RegWr = '1'  and  (i_WB_RegWrAddr /= "00000") and not(i_MEM_RegWr ='1' and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rt))  and i_WB_RegWrAddr = EX_Rt) then
                --     o_muxBSel <= "01";
                -- end if;

                -- if(i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rt)) then
                --     o_muxReadData2Sel <= "10";
                -- elsif(i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rt)) then
                --     o_muxReadData2Sel <= "01";
                -- end if;

                -- if(i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rs)) then
                --     o_muxReadData1Sel <= "10";
                -- elsif(i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rs)) then
                --     o_muxReadData1Sel <= "01";
                -- end if;

        -- end process;
        
end structural;