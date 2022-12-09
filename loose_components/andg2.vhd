-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- andg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input AND 
-- gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/16/19 by H3::Changed name to avoid name conflict with Quartus 
--         primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity andg2 is

  port(i_a          : in std_logic;
       i_b          : in std_logic;
       o_f          : out std_logic);

end andg2;

architecture dataflow of andg2 is
begin

  o_f <= i_a and i_b;
  
end dataflow;
