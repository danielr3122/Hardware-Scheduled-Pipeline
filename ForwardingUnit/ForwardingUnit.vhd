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

    signal ID_Rs,
           ID_Rt,
           EX_Rs,
           EX_Rt : std_logic_vector(4 downto 0);

    begin

        ID_Rs <= i_ID_Inst(25 downto 21);
        ID_Rt <= i_ID_Inst(20 downto 16);
        EX_Rs <= i_EX_Inst(25 downto 21);
        EX_Rt <= i_EX_Inst(20 downto 16);

        process(EX_Rs, EX_Rt, i_MEM_RegWr, i_WB_RegWr, i_EX_RegWrAddr, i_MEM_RegWrAddr, i_WB_RegWrAddr, ID_Rs, ID_Rt, i_BranchSel) is
            
            begin

                o_muxASel <= b"00";
                o_muxBSel <= b"00";
                o_muxReadData2Sel <= b"00";
                o_muxReadData2Sel <= b"00";

                if(i_MEM_RegWr = '1' and (i_MEM_RegWrAddr /= "00000") and i_MEM_RegWrAddr = EX_Rs) then
                    o_muxASel <= "10";
                elsif(i_WB_RegWr = '1'  and (i_WB_RegWrAddr /= "00000") and not(i_MEM_RegWr = '1' and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rs))  and i_WB_RegWrAddr = EX_Rs) then
                    o_muxASel <= "01";
                end if;

                if(i_MEM_RegWr = '1'  and (i_MEM_RegWrAddr /= "00000") and i_MEM_RegWrAddr = EX_Rt) then
                    o_muxBSel <= "10";
                elsif(i_WB_RegWr = '1'  and  (i_WB_RegWrAddr /= "00000") and not(i_MEM_RegWr ='1' and (i_MEM_RegWrAddr /= "00000") and (i_MEM_RegWrAddr = EX_Rt))  and i_WB_RegWrAddr = EX_Rt) then
                    o_muxBSel <= "01";
                end if;

                if(i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rt)) then
                    o_muxReadData2Sel <= "10";
                elsif(i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rt)) then
                    o_muxReadData2Sel <= "01";
                end if;

                if(i_BranchSel = '1' and i_EX_RegWrAddr = ID_Rs) then
                    o_muxReadData1Sel <= "10";
                elsif(i_BranchSel = '1' and i_MEM_RegWrAddr = ID_Rs) then
                    o_muxReadData1Sel <= "01";
                end if;

        end process;
        
end structural;