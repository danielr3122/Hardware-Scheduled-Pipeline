-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the mux2t1 structural unit.
--              
-- NOTES:
-- 9/5/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_mux2t1 is
    generic(gCLK_HPER   : time := 10 ns);
end tb_mux2t1;

architecture mixed of tb_mux2t1 is

constant cCLK_PER   : time := gCLK_HPER * 2;

component mux2t1 is
    port(i_d0       : in std_logic;
         i_d1       : in std_logic;
         i_s        : in std_logic;
         o_o        : out std_logic);
end component;

signal s_s          : std_logic := '0';
signal s_d0, s_d1   : std_logic := '0';
signal s_o          : std_logic;

begin

    DUT0: mux2t1
    port map(
              i_d0     => s_d0,
              i_d1     => s_d1,
              i_s      => s_s,
              o_o      => s_o);

    P_TEST_CASES: process
    begin
        wait for gCLK_HPER/2;

        -- Test case 0:
        s_s     <= '0';
        s_d0    <= '0';
        s_d1    <= '0';
        -- Expect: output signal to be 0.

        wait for gCLK_HPER*2;

        -- Test case 1:
        s_s     <= '0';
        s_d0    <= '0';
        s_d1    <= '1';
        -- Expect: output signal to be 0.

        wait for gCLK_HPER*2;

        -- Test case 2:
        s_s     <= '0';
        s_d0    <= '1';
        s_d1    <= '0';
        -- Expect: output signal to be 1.

        wait for gCLK_HPER*2;

        -- Test case 3:
        s_s     <= '0';
        s_d0    <= '1';
        s_d1    <= '1';
        -- Expect: output signal to be 1.

        wait for gCLK_HPER*2;

        -- Test case 4:
        s_s     <= '1';
        s_d0    <= '0';
        s_d1    <= '0';
        -- Expect: output signal to be 0.

        wait for gCLK_HPER*2;

        -- Test case 5:
        s_s     <= '1';
        s_d0    <= '0';
        s_d1    <= '1';
        -- Expect: output signal to be 1.

        wait for gCLK_HPER*2;

        -- Test case 6:
        s_s     <= '1';
        s_d0    <= '1';
        s_d1    <= '0';
        -- Expect: output signal to be 0.

        wait for gCLK_HPER*2;

        -- Test case 7:
        s_s     <= '1';
        s_d0    <= '1';
        s_d1    <= '1';
        -- Expect: output signal to be 1.

        wait for gCLK_HPER*2;
    end process;

end mixed;