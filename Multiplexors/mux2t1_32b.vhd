-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- mux2t1_32b.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 bit 2:1
--              multiplexor using dataflow.
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_32b is 
generic(N : integer := 32);
    port(i_s        : in std_logic;
         i_d0       : in std_logic_vector(N-1 downto 0);
         i_d1       : in std_logic_vector(N-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));

end mux2t1_32b;

architecture dataflow of mux2t1_32b is
begin

    with i_s select
        o_o <=  i_d0  when '0',     -- $0
                i_d1  when '1',     -- $1
                i_d0 when others;   -- Error
    
end dataflow;