-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- ID_EX_Register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of our ID/EX Register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Register is
    port(i_CLK                  : in std_logic;
         i_RST                  : in std_logic;

         i_ID_PCNext            : in std_logic_vector(31 downto 0);
         i_ID_Halt              : in std_logic;
         i_ID_DMemWr            : in std_logic;
         i_ID_Write_Data_Sel    : in std_logic_vector(1 downto 0);
         i_ID_ALUsrc            : in std_logic;
         i_ID_ShiftType         : in std_logic_vector(1 downto 0);
         i_ID_ALUop             : in std_logic_vector(3 downto 0);
         i_ID_ALUslt            : in std_logic;
         i_ID_nAdd_Sub          : in std_logic;
         i_ID_UnsignedSelect    : in std_logic;
         i_ID_RegWr             : in std_logic;
         i_ID_RegDest           : in std_logic_vector(1 downto 0);
         i_ID_Inst              : in std_logic_vector(31 downto 0);
         i_ID_extendedImm       : in std_logic_vector(31 downto 0);
         i_ID_readData1         : in std_logic_vector(31 downto 0);
         i_ID_readData2         : in std_logic_vector(31 downto 0);

         o_EX_PCNext            : out std_logic_vector(31 downto 0);
         o_EX_Halt              : out std_logic;
         o_EX_DMemWr            : out std_logic;
         o_EX_Write_Data_Sel    : out std_logic_vector(1 downto 0);
         o_EX_RegWr             : out std_logic;
         o_EX_readData1         : out std_logic_vector(31 downto 0);
         o_EX_readData2         : out std_logic_vector(31 downto 0);
         o_EX_extendedImm       : out std_logic_vector(31 downto 0);
         o_EX_ALUsrc            : out std_logic;
         o_EX_ShiftType         : out std_logic_vector(1 downto 0);
         o_EX_ALUop             : out std_logic_vector(3 downto 0);
         o_EX_ALUslt            : out std_logic;
         o_EX_nAdd_Sub          : out std_logic;
         o_EX_UnsignedSelect    : out std_logic;
         o_EX_RegDest           : out std_logic_vector(1 downto 0);
         o_EX_Inst              : out std_logic_vector(31 downto 0));
end ID_EX_Register;

architecture structural of ID_EX_Register is

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;

    signal it_ID_Halt,
           it_ID_DMemWr,
           it_ID_ALUsrc,
           it_ID_ALUslt,
           it_ID_nAdd_Sub,
           it_ID_UnsignedSelect,
           it_ID_RegWr,
           ot_EX_Halt,
           ot_EX_DMemWr,
           ot_EX_ALUsrc,
           ot_EX_ALUslt,
           ot_EX_nAdd_Sub,
           ot_EX_UnsignedSelect,
           ot_EX_RegWr : std_logic_vector(0 downto 0);

    begin

        it_ID_Halt(0) <= i_ID_Halt;
        it_ID_DMemWr(0) <= i_ID_DMemWr;
        it_ID_ALUsrc(0) <= i_ID_ALUsrc;
        it_ID_ALUslt(0) <= i_ID_ALUslt;
        it_ID_nAdd_Sub(0) <= i_ID_nAdd_Sub;
        it_ID_UnsignedSelect(0) <= i_ID_UnsignedSelect;
        it_ID_RegWr(0) <= i_ID_RegWr;
        
        g_PCNext: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_PCNext,
                o_Data      => o_EX_PCNext);

        g_Halt: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_Halt,
                o_Data      => ot_EX_Halt);

        g_DMemWr: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_DMemWr,
                o_Data      => ot_EX_DMemWr);

        g_Write_Data_Sel: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_Write_Data_Sel,
                o_Data      => o_EX_Write_Data_Sel);

        g_ALUsrc: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_ALUsrc,
                o_Data      => ot_EX_ALUsrc);

        g_ShiftType: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_ShiftType,
                o_Data      => o_EX_ShiftType);

        g_ALUop: register_N
            generic map(N => 4)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_ALUop,
                o_Data      => o_EX_ALUop);

        g_ALUslt: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_ALUslt,
                o_Data      => ot_EX_ALUslt);

        g_nAdd_Sub: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_nAdd_Sub,
                o_Data      => ot_EX_nAdd_Sub);

        g_UnsignedSelect: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_UnsignedSelect,
                o_Data      => ot_EX_UnsignedSelect);

        g_RegWr: register_N
            generic map(N => 1)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => it_ID_RegWr,
                o_Data      => ot_EX_RegWr);

        g_RegDest: register_N
            generic map(N => 2)
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_RegDest,
                o_Data      => o_EX_RegDest);

        g_Inst: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_Inst,
                o_Data      => o_EX_Inst);

        g_extendedImm: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_extendedImm,
                o_Data      => o_EX_extendedImm);

        g_readData1: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_readData1,
                o_Data      => o_EX_readData1);

        g_readData2: register_N
            port map(
                i_Clock     => i_CLK,
                i_Reset     => i_RST,
                i_WriteEn   => '1',
                i_Data      => i_ID_readData2,
                o_Data      => o_EX_readData2);

        o_EX_Halt <= ot_EX_Halt(0);
        o_EX_DMemWr <= ot_EX_DMemWr(0);
        o_EX_ALUsrc <= ot_EX_ALUsrc(0);
        o_EX_ALUslt <= ot_EX_ALUslt(0);
        o_EX_nAdd_Sub <= ot_EX_nAdd_Sub(0);
        o_EX_UnsignedSelect <= ot_EX_UnsignedSelect(0);
        o_EX_RegWr <= ot_EX_RegWr(0);

end structural;