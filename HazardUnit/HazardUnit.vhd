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

entity HazardUnit is
    port(i_IF_Inst  : in std_logic_vector(31 downto 0);
         i_ID_Inst  : in std_logic_vector(31 downto 0);
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
end HazardUnit;

signal lw, sw : std_logic;
signal IF_rs, IF_rt : std_logic_vector(4 downto 0);

architecture structural of HazardUnit is

    begin

        lw <= '1' when (i_ID_Inst(31 downto 26) = "100011" or 
                        i_EX_Inst(31 downto 26) = "100011" or 
                        i_MEM_Inst(31 downto 26) = "100011" or 
                        i_WB_Inst(31 downto 26) = "100011");

        sw <= '1' when (i_ID_Inst(31 downto 26) = "101011" or 
                        i_EX_Inst(31 downto 26) = "101011" or 
                        i_MEM_Inst(31 downto 26) = "101011" or 
                        i_WB_Inst(31 downto 26) = "101011");

        IF_rs <= i_IF_Inst(25 downto 21);
        IF_rt <= i_IF_Inst(20 downto 16);

        o_PC_Stall <= '0' when (lw = '1' or 
                                sw = '1' or 
                                i_EX_jal = '1' or 
                                i_MEM_jal = '1' or
                                i_WB_jal = '1') else
                      '1';

        o_IF_ID_Stall  <= '1';
        o_ID_EX_Stall  <= '1';
        o_EX_MEM_Stall <= '1';
        o_MEM_WB_Stall <= '1';

        o_IF_Flush <= '1' when (lw = '1' or
                                sw = '1' or
                                i_JumpInstr = '1' or
                                i_BranchSel = '1' or
                                i_JumpReg = '1' or
                                i_EX_jal = '1' or
                                i_MEM_jal = '1' or
                                i_WB_jal = '1') else
                      '0';

        o_ID_EX_Flush  <= '0';
        o_EX_MEM_Flush <= '0';
        o_MEM_WB_Flush <= '0';
        
end structural;