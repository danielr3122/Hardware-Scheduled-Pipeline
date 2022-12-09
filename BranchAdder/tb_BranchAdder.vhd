-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_BranchAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for our BranchAdder.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_BranchAdder is
    generic(gCLK_HPER   : time := 10 ns);
end tb_BranchAdder;

architecture dataflow of tb_BranchAdder is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component BranchAdder is
        generic(N   : integer := 32);
        port(i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component;

    signal s_d0     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d1     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_o      : std_logic_vector(31 downto 0);

    begin
        DUT0: BranchAdder
        port map(
            i_d0 => s_d0,
            i_d1 => s_d1,
            o_o => s_o);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 0:
            s_d0 <= x"0000_0001";
            s_d1 <= x"0000_0002";
            -- Expected: s_o = x"0000_0003"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_d0 <= x"FFFF_FFFF";
            s_d1 <= x"0000_0000";
            -- Expected: s_o = x"FFFF_FFFF"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_d0 <= x"F0F0_F0F0";
            s_d1 <= x"0F0F_0F0F";
            -- Expected: s_o = x"FFFF_FFFF"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_d0 <= x"FFFF_FFFF";
            s_d1 <= x"0000_0001";
            -- Expected: s_o = x"0000_0000"

            wait for gCLK_HPER*2;
        end process;

end dataflow;