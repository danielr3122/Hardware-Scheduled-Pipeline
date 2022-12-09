-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_ALUControlUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for our ALU Control Unit.
--
--
-- NOTES:
-- 11/4/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALUControlUnit is
    generic(gCLK_HPER   : time := 10 ns);
end tb_ALUControlUnit;

architecture dataflow of tb_ALUControlUnit is

    constant cCLK_PER   : time := gCLK_HPER * 2;

    component ALUControlUnit is
        generic(K   : integer := 5; L   : integer := 4; M   : integer := 2);
        port(
            i_ALUControlOp  : in std_logic_vector(K-1 downto 0);    -- ALU Control Unit input
            o_shiftType     : out std_logic_vector(M-1 downto 0);   -- Shift type selector
            o_ALUop         : out std_logic_vector(L-1 downto 0);   -- ALUop selector
            o_ALUslt        : out std_logic;                        -- ALUslt selector
            o_nAdd_Sub      : out std_logic;                        -- Add/Sub selector
            o_unsignedSel   : out std_logic);                       -- Signed/unsigned selector
    end component;

    signal s_ALUControlOp   : std_logic_vector(4 downto 0) := "00000";
    signal s_shiftType      : std_logic_vector(1 downto 0);
    signal s_ALUop          : std_logic_vector(3 downto 0);
    signal s_ALUslt         : std_logic;
    signal s_nAdd_Sub       : std_logic;
    signal s_unsignedSel    : std_logic;

    begin
        DUT0: ALUControlUnit
        port map(
            i_ALUControlOp  => s_ALUControlOp,
            o_shiftType     => s_shiftType,
            o_ALUop         => s_ALUop,
            o_ALUslt        => s_ALUslt,
            o_nAdd_Sub      => s_nAdd_Sub,
            o_unsignedSel   => s_unsignedSel);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

            -- Test case 0 - add:
            s_ALUControlOp <= "00000";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 1 - addu:
            s_ALUControlOp <= "00001";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '1'

            wait for gCLK_HPER*2;

            -- Test case 2 - sub:
            s_ALUControlOp <= "00010";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 3 - subu:
            s_ALUControlOp <= "00011";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '1'

            wait for gCLK_HPER*2;

            -- Test case 4 - and:
            s_ALUControlOp <= "00100";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0010"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 5 - or:
            s_ALUControlOp <= "00101";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0100"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 6 - xor:
            s_ALUControlOp <= "00110";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0101"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 7 - nor:
            s_ALUControlOp <= "00111";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0011"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 8 - sll:
            s_ALUControlOp <= "01000";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0110"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 9 - srl:
            s_ALUControlOp <= "01001";
            -- Expected:
            -- s_shiftType = "01"
            -- s_ALUop = "0110"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 10 - sra:
            s_ALUControlOp <= "01010";
            -- Expected:
            -- s_shiftType = "10"
            -- s_ALUop = "0110"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 11 - not:
            s_ALUControlOp <= "01011";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0111"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 12 - slt:
            s_ALUControlOp <= "01100";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '1'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 13 - addi:
            s_ALUControlOp <= "01101";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 14 - addiu:
            s_ALUControlOp <= "01110";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '1'

            wait for gCLK_HPER*2;

            -- Test case 15 - andi:
            s_ALUControlOp <= "01111";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0010"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 16 - ori:
            s_ALUControlOp <= "10000";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0100"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 17 - xori:
            s_ALUControlOp <= "10001";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0101"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = X
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 18 - lui:
            s_ALUControlOp <= "10010";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "1000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 19 - lw:
            s_ALUControlOp <= "10011";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 20 - sw:
            s_ALUControlOp <= "10100";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 21 - beq:
            s_ALUControlOp <= "10101";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 22 - bne:
            s_ALUControlOp <= "10110";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 23 - slti:
            s_ALUControlOp <= "10111";
            -- Expected:
            -- s_shiftType = X
            -- s_ALUop = "0001"
            -- s_ALUslt = '1'
            -- s_nAdd_Sub = '1'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 24 - Repl.qb
            s_ALUControlOp <= "11000";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "1001"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 25 - other:
            s_ALUControlOp <= "11001";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 26 - other:
            s_ALUControlOp <= "11010";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 27 - other:
            s_ALUControlOp <= "11011";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 28 - other:
            s_ALUControlOp <= "11100";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 29 - other:
            s_ALUControlOp <= "11101";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 30 - other:
            s_ALUControlOp <= "11110";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;

            -- Test case 31 - other:
            s_ALUControlOp <= "11111";
            -- Expected:
            -- s_shiftType = "00"
            -- s_ALUop = "0000"
            -- s_ALUslt = '0'
            -- s_nAdd_Sub = '0'
            -- s_unsignedSel = '0'

            wait for gCLK_HPER*2;
            --650ns
        end process;

end dataflow;