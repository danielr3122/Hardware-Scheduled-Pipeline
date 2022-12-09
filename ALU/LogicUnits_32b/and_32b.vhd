-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- and_32b.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 32-bit bitwise
--              AND logic unit.
-- 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity and_32b is
    port(i_A        : in std_logic_vector(31 downto 0);
         i_B        : in std_logic_vector(31 downto 0);
         o_O        : out std_logic_vector(31 downto 0));
end and_32b;

architecture structural of and_32b is

    component andg2 is 
        port(i_a    : in std_logic;
             i_b    : in std_logic;
             o_f    : out std_logic);
    end component;

begin
    
    G_32Bit_ANDG2: for i in 0 to 31 generate
        ANDI: andg2 port map(
                    i_a     => i_A(i),
                    i_b     => i_B(i),
                    o_f     => o_O(i));
    end generate G_32Bit_ANDG2;

end structural;