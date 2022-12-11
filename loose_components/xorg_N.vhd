-------------------------------------------------------------------------
-- Brayton Rude
-------------------------------------------------------------------------
-- xorg_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of N-32 XOR.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity xorg_N is
    generic(N : integer := 32);
    port(i_A : in std_logic_vector(N-1 downto 0);
         i_B : in std_logic_vector(N-1 downto 0);
         o_F  : out std_logic_vector(N-1 downto 0));
end xorg_N;

architecture mixed of xorg_N is   

    component xorg2 is
        port(i_a          : in std_logic;
             i_b          : in std_logic;
             o_f          : out std_logic);
    end component;

begin

    G_NBit_XORG2: for i in 0 to N-1 generate
        XORI: xorg2 port map(
                        i_a     => i_A(i),
                        i_b     => i_B(i),
                        o_f     => o_F(i));
    end generate G_NBit_XORG2;

end mixed;