-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- MEM_WB_Register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of our MEM/WB Register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB_Register is
    generic(N   : integer := 32);
    port(i_CLK                  : in std_logic;
         i_RST                  : in std_logic;

         i_MEM_PCNext           : in std_logic_vector(31 downto 0);
         i_MEM_Halt             : in std_logic;
         i_MEM_Write_Data_Sel   : in std_logic_vector(1 downto 0);
         i_MEM_RegWr            : in std_logic;
         i_MEM_Ovfl             : in std_logic;
         i_MEM_ALUout           : in std_logic_vector(31 downto 0);
         i_MEM_DMemOut          : in std_logic_vector(31 downto 0);
         i_MEM_RegWrAddr        : in std_logic_vector(4 downto 0);
         
         o_WB_Halt              : out std_logic;
         o_WB_Ovfl              : out std_logic;
         o_WB_ALUout            : out std_logic_vector(31 downto 0);
         o_WB_Write_Data_Sel    : out std_logic_vector(1 downto 0);
         o_WB_DMemOut           : out std_logic_vector(31 downto 0);
         o_WB_PCNext            : out std_logic_vector(31 downto 0);
         o_WB_RegWrAddr         : out std_logic_vector(4 downto 0);
         o_WB_RegWr             : out std_logic);
end MEM_WB_Register;

architecture structural of MEM_WB_Register is

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;

    signal it_MEM_Halt,
           it_MEM_RegWr,
           it_MEM_Ovfl,
           ot_WB_Halt,
           ot_WB_RegWr,
           ot_WB_Ovfl : std_logic_vector(0 downto 0);

    begin
        
        it_MEM_Halt(0) <= i_MEM_Halt;
        it_MEM_RegWr(0) <= i_MEM_RegWr;
        it_MEM_Ovfl(0) <= i_MEM_Ovfl;

        g_PCNext: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_MEM_PCNext,
                o_Data      => o_WB_PCNext);
        
        g_Halt: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_MEM_Halt,
                o_Data      => ot_WB_Halt);
        
        g_Write_Data_Sel: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_MEM_Write_Data_Sel,
                o_Data      => o_WB_Write_Data_Sel);
        
        g_RegWr: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_MEM_RegWr,
                o_Data      => ot_WB_RegWr);
        
        g_Ovfl: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_MEM_Ovfl,
                o_Data      => ot_WB_Ovfl);
        
        g_ALUout: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_MEM_ALUout,
                o_Data      => o_WB_ALUout);
        
        g_DMemOut: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_MEM_DMemOut,
                o_Data      => o_WB_DMemOut);
        
        g_RegWrAddr: register_N
            generic map(N => 5)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_MEM_RegWrAddr,
                o_Data      => o_WB_RegWrAddr);

        o_WB_Halt <= ot_WB_Halt(0);
        o_WB_RegWr <= ot_WB_RegWr(0);
        o_WB_Ovfl <= ot_WB_Ovfl(0);

end structural;