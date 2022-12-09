-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux16t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a 16 to 1 mux.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux16t1_32 is
    generic(gCLK_HPER   : time := 10 ns);
end tb_mux16t1_32;

architecture dataflow of tb_mux16t1_32 is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component mux16t1_32 is
        generic(M   : integer := 4; N   : integer := 32);
        port(i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             i_d2       : in std_logic_vector(N-1 downto 0);
             i_d3       : in std_logic_vector(N-1 downto 0);
             i_d4       : in std_logic_vector(N-1 downto 0);
             i_d5       : in std_logic_vector(N-1 downto 0);
             i_d6       : in std_logic_vector(N-1 downto 0);
             i_d7       : in std_logic_vector(N-1 downto 0);
             i_d8       : in std_logic_vector(N-1 downto 0);
             i_d9       : in std_logic_vector(N-1 downto 0);
             i_d10      : in std_logic_vector(N-1 downto 0);
             i_d11      : in std_logic_vector(N-1 downto 0);
             i_d12      : in std_logic_vector(N-1 downto 0);
             i_d13      : in std_logic_vector(N-1 downto 0);
             i_d14      : in std_logic_vector(N-1 downto 0);
             i_d15      : in std_logic_vector(N-1 downto 0);
             i_s        : in std_logic_vector(M-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component;

    signal s_s      : std_logic_vector(3 downto 0)  := b"0000";
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
    signal s_o      : std_logic_vector(31 downto 0);

    begin
        DUT0: mux16t1_32
        port map(
            i_s   => s_s,
            i_d0  => s_d0,
            i_d1  => s_d1, 
            i_d2  => s_d2, 
            i_d3  => s_d3,
            i_d4  => s_d4,
            i_d5  => s_d5, 
            i_d6  => s_d6, 
            i_d7  => s_d7,
            i_d8  => s_d8,
            i_d9  => s_d9, 
            i_d10 => s_d10, 
            i_d11 => s_d11,
            i_d12 => s_d12,
            i_d13 => s_d13, 
            i_d14 => s_d14, 
            i_d15 => s_d15,
            o_o   => s_o);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 1:
            s_s   <= b"0000";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0001"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_s   <= b"0001";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0002"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_s   <= b"0010";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0003"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_s   <= b"0011";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0004"

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_s   <= b"0100";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0005"

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_s   <= b"0101";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0006"

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_s   <= b"0110";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0007"

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_s   <= b"0111";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0008"

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_s   <= b"1000";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0009"

            wait for gCLK_HPER*2;

            -- Test case 10:
            s_s   <= b"1001";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000A"

            wait for gCLK_HPER*2;

            -- Test case 11:
            s_s   <= b"1010";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000B"

            wait for gCLK_HPER*2;

            -- Test case 12:
            s_s   <= b"1011";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000C"

            wait for gCLK_HPER*2;

            -- Test case 13:
            s_s   <= b"1100";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000D"

            wait for gCLK_HPER*2;

            -- Test case 14:
            s_s   <= b"1101";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000E"

            wait for gCLK_HPER*2;

            -- Test case 15:
            s_s   <= b"1110";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_000F"

            wait for gCLK_HPER*2;

            -- Test case 16:
            s_s   <= b"1111";
            s_d0  <= x"0000_0001";
            s_d1  <= x"0000_0002";
            s_d2  <= x"0000_0003";
            s_d3  <= x"0000_0004";
            s_d4  <= x"0000_0005";
            s_d5  <= x"0000_0006";
            s_d6  <= x"0000_0007";
            s_d7  <= x"0000_0008";
            s_d8  <= x"0000_0009";
            s_d9  <= x"0000_000A";
            s_d10 <= x"0000_000B";
            s_d11 <= x"0000_000C";
            s_d12 <= x"0000_000D";
            s_d13 <= x"0000_000E";
            s_d14 <= x"0000_000F";
            s_d15 <= x"0000_0010";
            -- Expected: s_o = x"0000_0010"

            wait for gCLK_HPER*2;
        end process;

end dataflow;