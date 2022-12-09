-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux16t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 16:1
-- mux using dataflow VHDL.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;                                           
use IEEE.std_logic_1164.all;

entity mux16t1_32 is
    generic(M   : integer := 4; N   : integer := 32);
    port(i_d0       : in std_logic_vector(N-1 downto 0);
         i_d1       : in std_logic_vector(N-1 downto 0);
         i_d2       : in std_logic_vector(N-1 downto 0);
         i_d3       : in std_logic_vector(N-1 downto 0);
         i_d4       : in std_logic_vector(N-1 downto 0);
         i_d5       : in std_logic_vector(N-1 downto 0);
         i_d6       : in std_logic_vector(N-1 downto 0);
         i_d7       : in std_logic_vector(N-1 downto 0);
         i_d8       : in std_logic_vector(N-1 downto 0);
         i_d9       : in std_logic_vector(N-1 downto 0);
         i_d10      : in std_logic_vector(N-1 downto 0);
         i_d11      : in std_logic_vector(N-1 downto 0);
         i_d12      : in std_logic_vector(N-1 downto 0);
         i_d13      : in std_logic_vector(N-1 downto 0);
         i_d14      : in std_logic_vector(N-1 downto 0);
         i_d15      : in std_logic_vector(N-1 downto 0);
         i_s        : in std_logic_vector(M-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));
end mux16t1_32;

architecture dataflow of mux16t1_32 is

    begin

        with i_s select
            o_o <= i_d0 when b"0000",
                   i_d1 when b"0001",
                   i_d2 when b"0010",
                   i_d3 when b"0011",
                   i_d4 when b"0100",
                   i_d5 when b"0101",
                   i_d6 when b"0110",
                   i_d7 when b"0111",
                   i_d8 when b"1000",
                   i_d9 when b"1001",
                   i_d10 when b"1010",
                   i_d11 when b"1011",
                   i_d12 when b"1100",
                   i_d13 when b"1101",
                   i_d14 when b"1110",
                   i_d15 when b"1111",
                   x"0000_0000" when others;
            
end dataflow;