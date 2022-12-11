-------------------------------------------------------------------------
-- Daniel Rosenhamer
-------------------------------------------------------------------------
-- comparator_5.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of our compatator 
--              unit.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity comparator_5 is
    port(i_d0 : in std_logic_vector(4 downto 0);
         i_d1 : in std_logic_vector(4 downto 0);
         o_o  : out std_logic);
end comparator_5;

architecture mixed of comparator_5 is

    signal a, b, c, d, e : std_logic;

    begin
        a <= i_d0(0) xor i_d1(0);
        b <= i_d0(1) xor i_d1(1);
        c <= i_d0(2) xor i_d1(2);
        d <= i_d0(3) xor i_d1(3);
        e <= i_d0(4) xor i_d1(4);

        o_o <= not(a or b or c or d or e);

end mixed;