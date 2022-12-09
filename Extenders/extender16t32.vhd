-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- extender16t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 16:32bit
--              extender, that uses a 1bit control signal to choose 
--              between zero extending and sign extending.
--
-- 09/22/2022 by BR::Design created.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity extender16t32 is
    port(i_extSelect    : in std_logic;
         i_data16       : in std_logic_vector(15 downto 0);
         o_data32       : out std_logic_vector(31 downto 0));
end extender16t32;

architecture dataflow of extender16t32 is

    signal s_zeroExt, s_signExt     : std_logic_vector(31 downto 0);

begin

    s_zeroExt <= std_logic_vector(resize(unsigned(i_data16), s_zeroExt'length));
    s_signExt <= std_logic_vector(resize(signed(i_data16), s_signExt'length));

    with i_extSelect select
        o_data32 <= s_zeroExt   when '0',    -- Zero Extend when i_extSelect == 0
                    s_signExt   when '1',    -- Sign Extend when i_extSelect == 1
                    x"00000000" when others; -- ERROR
    
end dataflow;

