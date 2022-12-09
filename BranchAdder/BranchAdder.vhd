-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- BranchAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of our branch adder.
--
--
-- NOTES:
-- 11/5/22 created.
-------------------------------------------------------------------------

library IEEE;                                           
use IEEE.std_logic_1164.all;

entity BranchAdder is
    generic(N   : integer := 32);
    port(i_d0       : in std_logic_vector(N-1 downto 0);
         i_d1       : in std_logic_vector(N-1 downto 0);
         o_o        : out std_logic_vector(N-1 downto 0));
end BranchAdder;

architecture structural of BranchAdder is

    component rippleAdder_N is
        generic(N : integer := 32);
        port(i_Cin      : in std_logic;
             i_opA      : in std_logic_vector(N-1 downto 0);
             i_opB      : in std_logic_vector(N-1 downto 0);
             o_Sum      : out std_logic_vector(N-1 downto 0);
             o_Cout30   : out std_logic;
             o_Cout31   : out std_logic);
    end component;

    signal dummySignal0, dummySignal1   : std_logic;

    begin
    
        g_rippleAdder: rippleAdder_N
            port MAP(i_Cin      => '0',
                     i_opA      => i_d0,
                     i_opB      => i_d1,
                     o_Sum      => o_o,
                     o_Cout30   => dummySignal0,
                     o_Cout31   => dummySignal1);

end structural;