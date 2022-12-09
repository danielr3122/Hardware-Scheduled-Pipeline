-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using structural VHDL.
--
--
-- NOTES:
-- 9/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
    port(i_d0       : in std_logic;
         i_d1       : in std_logic;
         i_s        : in std_logic;
         o_o        : out std_logic);
end mux2t1;

architecture structural of mux2t1 is
    
    component invg is
        port(i_a          : in std_logic;
             o_f          : out std_logic);
    end component;

    component andg2 is
      port(i_a          : in std_logic;
           i_b          : in std_logic;
           o_f          : out std_logic);
    end component;

    component org2 is
      port(i_a          : in std_logic;
           i_b          : in std_logic;
           o_f          : out std_logic);
    end component;

-- Intermediate Signals
signal s_oNot                 : std_logic;
signal s_oAnd1, s_oAnd2       : std_logic;

begin
    
    g_Not: invg
    port MAP(i_a        => i_s,
             o_f        => s_oNot);

    g_And1: andg2
    port MAP(i_a        => i_d0,
             i_b        => s_oNot,
             o_f        => s_oAnd1);

    g_And2: andg2
    port MAP(i_a        => i_d1,
             i_b        => i_s,
             o_f        => s_oAnd2);

    g_Or: org2
    port MAP(i_a        => s_oAnd1,
             i_b        => s_oAnd2,
             o_f        => o_o);

            
end structural;