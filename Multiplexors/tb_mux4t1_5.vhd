-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux4t1_5.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a 4 to 1 mux.
--
--
-- NOTES:
-- 11/25/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux4t1_5 is
    generic(gCLK_HPER   : time := 10 ns);
end tb_mux4t1_5;

architecture dataflow of tb_mux4t1_5 is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component mux4t1_5 is
        generic(N   : integer := 5; M  : integer := 2);
        port(i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             i_d2       : in std_logic_vector(N-1 downto 0);
             i_d3       : in std_logic_vector(N-1 downto 0);
             i_s        : in std_logic_vector(M-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component;

    signal s_s      : std_logic_vector(1 downto 0) := b"00";
    signal s_d0     : std_logic_vector(4 downto 0) := b"00000";
    signal s_d1     : std_logic_vector(4 downto 0) := b"00000";
    signal s_d2     : std_logic_vector(4 downto 0) := b"00000";
    signal s_d3     : std_logic_vector(4 downto 0) := b"00000";
    signal s_o      : std_logic_vector(4 downto 0);

    begin
        DUT0: mux4t1_5
        port map(
            i_s => s_s,
            i_d0 => s_d0,
            i_d1 => s_d1, 
            i_d2 => s_d2, 
            i_d3 => s_d3,
            o_o => s_o);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 0:
            s_s <= b"00";
            s_d0 <= b"00001";
            s_d1 <= b"00010";
            s_d2 <= b"00011";
            s_d3 <= b"00100";
            -- Expected: s_o = b"0001"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_s <= b"01";
            s_d0 <= b"00001";
            s_d1 <= b"00010";
            s_d2 <= b"00011";
            s_d3 <= b"00100";
            -- Expected: s_o = b"00010"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_s <= b"10";
            s_d0 <= b"00001";
            s_d1 <= b"00010";
            s_d2 <= b"00011";
            s_d3 <= b"00100";
            -- Expected: s_o = b"00011"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_s <= b"11";
            s_d0 <= b"00001";
            s_d1 <= b"00010";
            s_d2 <= b"00011";
            s_d3 <= b"00100";
            -- Expected: s_o = b"00100"

            wait for gCLK_HPER*2;
        end process;

end dataflow;