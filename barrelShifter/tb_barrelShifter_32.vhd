-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrelShifter_32 is

    generic(gCLK_HPER   : time := 50 ns);

end tb_barrelShifter_32;

architecture mixed of tb_barrelShifter_32 is
  
    constant cCLK_PER  : time := gCLK_HPER * 2;
    
    component barrelShifter_32 is
        generic(L : integer := 2; M : integer := 5; N : integer := 32);
        port(
            i_shiftAmount   : in std_logic_vector(M-1 downto 0);    -- shift amount input
            i_shiftType     : in std_logic_vector(L-1 downto 0);    -- shift type input
            i_in            : in std_logic_vector(N-1 downto 0);    -- data input
            o_out           : out std_logic_vector(N-1 downto 0)    -- data output
        );
    end component;

    signal s_shiftAmount    : std_logic_vector(4 downto 0)  := b"00000";
    signal s_shiftType      : std_logic_vector(1 downto 0)  := b"00";
    signal s_in             : std_logic_vector(31 downto 0) := x"0000_0000";
    signal s_out            : std_logic_vector(31 downto 0);

    begin
        DUT0: barrelShifter_32
        port map(
            i_shiftAmount   => s_shiftAmount,
            i_shiftType     => s_shiftType,
            i_in            => s_in,
            o_out           => s_out);

        TEST_CASES: process
        begin
            wait for gCLK_HPER/2;

------------------------------------------------
--------------- Shift Left Tests ---------------
------------------------------------------------

            -- Test case 0:
            s_shiftAmount   <= b"00001";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"579A_2468"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_shiftAmount   <= b"00010";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"AF34_48D0"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_shiftAmount   <= b"00100";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"BCD1_2340"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_shiftAmount   <= b"01000";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"CD12_3400"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_shiftAmount   <= b"10000";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"1234_0000"

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_shiftAmount   <= b"00011";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"5E68_91A0"

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_shiftAmount   <= b"00110";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"F344_8D00"

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_shiftAmount   <= b"01100";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"D123_4000"

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_shiftAmount   <= b"11000";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"3400_0000"

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_shiftAmount   <= b"11111";
            s_shiftType     <= b"00";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"0000_0000"

            wait for gCLK_HPER*2;

------------------------------------------------
--------------- Shift Right Tests --------------
------------------------------------------------

            -- Test case 0:
            s_shiftAmount   <= b"00001";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"55E6_891A"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_shiftAmount   <= b"00010";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"2AF3_448D"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_shiftAmount   <= b"00100";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"0ABC_D123"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_shiftAmount   <= b"01000";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"00AB_CD12"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_shiftAmount   <= b"10000";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"0000_ABCD"

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_shiftAmount   <= b"00011";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"1579_A246"

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_shiftAmount   <= b"00110";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"02AF_3448"

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_shiftAmount   <= b"01100";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"000A_BCD1"

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_shiftAmount   <= b"11000";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"0000_00AB"

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_shiftAmount   <= b"11111";
            s_shiftType     <= b"01";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"0000_0001"

            wait for gCLK_HPER*2;

            ------------------------------------------------
            --------- Shift Right Arithmetic Tests ---------
            ------------------------------------------------
            
            -- Test case 0:
            s_shiftAmount   <= b"00001";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"D5E6_891A"

            wait for gCLK_HPER*2;

            -- Test case 1:
            s_shiftAmount   <= b"00010";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"EAF3_448D"

            wait for gCLK_HPER*2;

            -- Test case 2:
            s_shiftAmount   <= b"00100";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FABC_D123"

            wait for gCLK_HPER*2;

            -- Test case 3:
            s_shiftAmount   <= b"01000";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FFAB_CD12"

            wait for gCLK_HPER*2;

            -- Test case 4:
            s_shiftAmount   <= b"10000";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FFFF_ABCD"

            wait for gCLK_HPER*2;

            -- Test case 5:
            s_shiftAmount   <= b"00011";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"F579_A246"

            wait for gCLK_HPER*2;

            -- Test case 6:
            s_shiftAmount   <= b"00110";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FEAF_3448"

            wait for gCLK_HPER*2;

            -- Test case 7:
            s_shiftAmount   <= b"01100";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FFFA_BCD1"

            wait for gCLK_HPER*2;

            -- Test case 8:
            s_shiftAmount   <= b"11000";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FFFF_FFAB"

            wait for gCLK_HPER*2;

            -- Test case 9:
            s_shiftAmount   <= b"11111";
            s_shiftType     <= b"10";
            s_in            <= x"ABCD_1234";
            -- Expected: s_out = x"FFFF_FFFF"

            wait for gCLK_HPER*2;
    end process;

end mixed;