-------------------------------------------------------------------------
-- Brayton Rude
-------------------------------------------------------------------------
-- tb_gen_comparator_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- comparator unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_gen_comparator_32 is

    generic(gCLK_HPER   : time := 50 ns);

end tb_gen_comparator_32;

architecture mixed of tb_gen_comparator_32 is
  
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component gen_comparator_32 is
        port(i_d0 : in std_logic_vector(31 downto 0);
             i_d1 : in std_logic_vector(31 downto 0);
             o_o  : out std_logic);
    end component;

    signal s_d0, s_d1 : std_logic_vector(31 downto 0) := x"00000000";
    signal s_o : std_logic;
    
    begin
        DUT0: gen_comparator_32
        port map(i_d0 => s_d0,
                 i_d1 => s_d1,
                 o_o  => s_o);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            s_d0 <= x"00000000";
            s_d1 <= x"00000000";
            wait for gCLK_HPER/2;

            s_d0 <= x"00000001";
            s_d1 <= x"00000000";
            wait for gCLK_HPER/2;

            s_d0 <= x"1234BEEF";
            s_d1 <= x"1234BEEF";
            wait for gCLK_HPER/2;

            s_d0 <= x"00000000";
            s_d1 <= x"0000FFFF";
            wait for gCLK_HPER/2;

    end process;

end mixed;