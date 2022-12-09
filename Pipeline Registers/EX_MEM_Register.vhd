-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- EX_MEM_Register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of our EX/MEM Register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_MEM_Register is
    port(i_CLK                  : in std_logic;
         i_RST                  : in std_logic;

         i_EX_PCNext            : in std_logic_vector(31 downto 0);
         i_EX_Halt              : in std_logic;
         i_EX_DMemWr            : in std_logic;
         i_EX_Write_Data_Sel    : in std_logic_vector(1 downto 0);
         i_EX_RegWr             : in std_logic;
         i_EX_readData2         : in std_logic_vector(31 downto 0);
         i_EX_Ovfl              : in std_logic;
         i_EX_ALUout            : in std_logic_vector(31 downto 0);
         i_EX_RegWrAddr         : in std_logic_vector(4 downto 0);

         o_MEM_PCNext           : out std_logic_vector(31 downto 0);
         o_MEM_Halt             : out std_logic;
         o_MEM_DMemWr           : out std_logic;
         o_MEM_Write_Data_Sel   : out std_logic_vector(1 downto 0);
         o_MEM_RegWr            : out std_logic;
         o_MEM_DMemData         : out std_logic_vector(31 downto 0);
         o_MEM_Ovfl             : out std_logic;
         o_MEM_ALUout           : out std_logic_vector(31 downto 0);
         o_MEM_RegWrAddr        : out std_logic_vector(4 downto 0));
end EX_MEM_Register;

architecture structural of EX_MEM_Register is

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;

    signal it_EX_Halt,
           it_EX_DMemWr,
           it_EX_RegWr,
           it_EX_Ovfl,
           ot_MEM_Halt,
           ot_MEM_DMemWr,
           ot_MEM_RegWr,
           ot_MEM_Ovfl : std_logic_vector(0 downto 0);

    begin

        it_EX_Halt(0) <= i_EX_Halt;
        it_EX_DMemWr(0) <= i_EX_DMemWr;
        it_EX_RegWr(0) <= i_EX_RegWr;
        it_EX_Ovfl(0) <= i_EX_Ovfl;
        
        g_PCNext: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_EX_PCNext,
                o_Data      => o_MEM_PCNext);
        
        g_Halt: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_EX_Halt,
                o_Data      => ot_MEM_Halt);
        
        g_DMemWr: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_EX_DMemWr,
                o_Data      => ot_MEM_DMemWr);
        
        g_Write_Data_Sel: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_EX_Write_Data_Sel,
                o_Data      => o_MEM_Write_Data_Sel);
        
        g_RegWr: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_EX_RegWr,
                o_Data      => ot_MEM_RegWr);
        
        g_ReadData2: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_EX_readData2,
                o_Data      => o_MEM_DMemData);
        
        g_Ovfl: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_EX_Ovfl,
                o_Data      => ot_MEM_Ovfl);
        
        g_ALUout: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_EX_ALUout,
                o_Data      => o_MEM_ALUout);
        
        g_RegWrAddr: register_N
            generic map(N => 5)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_EX_RegWrAddr,
                o_Data      => o_MEM_RegWrAddr);

        o_MEM_Halt      <= ot_MEM_Halt(0);
        o_MEM_DMemWr    <= ot_MEM_DMemWr(0);
        o_MEM_RegWr     <= ot_MEM_RegWr(0);
        o_MEM_Ovfl      <= ot_MEM_Ovfl(0);

end structural;