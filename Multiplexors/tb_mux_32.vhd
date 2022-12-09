-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a 32-bit mux.
--
--
-- NOTES:
-- 9/28/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_mux_32 is
    generic(gCLK_HPER   : time := 10 ns);
end tb_mux_32;

architecture dataflow of tb_mux_32 is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component mux_32 is
        generic(N   : integer := 5; M   : integer := 32);
        port(
            i_s     : in std_logic_vector(N-1 downto 0);    -- Selector input value
            i_d0    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d1    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d2    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d3    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d4    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d5    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d6    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d7    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d8    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d9    : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d10   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d11   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d12   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d13   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d14   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d15   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d16   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d17   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d18   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d19   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d20   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d21   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d22   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d23   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d24   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d25   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d26   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d27   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d28   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d29   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d30   : in std_logic_vector(M-1 downto 0);    -- Data input
            i_d31   : in std_logic_vector(M-1 downto 0);    -- Data input
            o_q     : out std_logic_vector(M-1 downto 0));  -- Data output
    end component;

    signal s_s      : std_logic_vector(4 downto 0)  := b"00000";
    signal s_d0     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d1     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d2     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d3     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d4     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d5     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d6     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d7     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d8     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d9     : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d10    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d11    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d12    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d13    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d14    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d15    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d16    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d17    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d18    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d19    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d20    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d21    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d22    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d23    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d24    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d25    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d26    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d27    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d28    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d29    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d30    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_d31    : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_q      : std_logic_vector(31 downto 0);

    begin
        DUT0: mux_32
        port map(
            i_s => s_s,
            i_d0 => s_d0,
            i_d1 => s_d1, 
            i_d2 => s_d2, 
            i_d3 => s_d3, 
            i_d4 => s_d4, 
            i_d5 => s_d5, 
            i_d6 => s_d6, 
            i_d7 => s_d7, 
            i_d8 => s_d8, 
            i_d9 => s_d9, 
            i_d10 => s_d10,
            i_d11 => s_d11,
            i_d12 => s_d12,
            i_d13 => s_d13,
            i_d14 => s_d14,
            i_d15 => s_d15,
            i_d16 => s_d16,
            i_d17 => s_d17,
            i_d18 => s_d18,
            i_d19 => s_d19,
            i_d20 => s_d20,
            i_d21 => s_d21,
            i_d22 => s_d22,
            i_d23 => s_d23,
            i_d24 => s_d24,
            i_d25 => s_d25,
            i_d26 => s_d26,
            i_d27 => s_d27,
            i_d28 => s_d28,
            i_d29 => s_d29,
            i_d30 => s_d30,
            i_d31 => s_d31,
            o_q => s_q);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 0:
            s_s <= b"00000";
            s_d0 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_s <= b"00001";
            s_d1 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_s <= b"00010";
            s_d2 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_s <= b"00011";
            s_d3 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_s <= b"00100";
            s_d4 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_s <= b"00101";
            s_d5 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_s <= b"00110";
            s_d6 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_s <= b"00111";
            s_d7 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_s <= b"01000";
            s_d8 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_s <= b"01001";
            s_d9 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 10:
            s_s <= b"01010";
            s_d10 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 11:
            s_s <= b"01011";
            s_d11 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 12:
            s_s <= b"01100";
            s_d12 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 13:
            s_s <= b"01101";
            s_d13 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 14:
            s_s <= b"01110";
            s_d14 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 15:
            s_s <= b"01111";
            s_d15 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 16:
            s_s <= b"10000";
            s_d16 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 17:
            s_s <= b"10001";
            s_d17 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 18:
            s_s <= b"10010";
            s_d18 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 19:
            s_s <= b"10011";
            s_d19 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 20:
            s_s <= b"10100";
            s_d20 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 21:
            s_s <= b"10101";
            s_d21 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 22:
            s_s <= b"10110";
            s_d22 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 23:
            s_s <= b"10111";
            s_d23 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 24:
            s_s <= b"11000";
            s_d24 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 25:
            s_s <= b"11001";
            s_d25 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 26:
            s_s <= b"11010";
            s_d26 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 27:
            s_s <= b"11011";
            s_d27 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 28:
            s_s <= b"11100";
            s_d28 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 29:
            s_s <= b"11101";
            s_d29 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;

            -- Test case 30:
            s_s <= b"11110";
            s_d30 <= x"000c_0005";
            -- Expected: s_q = x"000c_0005"

            wait for gCLK_HPER*2;

            -- Test case 31:
            s_s <= b"11111";
            s_d31 <= x"7000_000a";
            -- Expected: s_q = x"7000_000a"

            wait for gCLK_HPER*2;
        end process;

end dataflow;