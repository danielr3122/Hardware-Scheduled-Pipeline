-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- fullAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1Bit Full Adder.
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is

    port(i_Cin      : in std_logic;
         i_opA      : in std_logic;
         i_opB      : in std_logic;
         o_Sum      : out std_logic;
         o_Cout     : out std_logic);

end fullAdder;

architecture structural of fullAdder is

    component xorg2 is
        port(i_A        : in std_logic;
             i_B        : in std_logic;
             o_F        : out std_logic);
    end component;
    
    component org2 is
        port(i_A        : in std_logic;
             i_B        : in std_logic;
             o_F        : out std_logic);
    end component;
    
    component andg2 is
        port(i_A        : in std_logic;
             i_B        : in std_logic;
             o_F        : out std_logic);
    end component;
    
    signal s_oXOR1  : std_logic;
    signal s_oAND1  : std_logic;
    signal s_oAND2  : std_logic;

begin

    xor_gate1: xorg2
        port MAP(i_A    => i_opA,
                 i_B    => i_opB,
                 o_F    => s_oXOR1);
    
    xor_gate2: xorg2
        port MAP(i_A    => s_oXOR1,
                 i_B    => i_Cin,
                 o_F    => o_Sum);

    and_gate1: andg2
        port MAP(i_A    => s_oXOR1,
                 i_B    => i_Cin,
                 o_F    => s_oAND1);
    
    and_gate2: andg2
        port MAP(i_A    => i_opA,
                 i_B    => i_opB,
                 o_F    => s_oAND2);
    
    or_gate1: org2
        port MAP(i_A    => s_oAND1,
                 i_B    => s_oAND2,
                 o_F    => o_Cout);

end structural;
