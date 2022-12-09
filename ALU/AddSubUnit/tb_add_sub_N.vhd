-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 2:1 multiplexor.
--              
-- 09/01/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_add_sub_N is 
    generic(gCLK_HPER   : time := 10 ns);
end tb_add_sub_N;

architecture mixed of tb_add_sub_N is

    -- Define the total clock period time
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component add_sub_N is
        generic(N : integer := 32);
        port(i_A        : in std_logic_vector(N-1 downto 0);
             i_B        : in std_logic_vector(N-1 downto 0);
             nAdd_Sub   : in std_logic;
             o_SumDiff  : out std_logic_vector(N-1 downto 0);
             o_Overflow : out std_logic);
    end component;

    signal s_A, s_B             : std_logic_vector(31 downto 0) := x"00000000";
    signal s_nAdd_Sub           : std_logic := '0';
    signal s_SumDiff            : std_logic_vector(31 downto 0) := x"00000000";
    signal s_Overflow           : std_logic;

begin

    DUT0: add_sub_N
    generic map (32)
    port map(i_A        => s_A,
             i_B        => s_B,
             nAdd_Sub   => s_nAdd_Sub,
             o_SumDiff  => s_SumDiff,
             o_Overflow => s_Overflow);

    P_TEST_CASES: process
    begin
        wait for gCLK_HPER/2;

        --Test Case 1:
        s_A             <= x"00000000";
        s_B             <= x"00000000";
        s_nAdd_Sub      <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"00000000", OF => 0

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        --Test Case 2:
        s_A             <= x"FFFFFFFF";
        s_B             <= x"00000000";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"FFFFFFFF", o_Cout => 0

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        --Test Case 3:
        s_A             <= x"FFFFFFFF";
        s_B             <= x"FFFFFFFF";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"FFFFFFFE", o_Cout => 1

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        --Test Case 4:
        s_A             <= x"FFFFFFFF";
        s_B             <= x"00000001";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"00000000", o_Cout => 1

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        --Test Case 5:
        s_A             <= x"0000002A";
        s_B             <= x"000000A0";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"000000CA", o_Cout => 0

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        s_A             <= x"00000006";
        s_B             <= x"00000007";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;
        --Expected output: o_SumDiff => x"000000CA", o_Cout => 0

        s_nAdd_Sub      <= '1';
        wait for gCLK_HPER*2;

        -- P + P = N OF=>1
        s_A             <= x"7FFFFFFF";
        s_B             <= x"00000007";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;

        -- N + N = P OF=>1
        s_A             <= x"80000000";
        s_B             <= x"FFFFFFFF";
        s_nAdd_Sub        <= '0';
        wait for gCLK_HPER*2;



    end process;

end mixed;