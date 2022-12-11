-------------------------------------------------------------------------
-- Brayton Rude
-------------------------------------------------------------------------
-- checkZero_5.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of .
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity checkZero_5 is
    port(i_d : in std_logic_vector(4 downto 0);
         o_f  : out std_logic);
end checkZero_5;

architecture mixed of checkZero_5 is

begin

    with i_d select
        o_f <= '1' when b"00000",
               '0' when others;

end mixed;
    
