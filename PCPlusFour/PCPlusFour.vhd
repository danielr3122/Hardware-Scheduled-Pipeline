-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- PCPlusFour.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of PC + 4.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;                                           
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity PCPlusFour is
    generic(N   : integer := 32);
    port(i_d0       : in std_logic_vector(N-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));
end PCPlusFour;

architecture behavioral of PCPlusFour is

    begin

        o_o <= i_d0 + X"4";
            
end behavioral;