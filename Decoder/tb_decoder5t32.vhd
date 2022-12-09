-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_decoder5t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 5:32bit Decoder
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_decoder5t32 is
        generic(gCLK_HPER   : time := 10 ns);
end tb_decoder5t32;

architecture structural of tb_decoder5t32 is

    component decoder5t32 is
        port(i_A    : in std_logic_vector(4 downto 0);
             o_F    : out std_logic_vector(31 downto 0));
    end component;

    signal s_A      : std_logic_vector(4 downto 0) := "00000";
    signal s_F      : std_logic_vector(31 downto 0);

begin

    DUT0: decoder5t32
    port map(i_A    => s_A,
             o_F    => s_F);

    P_TEST_CASES: process
    begin   
        wait for gCLK_HPER/2;

        s_A     <= "00000";
        wait for gCLK_HPER/2;
        s_A     <= "00001";
        wait for gCLK_HPER/2;
        s_A     <= "00010";
        wait for gCLK_HPER/2;
        s_A     <= "00011";
        wait for gCLK_HPER/2;
        s_A     <= "00100";
        wait for gCLK_HPER/2;
        s_A     <= "00101";
        wait for gCLK_HPER/2;
        s_A     <= "00110";
        wait for gCLK_HPER/2;
        s_A     <= "00111";
        wait for gCLK_HPER/2;
        s_A     <= "01000";
        wait for gCLK_HPER/2;
        s_A     <= "01001";
        wait for gCLK_HPER/2;
        s_A     <= "01010";
        wait for gCLK_HPER/2;
        s_A     <= "01011";
        wait for gCLK_HPER/2;
        s_A     <= "01100";
        wait for gCLK_HPER/2;
        s_A     <= "01101";
        wait for gCLK_HPER/2;
        s_A     <= "01110";
        wait for gCLK_HPER/2;
        s_A     <= "01111";
        wait for gCLK_HPER/2;
        s_A     <= "10000";
        wait for gCLK_HPER/2;
        s_A     <= "10001";
        wait for gCLK_HPER/2;
        s_A     <= "10010";
        wait for gCLK_HPER/2;
        s_A     <= "10011";
        wait for gCLK_HPER/2;
        s_A     <= "10100";
        wait for gCLK_HPER/2;
        s_A     <= "10101";
        wait for gCLK_HPER/2;
        s_A     <= "10110";
        wait for gCLK_HPER/2;
        s_A     <= "10111";
        wait for gCLK_HPER/2;
        s_A     <= "11000";
        wait for gCLK_HPER/2;
        s_A     <= "11001";
        wait for gCLK_HPER/2;
        s_A     <= "11010";
        wait for gCLK_HPER/2;
        s_A     <= "11011";
        wait for gCLK_HPER/2;
        s_A     <= "11100";
        wait for gCLK_HPER/2;
        s_A     <= "11101";
        wait for gCLK_HPER/2;
        s_A     <= "11110";
        wait for gCLK_HPER/2;
        s_A     <= "11111";
        wait for gCLK_HPER/2;
        --run 170

    end process;

end structural;