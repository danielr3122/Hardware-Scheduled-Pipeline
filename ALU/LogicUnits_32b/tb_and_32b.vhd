-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_and_32b.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 32-bit bitwise 
--              AND logic unit.
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_and_32b is
        generic(gCLK_HPER   : time := 10 ns);
end tb_and_32b;

architecture structural of tb_and_32b is

    component and_32b is 
    port(i_A        : in std_logic_vector(31 downto 0);
         i_B        : in std_logic_vector(31 downto 0);
         o_O        : out std_logic_vector(31 downto 0));
    end component;

    signal s_A, s_B         : std_logic_vector(31 downto 0) := x"00000000";
    signal s_O              : std_logic_vector(31 downto 0);

begin

    DUT0: and_32b
    port map(i_A    => s_A,
             i_B    => s_B,
             o_O    => s_O);
    
    P_TEST_CASES: process
    begin
        wait for gCLK_HPER/2;

        --Test Case 1
        s_A     <= x"0000_0000";
        s_B     <= x"0000_0000";
        wait for gCLK_HPER/2;
        --Expected => s_O = x"0000_0000"

        --Test Case 2
        s_A     <= x"FFFF_0000";
        s_B     <= x"0000_FFFF";
        wait for gCLK_HPER/2;
        --Expected => s_O = x"0000_0000"

        --Test Case 3
        s_A     <= x"FFFF_FFFF";
        s_B     <= x"FFFF_FFFF";
        wait for gCLK_HPER/2;
        --Expected => s_O = x"FFFF_FFFF"

    end process;

end structural;