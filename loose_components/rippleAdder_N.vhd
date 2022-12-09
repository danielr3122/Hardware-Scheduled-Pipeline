-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- rippleAdder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-Bit Ripple
-- Carry adder utilizing the 1Bit Full Adder.
--
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rippleAdder_N is
    generic(N : integer := 32);
    port(i_Cin      : in std_logic;
         i_opA      : in std_logic_vector(N-1 downto 0);
         i_opB      : in std_logic_vector(N-1 downto 0);
         o_Sum      : out std_logic_vector(N-1 downto 0);
         o_Cout30   : out std_logic;
         o_Cout31   : out std_logic);
end rippleAdder_N;

architecture structural of rippleAdder_N is

    component fullAdder is
        port(i_Cin      : in std_logic;
             i_opA      : in std_logic;
             i_opB      : in std_logic;
             o_Sum      : out std_logic;
             o_Cout     : out std_logic);
    end component;

    type carry_array is array (natural range <>) of std_logic;
    signal s_Carry      : carry_array (0 to 31);

    signal s_C30, s_C31 : std_logic;

begin

    fullAdder_0: fullAdder
        port MAP(i_Cin      => i_Cin,
                 i_opA      => i_opA(0),
                 i_opB      => i_opB(0),
                 o_Sum      => o_Sum(0),
                 o_Cout     => s_Carry(0));

    G_NBit_FULLADDER: for i in 1 to N-1 generate
        FULLADDI: fullAdder port map(
                    i_Cin       => s_Carry(i-1),
                    i_opA       => i_opA(i),
                    i_opB       => i_opB(i),
                    o_Sum       => o_Sum(i),
                    o_Cout      => s_Carry(i));
    end generate G_NBit_FULLADDER;

    o_Cout30 <= s_Carry(30);
    o_Cout31 <= s_Carry(31);
    
end structural;
