-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- register_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-Bit Register
-- utilizing the logic contained in dffg.vhd.
--
-- 09/22/2022 by BR::Design created.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity register_N is
    generic(N : integer := 32);
    port(i_Clock    : in std_logic;
         i_Reset    : in std_logic;
         i_WriteEn  : in std_logic;
         i_Data     : in std_logic_vector(N-1 downto 0);
         o_Data     : out std_logic_vector(N-1 downto 0));
end register_N;

architecture structural of register_N is 

    component dffg is
        port(i_CLK      : in std_logic;
             i_RST      : in std_logic;
             i_WE       : in std_logic;
             i_D        : in std_logic;
             o_Q        : out std_logic);
    end component;

begin

    G_NBit_DFFG: for i in 0 to N-1 generate
        DFFGI: dffg port map(
                i_CLK       => i_Clock,
                i_RST       => i_Reset,
                i_WE        => i_WriteEn,
                i_D         => i_Data(i),
                o_Q         => o_Data(i));
    end generate G_NBit_DFFG;

end structural;
        