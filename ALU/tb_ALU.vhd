-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for ALU Unit.
--              
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_ALU is 
    generic(gCLK_HPER   : time := 10 ns);
end tb_ALU;

architecture mixed of tb_ALU is

    -- Define the total clock period time
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component ALU is 
    port(i_opA                : in std_logic_vector(31 downto 0);
         i_opB                : in std_logic_vector(31 downto 0);
         i_RQBimm             : in std_logic_vector(7 downto 0);
         i_shamt              : in std_logic_vector(4 downto 0);
         i_shiftType          : in std_logic_vector(1 downto 0);
         i_ALUop              : in std_logic_vector(3 downto 0);
         i_ALUslt             : in std_logic;
         i_nAdd_Sub           : in std_logic;
         i_unsignedSelect     : in std_logic;
         o_ALUzero            : out std_logic;
         o_Overflow           : out std_logic;
         o_ALUresult          : out std_logic_vector(31 downto 0));
    end component;

    signal s_opA, s_opB             : std_logic_vector(31 downto 0) := x"00000000";
    signal s_RQBimm                 : std_logic_vector(7 downto 0)  := x"00";
    signal s_shamt                  : std_logic_vector(4 downto 0)  := b"00000";
    signal s_shiftType              : std_logic_vector(1 downto 0)  := b"00";
    signal s_ALUop                  : std_logic_vector(3 downto 0)  := b"0000";
    signal s_ALUslt, 
           s_nAdd_Sub, 
           s_unsignedSelect         : std_logic := '0';
    signal s_ALUzero, s_Overflow    : std_logic;
    signal s_ALUresult              : std_logic_vector(31 downto 0);

begin

    DUT0: ALU
    port map(i_opA              => s_opA,
             i_opB              => s_opB,
             i_RQBimm           => s_RQBimm,
             i_shamt            => s_shamt,
             i_shiftType        => s_shiftType,
             i_ALUop            => s_ALUop,
             i_ALUslt           => s_ALUslt,
             i_nAdd_Sub         => s_nAdd_Sub,
             i_unsignedSelect   => s_unsignedSelect,
             o_ALUzero          => s_ALUzero,
             o_Overflow         => s_Overflow,
             o_ALUresult        => s_ALUresult);
    
    P_TEST_CASES: process
    begin
        wait for gCLK_HPER/2;
        
        --Test Case 1
        -- add x"0000_0002" + x"0000_0002"
        s_opA               <= x"00000002";
        s_opB               <= x"00000002";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0000";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 4, OF=> 0, ALUzero=> 0

        --Test Case 2
        -- add testing overflow
        s_opA               <= x"7FFFFFFF";
        s_opB               <= x"00000002";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0000";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=>80000001, OF=> 1, ALUzero=> 0

        --Test Case 2
        -- add unsigned, overflow should not be triggered
        s_opA               <= x"7FFFFFFF";
        s_opB               <= x"00000002";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0000";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '1';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=>80000001, OF=> 0, ALUzero=> 0

        --Test Case 3
        -- sub x"0000_0002" - x"0000_0002" and checking ALUzero output
        s_opA               <= x"00000002";
        s_opB               <= x"00000002";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0000";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '1';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 0, OF=> 0, ALUzero=> 1

        --Test Case 4
        -- slt x"0000_0002" - x"0000_0026" and checking SLT
        s_opA               <= x"00000002";
        s_opB               <= x"00000026";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0001";
        s_ALUslt            <= '1';
        s_nAdd_Sub          <= '1';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 1, OF=> 0, ALUzero=>0

        --Test Case 5
        -- AND x"FFFF_FFFF" - x"0000_0000" testing AND
        s_opA               <= x"FFFFFFFF";
        s_opB               <= x"00000000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0010";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> x"0000_0000", OF=>x, ALUzero=>x

        --Test Case 5
        -- NOR x"FFFF_FFFF" - x"0000_0000" testing NOR
        s_opA               <= x"FFFFFFFF";
        s_opB               <= x"00000000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0011";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> x"0000_0000", OF=>x, ALUzero=>x

        --Test Case 6
        -- OR 
        s_opA               <= x"FFFFFFFF";
        s_opB               <= x"00000000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0100";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> FFFFFFFF, OF=>x, ALUzero=>x

        --Test Case 5
        -- XOR 
        s_opA               <= x"AAAAAAAA";
        s_opB               <= x"55555555";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0101";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> x"FFFF_FFFF", OF=>x, ALUzero=>x

        --Test Case 5
        -- NOT 
        s_opA               <= x"FFFFFFFF";
        s_opB               <= x"00000000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0111";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> x"00000000", OF=>x, ALUzero=>x

        --Test Case 7
        -- SLL x"0000_BEEF" shift left 16 bits
        s_opA               <= x"00000000";
        s_opB               <= x"0000BEEF";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"10000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"0110";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> BEEF0000, OF=>x, ALUzero=>x

        --Test Case 7
        -- SRL x"BEEF_0000" shift right 16 bits
        s_opA               <= x"00000000";
        s_opB               <= x"BEEF0000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"10000";
        s_shiftType         <= b"01";
        s_ALUop             <= b"0110";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 0000BEEF, OF=>x, ALUzero=>x

        --Test Case 7
        -- SRA x"FEEB_0000" shift right 16 bits
        s_opA               <= x"00000000";
        s_opB               <= x"FEEB0000";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"10000";
        s_shiftType         <= b"10";
        s_ALUop             <= b"0110";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> FFFFFEEB, OF=>x, ALUzero=>x

        --Test Case 8
        -- LUI, load x"4321" into upper bits
        s_opA               <= x"00000000";
        s_opB               <= x"00004321";          
        s_RQBimm            <= x"00";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"1000";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 43210000, OF=>x, ALUzero=>x

        --Test Case 9
        -- REPL, replicate x"8F"
        s_opA               <= x"00000000";
        s_opB               <= x"00000000";          
        s_RQBimm            <= x"8F";
        s_shamt             <= b"00000";
        s_shiftType         <= b"00";
        s_ALUop             <= b"1001";
        s_ALUslt            <= '0';
        s_nAdd_Sub          <= '0';
        s_unsignedSelect    <= '0';
        wait for gCLK_HPER*2;
        --Expected output: ALUresult=> 8F8F8F8F, OF=>x, ALUzero=>x

    end process;

end mixed;