-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_comparator_5.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- comparator unit.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_comparator_5 is

    generic(gCLK_HPER   : time := 50 ns);

end tb_comparator_5;

architecture mixed of tb_comparator_5 is

    component comparator_5 is
        port(i_d0 : in std_logic_vector(4 downto 0);
             i_d1 : in std_logic_vector(4 downto 0);
             o_o  : out std_logic);
    end component;

    signal s_d0, s_d1 : std_logic_vector(4 downto 0) := b"00000";
    signal s_o : std_logic;
    
    begin
        DUT0: comparator_5
        port map(i_d0 => s_d0,
                 i_d1 => s_d1,
                 o_o  => s_o);

        TEST_CASES: process
            begin
                wait for gCLK_HPER/2;

        s_d0 <= b"00000";
        s_d1 <= b"00000";

        wait for gCLK_HPER/2;

        s_d0 <= b"00001";
        s_d1 <= b"00000";

        wait for gCLK_HPER/2;

        s_d0 <= b"10101";
        s_d1 <= b"01010";

        wait for gCLK_HPER/2;

    end process;

end mixed;