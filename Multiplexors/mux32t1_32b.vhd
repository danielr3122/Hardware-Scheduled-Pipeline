-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- mux32t1_32b.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 bit 32:1
--              multiplexor using dataflow.
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux32t1_32b is 
generic(N : integer := 32);
    port(i_S        : in std_logic_vector(4 downto 0);
         i_D0       : in std_logic_vector(N-1 downto 0);
         i_D1       : in std_logic_vector(N-1 downto 0);
         i_D2       : in std_logic_vector(N-1 downto 0);
         i_D3       : in std_logic_vector(N-1 downto 0);
         i_D4       : in std_logic_vector(N-1 downto 0);
         i_D5       : in std_logic_vector(N-1 downto 0);
         i_D6       : in std_logic_vector(N-1 downto 0);
         i_D7       : in std_logic_vector(N-1 downto 0);
         i_D8       : in std_logic_vector(N-1 downto 0);
         i_D9       : in std_logic_vector(N-1 downto 0);
         i_D10      : in std_logic_vector(N-1 downto 0);
         i_D11      : in std_logic_vector(N-1 downto 0);
         i_D12      : in std_logic_vector(N-1 downto 0);
         i_D13      : in std_logic_vector(N-1 downto 0);
         i_D14      : in std_logic_vector(N-1 downto 0);
         i_D15      : in std_logic_vector(N-1 downto 0);
         i_D16      : in std_logic_vector(N-1 downto 0);
         i_D17      : in std_logic_vector(N-1 downto 0);
         i_D18      : in std_logic_vector(N-1 downto 0);
         i_D19      : in std_logic_vector(N-1 downto 0);
         i_D20      : in std_logic_vector(N-1 downto 0);
         i_D21      : in std_logic_vector(N-1 downto 0);
         i_D22      : in std_logic_vector(N-1 downto 0);
         i_D23      : in std_logic_vector(N-1 downto 0);
         i_D24      : in std_logic_vector(N-1 downto 0);
         i_D25      : in std_logic_vector(N-1 downto 0);
         i_D26      : in std_logic_vector(N-1 downto 0);
         i_D27      : in std_logic_vector(N-1 downto 0);
         i_D28      : in std_logic_vector(N-1 downto 0);
         i_D29      : in std_logic_vector(N-1 downto 0);
         i_D30      : in std_logic_vector(N-1 downto 0);
         i_D31      : in std_logic_vector(N-1 downto 0);
         o_O        : out std_logic_vector(N-1 downto 0));

end mux32t1_32b;

architecture dataflow of mux32t1_32b is
begin

    with i_S select
        o_O <=  i_D0  when "00000", -- $0
                i_D1  when "00001", -- $1
                i_D2  when "00010", -- $2
                i_D3  when "00011", -- $3
                i_D4  when "00100", -- $4
                i_D5  when "00101", -- $5
                i_D6  when "00110", -- $6
                i_D7  when "00111", -- $7
                i_D8  when "01000", -- $8
                i_D9  when "01001", -- $9
                i_D10 when "01010", -- $10
                i_D11 when "01011", -- $11
                i_D12 when "01100", -- $12
                i_D13 when "01101", -- $13
                i_D14 when "01110", -- $14
                i_D15 when "01111", -- $15
                i_D16 when "10000", -- $16
                i_D17 when "10001", -- $17
                i_D18 when "10010", -- $18
                i_D19 when "10011", -- $19
                i_D20 when "10100", -- $20
                i_D21 when "10101", -- $21
                i_D22 when "10110", -- $22
                i_D23 when "10111", -- $23
                i_D24 when "11000", -- $24
                i_D25 when "11001", -- $25
                i_D26 when "11010", -- $26
                i_D27 when "11011", -- $27
                i_D28 when "11100", -- $28
                i_D29 when "11101", -- $29
                i_D30 when "11110", -- $30
                i_D31 when "11111", -- $31
                i_D0 when others;   -- Error
    
end dataflow;