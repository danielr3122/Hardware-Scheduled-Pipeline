-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_ControlUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for our MIPS Single
--              Cycle Processor's Control Unit.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_ControlUnit is
    generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ControlUnit;

architecture mixed of tb_ControlUnit is

    component ControlUnit is 
    port(i_opCode           : in std_logic_vector(5 downto 0);
         i_funct            : in std_logic_vector(5 downto 0);
         shiftType          : out std_logic_vector(1 downto 0);
         ALUop              : out std_logic_vector(3 downto 0);
         ALUslt             : out std_logic;
         nAdd_Sub           : out std_logic;
         unsignedSel        : out std_logic;
         RegDest            : out std_logic_vector(1 downto 0);
         RegWr              : out std_logic;
         extSel             : out std_logic;
         ALUsrc             : out std_logic;
         BranchType         : out std_logic;
         BranchInstr        : out std_logic;
         JumpInstr          : out std_logic;
         JumpReg            : out std_logic;
         DMemWr             : out std_logic;
         Write_Data_Sel     : out std_logic_vector(1 downto 0);
         Halt               : out std_logic);
    end component;

    signal s_opCode, s_funct : std_logic_vector(5 downto 0) := b"000000";
    signal s_RegDest, s_Write_Data_Sel, s_shiftType      : std_logic_vector(1 downto 0);
    signal s_ALUop : std_logic_vector(3 downto 0);
    signal s_ALUslt,
           s_nAdd_Sub,
           s_unsignedSel,
           s_RegWr,
           s_extSel,
           s_ALUsrc,
           s_BranchType,
           s_BranchInstr,
           s_JumpInstr,
           s_JumpReg,
           s_DMemWr,
           s_Halt                           : std_logic;


begin

    DUT0: ControlUnit
    port map(i_opCode       => s_opCode,
             i_funct        => s_funct,
             shiftType      => s_shiftType,
             ALUop          => s_ALUop,
             ALUslt         => s_ALUslt,
             nAdd_Sub       => s_nAdd_Sub,
             unsignedSel    => s_unsignedSel,
             RegDest        => s_RegDest,
             RegWr          => s_RegWr,
             extSel         => s_extSel,
             ALUsrc         => s_ALUsrc,
             BranchType     => s_BranchType,
             BranchInstr    => s_BranchInstr,
             JumpInstr      => s_JumpInstr,
             JumpReg        => s_JumpReg,
             DMemWr         => s_DMemWr,
             Write_Data_Sel => s_Write_Data_Sel,
             Halt           => s_Halt);

    P_TEST_CASES: process
    begin 
        wait for gCLK_HPER/2; --5ns

        -- b"000000_100000"  -1- add
        s_opCode    <= b"000000";
        s_funct     <= b"100000";
        wait for gCLK_HPER*2; --20ns 

        -- b"000000_100001"  -2- addu
        s_opCode    <= b"000000";
        s_funct     <= b"100001";
        wait for gCLK_HPER*2;

        -- b"000000_100010"  -3- sub
        s_opCode    <= b"000000";
        s_funct     <= b"100010";
        wait for gCLK_HPER*2;

        -- b"000000_100011"  -4- subu
        s_opCode    <= b"000000";
        s_funct     <= b"100011";
        wait for gCLK_HPER*2;

        -- b"000000_100100"  -5- and
        s_opCode    <= b"000000";
        s_funct     <= b"100100";
        wait for gCLK_HPER*2;

        -- b"000000_100101"  -6- or
        s_opCode    <= b"000000";
        s_funct     <= b"100101";
        wait for gCLK_HPER*2;

        -- b"000000_100110"  -7- xor
        s_opCode    <= b"000000";
        s_funct     <= b"100110";
        wait for gCLK_HPER*2;

        -- b"000000_100111"  -8- nor
        s_opCode    <= b"000000";
        s_funct     <= b"100111";
        wait for gCLK_HPER*2;

        -- b"000000_000000"  -9- sll
        s_opCode    <= b"000000";
        s_funct     <= b"000000";
        wait for gCLK_HPER*2;

        -- b"000000_000010" -10- srl
        s_opCode    <= b"000000";
        s_funct     <= b"000010";
        wait for gCLK_HPER*2;

        -- b"000000_000011" -11- sra
        s_opCode    <= b"000000";
        s_funct     <= b"000011";
        wait for gCLK_HPER*2;

        -- b"000000_xxxxxx" -12- not
        s_opCode    <= b"000000";
        s_funct     <= b"011111";
        wait for gCLK_HPER*2;

        -- b"000000_101010" -13- slt
        s_opCode    <= b"000000";
        s_funct     <= b"101010";
        wait for gCLK_HPER*2;

        -- b"000000_001000" -14- jr
        s_opCode    <= b"000000";
        s_funct     <= b"001000";
        wait for gCLK_HPER*2;

        -- b"001000_000000" -15- addi
        s_opCode    <= b"001000";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001001_000000" -16- addiu
        s_opCode    <= b"001001";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001100_000000" -17- andi
        s_opCode    <= b"001100";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001101_000000" -18- ori
        s_opCode    <= b"001101";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001110_000000" -19- xori
        s_opCode    <= b"001110";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001111_000000" -20- lui
        s_opCode    <= b"001111";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"100011_000000" -21- lw
        s_opCode    <= b"100011";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"101011_000000" -22- sw
        s_opCode    <= b"101011";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"000100_000000" -23- beq
        s_opCode    <= b"000100";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"000101_000000" -24- bne
        s_opCode    <= b"000101";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"001010_000000" -25- slti
        s_opCode    <= b"001010";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"000010_000000" -26- j
        s_opCode    <= b"000010";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"000011_000000" -27- jal
        s_opCode    <= b"000011";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"010100_000000" -28- halt
        s_opCode    <= b"010100";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;

        -- b"011111_000000" -29- Repl
        s_opCode    <= b"011111";
        s_funct     <= b"111111";
        wait for gCLK_HPER*2;
        --590ns
    end process;

end mixed;

-- b"000000_100000"  -1- add
-- b"000000_100001"  -2- addu
-- b"000000_100010"  -3- sub
-- b"000000_100011"  -4- subu
-- b"000000_100100"  -5- and
-- b"000000_100101"  -6- or 
-- b"000000_100110"  -7- xor
-- b"000000_100111"  -8- nor
-- b"000000_000000"  -9- sll
-- b"000000_000010" -10- srl
-- b"000000_000011" -11- sra
-- b"000000_011111" -12- not
-- b"000000_101010" -13- slt
-- b"000000_001000" -14- jr
-- b"001000_000000" -15- addi
-- b"001001_000000" -16- addiu
-- b"001100_000000" -17- andi
-- b"001101_000000" -18- ori
-- b"001110_000000" -19- xori
-- b"001111_000000" -20- lui
-- b"100011_000000" -21- lw
-- b"101011_000000" -22- sw
-- b"000100_000000" -23- beq
-- b"000101_000000" -24- bne
-- b"001010_000000" -25- slti
-- b"000010_000000" -26- j
-- b"000011_000000" -27- jal
-- b"010100_000000" -28- halt
-- b"011111_000000" -29- Repl