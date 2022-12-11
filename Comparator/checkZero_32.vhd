-------------------------------------------------------------------------
-- Brayton Rude
-------------------------------------------------------------------------
-- checkZero_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of .
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity checkZero_32 is
    port(i_d : in std_logic_vector(31 downto 0);
         o_f  : out std_logic);
end checkZero_32;

architecture mixed of checkZero_32 is

begin

    with i_d select
        o_f <= '1' when b"00000000000000000000000000000000",
               '0' when others;

end mixed;