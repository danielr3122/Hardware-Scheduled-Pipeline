-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- IF_ID_Register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of our IF/ID Register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity JAL_reg is
    port(i_CLK              : in std_logic;
         i_RST              : in std_logic;
         i_WE               : in std_logic;
         i_WB_JALaddr       : in std_logic_vector(31 downto 0);
         i_WB_RegDest       : in std_logic_vector(1 downto 0);
         o_postPonedJAL     : out std_logic_vector(31 downto 0);
         o_postPonedJALsel  : out std_logic_vector(1 downto 0));
end JAL_reg;

architecture structural of JAL_reg is

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;

    begin

        g_JAL: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => i_WE,
                i_Data      => i_WB_JALaddr,
                o_Data      => o_postPonedJALsel); 
                
        g_Sel: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => i_WE,
                i_Data      => i_WB_RegDest,
                o_Data      => o_postPonedJALsel);

end structural;

    
