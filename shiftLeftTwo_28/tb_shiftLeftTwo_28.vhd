-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_shiftLeftTwo_28.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for PC + 4.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shiftLeftTwo_28 is
    generic(gCLK_HPER   : time := 10 ns);
end tb_shiftLeftTwo_28;

architecture dataflow of tb_shiftLeftTwo_28 is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component shiftLeftTwo_28 is
        generic(N   : integer := 26; M   : integer := 28);
        port(i_d0       : in std_logic_vector(N-1 downto 0);
             o_o        : out std_logic_vector(M-1 downto 0));
    end component;

    signal s_d0     : std_logic_vector(25 downto 0) := b"00_0000_0000_0000_0000_0000_0000";
    signal s_o      : std_logic_vector(27 downto 0);

    begin
        DUT0: shiftLeftTwo_28
        port map(
            i_d0 => s_d0,
            o_o => s_o);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 0:
            s_d0 <= b"00_0000_0000_0000_0000_0000_0001";
            -- Expected: s_o = b"00_0000_0000_0000_0000_0000_0100"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_d0 <= b"00_1111_1111_1111_1111_1111_1111";
            -- Expected: s_o = b"11_1111_1111_1111_1111_1111_1100"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_d0 <= b"11_1111_1111_1111_1111_1111_1111";
            -- Expected: s_o = b"11_1111_1111_1111_1111_1111_1100"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_d0 <= b"10_1010_1010_1010_1010_1010_1010";
            -- Expected: s_o = b"10_1010_1010_1010_1010_1010_1000"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_d0 <= b"00_0000_0000_0000_0000_0000_0000";
            -- Expected: s_o = b"00_0000_0000_0000_0000_0000_0000"

            wait for gCLK_HPER*2;
        end process;

end dataflow;