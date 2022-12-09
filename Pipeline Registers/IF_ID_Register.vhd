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

entity IF_ID_Register is
    generic(N   : integer := 32);
    port(i_CLK              : in std_logic;
         i_RST              : in std_logic;
         i_IF_Inst          : in std_logic_vector(N-1 downto 0);
         i_IF_PCNext        : in std_logic_vector(N-1 downto 0);
         o_ID_Inst          : out std_logic_vector(N-1 downto 0);
         o_ID_PCNext        : out std_logic_vector(N-1 downto 0));
end IF_ID_Register;

architecture structural of IF_ID_Register is

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;

    begin
        
        g_PCNext: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_IF_PCNext,
                o_Data      => o_ID_PCNext);

        g_Inst: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_IF_Inst,
                o_Data      => o_ID_Inst);

end structural;