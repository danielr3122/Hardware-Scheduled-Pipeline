-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- add_sub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-Bit Adder-
--              Subtractor.
--
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity add_sub_N is 
    generic(N : integer := 32);
    port(i_A        : in std_logic_vector(N-1 downto 0);
         i_B        : in std_logic_vector(N-1 downto 0);
         nAdd_Sub   : in std_logic;
         o_SumDiff  : out std_logic_vector(N-1 downto 0);
         o_Overflow : out std_logic);
end add_sub_N;

architecture structural of add_sub_N is

    component onesComp_N is
        generic(N : integer := 32);
        port(i_D        : in std_logic_vector(N-1 downto 0);
             o_O        : out std_logic_vector(N-1 downto 0));
    end component;

    component mux2t1_32b is 
        generic(N : integer := 32);
        port(i_s        : in std_logic;
             i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component;

    component rippleAdder_N is
        generic(N : integer := 32);
        port(i_Cin      : in std_logic;
             i_opA      : in std_logic_vector(N-1 downto 0);
             i_opB      : in std_logic_vector(N-1 downto 0);
             o_Sum      : out std_logic_vector(N-1 downto 0);
             o_Cout30   : out std_logic;
             o_Cout31   : out std_logic);
    end component;

    component xorg2 is
        port(i_a        : in std_logic;
        i_b             : in std_logic;
        o_f             : out std_logic);
    end component;

    signal s_invB, s_mB     : std_logic_vector(31 downto 0);
    signal s_C30toXOR, s_C31toXOR   : std_logic;

begin

    g_onesCompB: onesComp_N
        port MAP(i_D        => i_B,
                 o_O        => s_invB);

    g_muxBinvB: mux2t1_32b
        port MAP(i_s        => nAdd_Sub,
                 i_d0       => i_B,
                 i_d1       => s_invB,
                 o_o        => s_mB);
    
    g_rippleAdder: rippleAdder_N
        port MAP(i_Cin      => nAdd_Sub,
                 i_opA      => i_A,
                 i_opB      => s_mB,
                 o_Sum      => o_SumDiff,
                 o_Cout30   => s_C30toXOR,
                 o_Cout31   => s_C31toXOR);

    g_OFxor: xorg2
        port MAP(i_a        => s_C30toXOR,
                 i_b        => s_C31toXOR,
                 o_f        => o_Overflow);
    
end structural;