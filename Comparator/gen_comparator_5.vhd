-------------------------------------------------------------------------
-- Brayton Rude
-------------------------------------------------------------------------
-- gen_comparator_5.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of our compatator 
--              unit.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity gen_comparator_5 is
    port(i_d0 : in std_logic_vector(4 downto 0);
         i_d1 : in std_logic_vector(4 downto 0);
         o_o  : out std_logic);
end gen_comparator_5;

architecture mixed of comparator_5 is   

    component xorg_N
    generic(N : integer := 5);
    port(i_A : in std_logic_vector(N-1 downto 0);
         i_B : in std_logic_vector(N-1 downto 0);
         o_F  : out std_logic_vector(N-1 downto 0));
    end component;

    component checkZero_5 is
        port(i_d : in std_logic_vector(4 downto 0);
             o_f  : out std_logic);
    end component;    

    signal ResX : std_logic_vector(4 downto 0);

    begin

        g_XORG: xorg_N
            port map(i_A   => i_d0,
                     i_B   => i_d1,
                     o_F   => ResX);

        g_checkZ: checkZero_32
            port map(i_d   => ResX,
                     o_f   => o_o);

end mixed;