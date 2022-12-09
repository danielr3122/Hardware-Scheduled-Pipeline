-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- shiftLeftTwo_32.vhd
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
use IEEE.numeric_std.all;

entity shiftLeftTwo_32 is
    generic(N   : integer := 32);
    port(i_d0       : in std_logic_vector(N-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));
end shiftLeftTwo_32;

architecture behavioral of shiftLeftTwo_32 is

    begin

        o_o <= std_logic_vector(shift_left(unsigned(i_d0), 2));
            
end behavioral;