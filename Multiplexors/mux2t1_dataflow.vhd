-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_dataflow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using dataflow VHDL.
--
--
-- NOTES:
-- 9/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_dataflow is
    port(i_d0       : in std_logic;
         i_d1       : in std_logic;
         i_s        : in std_logic;
         o_o        : out std_logic);
end mux2t1_dataflow;

architecture dataflow of mux2t1_dataflow is

begin

    o_o <= i_d0 when (i_s = '0') else
           i_d1;
            
end dataflow;