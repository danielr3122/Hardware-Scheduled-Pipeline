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

    begin
        o_o <= i_d0 = i_d1;

end mixed;