-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- onesComp_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit Ones
--              Complementor.
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp_N is
    generic(N : integer := 32);
    port(i_D        : in std_logic_vector(N-1 downto 0);
         o_O        : out std_logic_vector(N-1 downto 0));
end onesComp_N;

architecture structural of onesComp_N is

    component invg is
        port(i_A    : in std_logic;
             o_F    : out std_logic);
    end component;

begin

    G_NBit_NOTG: for i in 0 to N-1 generate
        NOTI: invg port map (
                i_A     => i_D(i),
                o_F     => o_O(i));
    end generate G_NBit_NOTG;

end structural;