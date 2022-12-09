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

    signal a, b, c, d, e, f, g, h, i, j, k, l, m, v, w : std_logic;

    signal n, o, p, q, r, s, t, u : std_logic_vector(1 downto 0);

    begin

        ID_Rs <= i_ID_Inst(25 downto 21);
        ID_Rt <= i_ID_Inst(20 downto 16);
        EX_Rs <= i_EX_Inst(25 downto 21);
        EX_Rt <= i_EX_Inst(20 downto 16);

        process(ID_Rs, ID_Rt, EX_Rs, EX_Rt, i_EX_RegWrAddr, i_MEM_RegWrAddr, i_WB_RegWrAddr, i_BranchSel) is
            
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

                if(i_BranchSel = '1' and i_EX_RegWrAddr = ID_Rs) then
                    o_muxReadData1Sel <= "10";
                elsif(i_BranchSel = '1' and i_MEM_RegWrAddr = ID_Rs) then
                    o_muxReadData1Sel <= "01";
                end if;

                if(i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rt)) then
                    o_muxReadData2Sel <= "10";
                elsif(i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rt)) then
                    o_muxReadData2Sel <= "01";
                end if;

        end process;

        -- a <= '1' when (i_WB_RegWr = '1');
        -- b <= '1' when i_WB_RegWrAddr /= b"00000";
        -- c <= '1' when i_MEM_RegWr = '1';
        -- d <= '1' when i_MEM_RegWrAddr /= b"00000";
        -- e <= '1' when i_MEM_RegWrAddr = EX_Rs;
        -- f <= '1' when i_WB_RegWrAddr = EX_Rs;

        -- v <= ((a and b) and (not (c and d and e)) and f);

        -- with v select
        --     p <= b"01" when '1',
        --          b"00" when others;

        -- w <= (c and d and e);

        -- with w select
        --     q <= b"10" when '1',
        --          b"00" when others;

        -- o_muxASel <= p or q;

        -- o_muxASel <= b"01" when ((a and b) and not (c and d and e) and f) else
        --              b"10" when (c and d and e) else
        --              b"00";

        -- o_muxASel <= b"01" when (i_WB_RegWr = '1' and 
        --                         (i_WB_RegWrAddr /= b"00000")) and
        --                         not(i_MEM_RegWr = '1' and
        --                         (i_MEM_RegWrAddr /= b"00000") and
        --                         (i_MEM_RegWrAddr = EX_Rs)) and
        --                         (i_WB_RegWrAddr = EX_Rs) else

        --              b"10" when ((i_MEM_RegWr = '1') and 
        --                         (i_MEM_RegWrAddr /= b"00000") and 
        --                         (i_MEM_RegWrAddr = EX_Rs)) else
                    
        --              b"00";

        -- g <= '1' when i_MEM_RegWrAddr = EX_Rt;
        -- h <= '1' when i_WB_RegWrAddr = EX_Rt;

        -- o_muxBSel <= b"01" when ((a and b) and not (c and d and g) and h) else
        --              b"10" when (c and d and g) else
        --              b"00";

        -- with ((a and b) and (not (c and d and g)) and h) select
        --     n <= b"01" when '1',
        --          b"00" when others;

        -- with (c and d and g) select
        --     o <= b"10" when '1',
        --          b"00" when others;

        -- o_muxBSel <= n or o;

        -- o_muxBSel <= b"01" when (i_WB_RegWr = '1' and 
        --                         (i_WB_RegWrAddr /= b"00000")) and
        --                         not(i_MEM_RegWr = '1' and
        --                         (i_MEM_RegWrAddr /= b"00000") and
        --                         (i_MEM_RegWrAddr = EX_Rt)) and
        --                         (i_WB_RegWrAddr = EX_Rt) else

        --              b"10" when ((i_MEM_RegWr = '1') and 
        --                         (i_MEM_RegWrAddr /= b"00000") and 
        --                         (i_MEM_RegWrAddr = EX_Rt)) else

        --              b"00";

        -- i <= '1' when i_BranchSel = '1';
        -- j <= '1' when i_MEM_RegWrAddr = ID_Rs;
        -- k <= '1' when i_EX_RegWrAddr = ID_Rs;
        -- l <= '1' when i_MEM_RegWrAddr = ID_Rt;
        -- m <= '1' when i_EX_RegWrAddr = ID_Rt;

        -- with (i and j) select
        --     r <= b"01" when '1',
        --          b"00" when others;

        -- with (i and k) select
        --     s <= b"10" when '1',
        --          b"00" when others;

        -- o_muxReadData1Sel <= r or s;

        -- with (i and l) select
        --     t <= b"01" when '1',
        --          b"00" when others;

        -- with (i and m) select
        --     u <= b"10" when '1',
        --          b"00" when others;

        -- o_muxReadData2Sel <= t or u;

        -- o_muxReadData1Sel <= b"01" when (i and j) else
        --                      b"10" when (i and k) else
        --                      b"00";

        -- o_muxReadData2Sel <= b"01" when (i and l) else
        --                      b"10" when (i and m) else
        --                      b"00";

        -- o_muxReadData1Sel <= b"01" when (i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rs)) else
        --                      b"10" when (i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rs)) else
        --                      b"00";

        -- o_muxReadData2Sel <= b"01" when (i_BranchSel = '1' and (i_MEM_RegWrAddr = ID_Rt)) else
        --                      b"10" when (i_BranchSel = '1' and (i_EX_RegWrAddr = ID_Rt)) else
        --                      b"00";
        
end structural;