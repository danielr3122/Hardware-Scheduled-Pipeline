-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux4t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 4:1
-- mux using dataflow VHDL.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;                                           
use IEEE.std_logic_1164.all;

entity mux4t1_32 is
    generic(N   : integer := 32; M  : integer := 2);
    port(i_d0       : in std_logic_vector(N-1 downto 0);
         i_d1       : in std_logic_vector(N-1 downto 0);
         i_d2       : in std_logic_vector(N-1 downto 0);
         i_d3       : in std_logic_vector(N-1 downto 0);
         i_s        : in std_logic_vector(M-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));
end mux4t1_32;

architecture dataflow of mux4t1_32 is

    begin

        with i_s select
            o_o <= i_d0 when b"00",
                   i_d1 when b"01",
                   i_d2 when b"10",
                   i_d3 when b"11",
                   x"0000_0000" when others;
            
end dataflow;