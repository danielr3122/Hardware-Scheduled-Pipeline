-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_extender16t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 16:32bit extender.
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_extender16t32 is
        generic(gCLK_HPER   : time := 10 ns);
end tb_extender16t32;

architecture structural of tb_extender16t32 is

    component extender16t32 is
        port(i_extSelect    : in std_logic;
             i_data16       : in std_logic_vector(15 downto 0);
             o_data32       : out std_logic_vector(31 downto 0));
    end component;
    
    signal s_extSelect      : std_logic := '0';
    signal s_iData16        : std_logic_vector(15 downto 0) := x"0000";
    signal s_oData32        : std_logic_vector(31 downto 0);

begin

    DUT0: extender16t32
    port map(i_extSelect    => s_extSelect,
             i_data16       => s_iData16,
             o_data32       => s_oData32);
    
    P_TEST_CASES: process
    begin
        wait for gCLK_HPER/2;

        -- Zero Extend x"1010" to x"0000_F010"
        s_iData16       <= x"F010";
        wait for gCLK_HPER*2;

        -- Now Sign Extend to x"FFFF_F010"
        s_extSelect     <= '1';
        wait for gCLK_HPER*2;

        -- Zero Extend x"0001" to x"0000_0001"
        s_extSelect     <= '0';
        s_iData16       <= x"0001";
        wait for gCLK_HPER*2;

        -- Now Sign Extend to x"0000_0001"
        s_extSelect     <= '1';
        wait for gCLK_HPER*2;

    end process;

end structural;