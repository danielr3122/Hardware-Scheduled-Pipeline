-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- barrelShifter_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit 
-- barrel shifter.
--
--
-- NOTES:
-- 10/9/22 by Daniel: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

---------------------------
-- Barrel Shifter Entity --
---------------------------

entity barrelShifter_32 is
    generic(L : integer := 2; M : integer := 5; N : integer := 32);
    port(
        i_shiftAmount   : in std_logic_vector(M-1 downto 0);    -- shift amount input
        i_shiftType     : in std_logic_vector(L-1 downto 0);    -- shift type input
        i_in            : in std_logic_vector(N-1 downto 0);    -- data input
        o_out           : out std_logic_vector(N-1 downto 0)    -- data output
    );
end barrelShifter_32;

---------------------------------
-- Barrel Shifter Architecture --
---------------------------------

architecture mixed of barrelShifter_32 is

    component mux2t1_dataflow is
        port(i_d0       : in std_logic;
             i_d1       : in std_logic;
             i_s        : in std_logic;
             o_o        : out std_logic);
    end component;

    -- Intermediate Signals
    signal s_data1, s_data2, s_data3, s_data4, s_data5, s_data6 : std_logic_vector(31 downto 0);    -- Propogated data
    signal s_dir        : std_logic;                        -- Shift direction
    signal s_spacer     : std_logic;                        -- Value inserted from the edges

    begin

        s_dir       <= not (i_shiftType(0) xor i_shiftType(1)); -- 00 = sll | 01 = srl | 10 = sra
        s_spacer    <= i_shiftType(1) and i_in(31);             -- if sra, then match bit 31's sign

-------------------------------------
---------- First Row Muxes ----------
-------------------------------------

        g_Mux31_1: mux2t1_dataflow
        port map(i_d0   => i_in(31),
                 i_d1   => i_in(0),
                 i_s    => s_dir,
                 o_o    => s_data1(31));

        g_Mux30_1: mux2t1_dataflow
        port map(i_d0   => i_in(30),
                 i_d1   => i_in(1),
                 i_s    => s_dir,
                 o_o    => s_data1(30));

        g_Mux29_1: mux2t1_dataflow
        port map(i_d0   => i_in(29),
                 i_d1   => i_in(2),
                 i_s    => s_dir,
                 o_o    => s_data1(29));

        g_Mux28_1: mux2t1_dataflow
        port map(i_d0   => i_in(28),
                 i_d1   => i_in(3),
                 i_s    => s_dir,
                 o_o    => s_data1(28));

        g_Mux27_1: mux2t1_dataflow
        port map(i_d0   => i_in(27),
                 i_d1   => i_in(4),
                 i_s    => s_dir,
                 o_o    => s_data1(27));

        g_Mux26_1: mux2t1_dataflow
        port map(i_d0   => i_in(26),
                 i_d1   => i_in(5),
                 i_s    => s_dir,
                 o_o    => s_data1(26));

        g_Mux25_1: mux2t1_dataflow
        port map(i_d0   => i_in(25),
                 i_d1   => i_in(6),
                 i_s    => s_dir,
                 o_o    => s_data1(25));

        g_Mux24_1: mux2t1_dataflow
        port map(i_d0   => i_in(24),
                 i_d1   => i_in(7),
                 i_s    => s_dir,
                 o_o    => s_data1(24));

        g_Mux23_1: mux2t1_dataflow
        port map(i_d0   => i_in(23),
                 i_d1   => i_in(8),
                 i_s    => s_dir,
                 o_o    => s_data1(23));

        g_Mux22_1: mux2t1_dataflow
        port map(i_d0   => i_in(22),
                 i_d1   => i_in(9),
                 i_s    => s_dir,
                 o_o    => s_data1(22));

        g_Mux21_1: mux2t1_dataflow
        port map(i_d0   => i_in(21),
                 i_d1   => i_in(10),
                 i_s    => s_dir,
                 o_o    => s_data1(21));

        g_Mux20_1: mux2t1_dataflow
        port map(i_d0   => i_in(20),
                 i_d1   => i_in(11),
                 i_s    => s_dir,
                 o_o    => s_data1(20));

        g_Mux19_1: mux2t1_dataflow
        port map(i_d0   => i_in(19),
                 i_d1   => i_in(12),
                 i_s    => s_dir,
                 o_o    => s_data1(19));

        g_Mux18_1: mux2t1_dataflow
        port map(i_d0   => i_in(18),
                 i_d1   => i_in(13),
                 i_s    => s_dir,
                 o_o    => s_data1(18));

        g_Mux17_1: mux2t1_dataflow
        port map(i_d0   => i_in(17),
                 i_d1   => i_in(14),
                 i_s    => s_dir,
                 o_o    => s_data1(17));

        g_Mux16_1: mux2t1_dataflow
        port map(i_d0   => i_in(16),
                 i_d1   => i_in(15),
                 i_s    => s_dir,
                 o_o    => s_data1(16));

        g_Mux15_1: mux2t1_dataflow
        port map(i_d0   => i_in(15),
                 i_d1   => i_in(16),
                 i_s    => s_dir,
                 o_o    => s_data1(15));

        g_Mux14_1: mux2t1_dataflow
        port map(i_d0   => i_in(14),
                 i_d1   => i_in(17),
                 i_s    => s_dir,
                 o_o    => s_data1(14));

        g_Mux13_1: mux2t1_dataflow
        port map(i_d0   => i_in(13),
                 i_d1   => i_in(18),
                 i_s    => s_dir,
                 o_o    => s_data1(13));

        g_Mux12_1: mux2t1_dataflow
        port map(i_d0   => i_in(12),
                 i_d1   => i_in(19),
                 i_s    => s_dir,
                 o_o    => s_data1(12));

        g_Mux11_1: mux2t1_dataflow
        port map(i_d0   => i_in(11),
                 i_d1   => i_in(20),
                 i_s    => s_dir,
                 o_o    => s_data1(11));

        g_Mux10_1: mux2t1_dataflow
        port map(i_d0   => i_in(10),
                 i_d1   => i_in(21),
                 i_s    => s_dir,
                 o_o    => s_data1(10));

        g_Mux9_1: mux2t1_dataflow
        port map(i_d0   => i_in(9),
                 i_d1   => i_in(22),
                 i_s    => s_dir,
                 o_o    => s_data1(9));

        g_Mux8_1: mux2t1_dataflow
        port map(i_d0   => i_in(8),
                 i_d1   => i_in(23),
                 i_s    => s_dir,
                 o_o    => s_data1(8));

        g_Mux7_1: mux2t1_dataflow
        port map(i_d0   => i_in(7),
                 i_d1   => i_in(24),
                 i_s    => s_dir,
                 o_o    => s_data1(7));

        g_Mux6_1: mux2t1_dataflow
        port map(i_d0   => i_in(6),
                 i_d1   => i_in(25),
                 i_s    => s_dir,
                 o_o    => s_data1(6));

        g_Mux5_1: mux2t1_dataflow
        port map(i_d0   => i_in(5),
                 i_d1   => i_in(26),
                 i_s    => s_dir,
                 o_o    => s_data1(5));

        g_Mux4_1: mux2t1_dataflow
        port map(i_d0   => i_in(4),
                 i_d1   => i_in(27),
                 i_s    => s_dir,
                 o_o    => s_data1(4));

        g_Mux3_1: mux2t1_dataflow
        port map(i_d0   => i_in(3),
                 i_d1   => i_in(28),
                 i_s    => s_dir,
                 o_o    => s_data1(3));

        g_Mux2_1: mux2t1_dataflow
        port map(i_d0   => i_in(2),
                 i_d1   => i_in(29),
                 i_s    => s_dir,
                 o_o    => s_data1(2));

        g_Mux1_1: mux2t1_dataflow
        port map(i_d0   => i_in(1),
                 i_d1   => i_in(30),
                 i_s    => s_dir,
                 o_o    => s_data1(1));

        g_Mux0_1: mux2t1_dataflow
        port map(i_d0   => i_in(0),
                 i_d1   => i_in(31),
                 i_s    => s_dir,
                 o_o    => s_data1(0));

-------------------------------------
--------- Second Row Muxes ----------
-------------------------------------

        g_Mux31_2: mux2t1_dataflow
        port map(i_d0   => s_data1(31),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(31));

        g_Mux30_2: mux2t1_dataflow
        port map(i_d0   => s_data1(30),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(30));

        g_Mux29_2: mux2t1_dataflow
        port map(i_d0   => s_data1(29),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(29));

        g_Mux28_2: mux2t1_dataflow
        port map(i_d0   => s_data1(28),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(28));

        g_Mux27_2: mux2t1_dataflow
        port map(i_d0   => s_data1(27),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(27));

        g_Mux26_2: mux2t1_dataflow
        port map(i_d0   => s_data1(26),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(26));

        g_Mux25_2: mux2t1_dataflow
        port map(i_d0   => s_data1(25),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(25));

        g_Mux24_2: mux2t1_dataflow
        port map(i_d0   => s_data1(24),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(24));

        g_Mux23_2: mux2t1_dataflow
        port map(i_d0   => s_data1(23),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(23));

        g_Mux22_2: mux2t1_dataflow
        port map(i_d0   => s_data1(22),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(22));

        g_Mux21_2: mux2t1_dataflow
        port map(i_d0   => s_data1(21),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(21));

        g_Mux20_2: mux2t1_dataflow
        port map(i_d0   => s_data1(20),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(20));

        g_Mux19_2: mux2t1_dataflow
        port map(i_d0   => s_data1(19),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(19));

        g_Mux18_2: mux2t1_dataflow
        port map(i_d0   => s_data1(18),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(18));

        g_Mux17_2: mux2t1_dataflow
        port map(i_d0   => s_data1(17),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(17));

        g_Mux16_2: mux2t1_dataflow
        port map(i_d0   => s_data1(16),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(16));

        g_Mux15_2: mux2t1_dataflow
        port map(i_d0   => s_data1(15),
                 i_d1   => s_data1(31),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(15));

        g_Mux14_2: mux2t1_dataflow
        port map(i_d0   => s_data1(14),
                 i_d1   => s_data1(30),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(14));

        g_Mux13_2: mux2t1_dataflow
        port map(i_d0   => s_data1(13),
                 i_d1   => s_data1(29),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(13));

        g_Mux12_2: mux2t1_dataflow
        port map(i_d0   => s_data1(12),
                 i_d1   => s_data1(28),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(12));

        g_Mux11_2: mux2t1_dataflow
        port map(i_d0   => s_data1(11),
                 i_d1   => s_data1(27),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(11));

        g_Mux10_2: mux2t1_dataflow
        port map(i_d0   => s_data1(10),
                 i_d1   => s_data1(26),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(10));

        g_Mux9_2: mux2t1_dataflow
        port map(i_d0   => s_data1(9),
                 i_d1   => s_data1(25),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(9));

        g_Mux8_2: mux2t1_dataflow
        port map(i_d0   => s_data1(8),
                 i_d1   => s_data1(24),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(8));

        g_Mux7_2: mux2t1_dataflow
        port map(i_d0   => s_data1(7),
                 i_d1   => s_data1(23),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(7));

        g_Mux6_2: mux2t1_dataflow
        port map(i_d0   => s_data1(6),
                 i_d1   => s_data1(22),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(6));

        g_Mux5_2: mux2t1_dataflow
        port map(i_d0   => s_data1(5),
                 i_d1   => s_data1(21),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(5));

        g_Mux4_2: mux2t1_dataflow
        port map(i_d0   => s_data1(4),
                 i_d1   => s_data1(20),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(4));

        g_Mux3_2: mux2t1_dataflow
        port map(i_d0   => s_data1(3),
                 i_d1   => s_data1(19),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(3));

        g_Mux2_2: mux2t1_dataflow
        port map(i_d0   => s_data1(2),
                 i_d1   => s_data1(18),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(2));

        g_Mux1_2: mux2t1_dataflow
        port map(i_d0   => s_data1(1),
                 i_d1   => s_data1(17),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(1));

        g_Mux0_2: mux2t1_dataflow
        port map(i_d0   => s_data1(0),
                 i_d1   => s_data1(16),
                 i_s    => i_shiftAmount(4),
                 o_o    => s_data2(0));

-------------------------------------
---------- Third Row Muxes ----------
-------------------------------------

        g_Mux31_3: mux2t1_dataflow
        port map(i_d0   => s_data2(31),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(31));

        g_Mux30_3: mux2t1_dataflow
        port map(i_d0   => s_data2(30),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(30));

        g_Mux29_3: mux2t1_dataflow
        port map(i_d0   => s_data2(29),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(29));

        g_Mux28_3: mux2t1_dataflow
        port map(i_d0   => s_data2(28),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(28));

        g_Mux27_3: mux2t1_dataflow
        port map(i_d0   => s_data2(27),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(27));

        g_Mux26_3: mux2t1_dataflow
        port map(i_d0   => s_data2(26),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(26));

        g_Mux25_3: mux2t1_dataflow
        port map(i_d0   => s_data2(25),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(25));

        g_Mux24_3: mux2t1_dataflow
        port map(i_d0   => s_data2(24),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(24));

        g_Mux23_3: mux2t1_dataflow
        port map(i_d0   => s_data2(23),
                 i_d1   => s_data2(31),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(23));

        g_Mux22_3: mux2t1_dataflow
        port map(i_d0   => s_data2(22),
                 i_d1   => s_data2(30),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(22));

        g_Mux21_3: mux2t1_dataflow
        port map(i_d0   => s_data2(21),
                 i_d1   => s_data2(29),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(21));

        g_Mux20_3: mux2t1_dataflow
        port map(i_d0   => s_data2(20),
                 i_d1   => s_data2(28),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(20));

        g_Mux19_3: mux2t1_dataflow
        port map(i_d0   => s_data2(19),
                 i_d1   => s_data2(27),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(19));

        g_Mux18_3: mux2t1_dataflow
        port map(i_d0   => s_data2(18),
                 i_d1   => s_data2(26),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(18));

        g_Mux17_3: mux2t1_dataflow
        port map(i_d0   => s_data2(17),
                 i_d1   => s_data2(25),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(17));

        g_Mux16_3: mux2t1_dataflow
        port map(i_d0   => s_data2(16),
                 i_d1   => s_data2(24),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(16));

        g_Mux15_3: mux2t1_dataflow
        port map(i_d0   => s_data2(15),
                 i_d1   => s_data2(23),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(15));

        g_Mux14_3: mux2t1_dataflow
        port map(i_d0   => s_data2(14),
                 i_d1   => s_data2(22),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(14));

        g_Mux13_3: mux2t1_dataflow
        port map(i_d0   => s_data2(13),
                 i_d1   => s_data2(21),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(13));

        g_Mux12_3: mux2t1_dataflow
        port map(i_d0   => s_data2(12),
                 i_d1   => s_data2(20),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(12));

        g_Mux11_3: mux2t1_dataflow
        port map(i_d0   => s_data2(11),
                 i_d1   => s_data2(19),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(11));

        g_Mux10_3: mux2t1_dataflow
        port map(i_d0   => s_data2(10),
                 i_d1   => s_data2(18),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(10));

        g_Mux9_3: mux2t1_dataflow
        port map(i_d0   => s_data2(9),
                 i_d1   => s_data2(17),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(9));

        g_Mux8_3: mux2t1_dataflow
        port map(i_d0   => s_data2(8),
                 i_d1   => s_data2(16),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(8));

        g_Mux7_3: mux2t1_dataflow
        port map(i_d0   => s_data2(7),
                 i_d1   => s_data2(15),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(7));

        g_Mux6_3: mux2t1_dataflow
        port map(i_d0   => s_data2(6),
                 i_d1   => s_data2(14),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(6));

        g_Mux5_3: mux2t1_dataflow
        port map(i_d0   => s_data2(5),
                 i_d1   => s_data2(13),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(5));

        g_Mux4_3: mux2t1_dataflow
        port map(i_d0   => s_data2(4),
                 i_d1   => s_data2(12),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(4));

        g_Mux3_3: mux2t1_dataflow
        port map(i_d0   => s_data2(3),
                 i_d1   => s_data2(11),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(3));

        g_Mux2_3: mux2t1_dataflow
        port map(i_d0   => s_data2(2),
                 i_d1   => s_data2(10),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(2));

        g_Mux1_3: mux2t1_dataflow
        port map(i_d0   => s_data2(1),
                 i_d1   => s_data2(9),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(1));

        g_Mux0_3: mux2t1_dataflow
        port map(i_d0   => s_data2(0),
                 i_d1   => s_data2(8),
                 i_s    => i_shiftAmount(3),
                 o_o    => s_data3(0));

-------------------------------------
--------- Fourth Row Muxes ----------
-------------------------------------

        g_Mux31_4: mux2t1_dataflow
        port map(i_d0   => s_data3(31),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(31));

        g_Mux30_4: mux2t1_dataflow
        port map(i_d0   => s_data3(30),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(30));

        g_Mux29_4: mux2t1_dataflow
        port map(i_d0   => s_data3(29),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(29));

        g_Mux28_4: mux2t1_dataflow
        port map(i_d0   => s_data3(28),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(28));

        g_Mux27_4: mux2t1_dataflow
        port map(i_d0   => s_data3(27),
                 i_d1   => s_data3(31),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(27));

        g_Mux26_4: mux2t1_dataflow
        port map(i_d0   => s_data3(26),
                 i_d1   => s_data3(30),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(26));

        g_Mux25_4: mux2t1_dataflow
        port map(i_d0   => s_data3(25),
                 i_d1   => s_data3(29),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(25));

        g_Mux24_4: mux2t1_dataflow
        port map(i_d0   => s_data3(24),
                 i_d1   => s_data3(28),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(24));

        g_Mux23_4: mux2t1_dataflow
        port map(i_d0   => s_data3(23),
                 i_d1   => s_data3(27),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(23));

        g_Mux22_4: mux2t1_dataflow
        port map(i_d0   => s_data3(22),
                 i_d1   => s_data3(26),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(22));

        g_Mux21_4: mux2t1_dataflow
        port map(i_d0   => s_data3(21),
                 i_d1   => s_data3(25),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(21));

        g_Mux20_4: mux2t1_dataflow
        port map(i_d0   => s_data3(20),
                 i_d1   => s_data3(24),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(20));

        g_Mux19_4: mux2t1_dataflow
        port map(i_d0   => s_data3(19),
                 i_d1   => s_data3(23),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(19));

        g_Mux18_4: mux2t1_dataflow
        port map(i_d0   => s_data3(18),
                 i_d1   => s_data3(22),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(18));

        g_Mux17_4: mux2t1_dataflow
        port map(i_d0   => s_data3(17),
                 i_d1   => s_data3(21),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(17));

        g_Mux16_4: mux2t1_dataflow
        port map(i_d0   => s_data3(16),
                 i_d1   => s_data3(20),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(16));

        g_Mux15_4: mux2t1_dataflow
        port map(i_d0   => s_data3(15),
                 i_d1   => s_data3(19),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(15));

        g_Mux14_4: mux2t1_dataflow
        port map(i_d0   => s_data3(14),
                 i_d1   => s_data3(18),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(14));

        g_Mux13_4: mux2t1_dataflow
        port map(i_d0   => s_data3(13),
                 i_d1   => s_data3(17),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(13));

        g_Mux12_4: mux2t1_dataflow
        port map(i_d0   => s_data3(12),
                 i_d1   => s_data3(16),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(12));

        g_Mux11_4: mux2t1_dataflow
        port map(i_d0   => s_data3(11),
                 i_d1   => s_data3(15),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(11));

        g_Mux10_4: mux2t1_dataflow
        port map(i_d0   => s_data3(10),
                 i_d1   => s_data3(14),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(10));

        g_Mux9_4: mux2t1_dataflow
        port map(i_d0   => s_data3(9),
                 i_d1   => s_data3(13),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(9));

        g_Mux8_4: mux2t1_dataflow
        port map(i_d0   => s_data3(8),
                 i_d1   => s_data3(12),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(8));

        g_Mux7_4: mux2t1_dataflow
        port map(i_d0   => s_data3(7),
                 i_d1   => s_data3(11),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(7));

        g_Mux6_4: mux2t1_dataflow
        port map(i_d0   => s_data3(6),
                 i_d1   => s_data3(10),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(6));

        g_Mux5_4: mux2t1_dataflow
        port map(i_d0   => s_data3(5),
                 i_d1   => s_data3(9),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(5));

        g_Mux4_4: mux2t1_dataflow
        port map(i_d0   => s_data3(4),
                 i_d1   => s_data3(8),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(4));

        g_Mux3_4: mux2t1_dataflow
        port map(i_d0   => s_data3(3),
                 i_d1   => s_data3(7),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(3));

        g_Mux2_4: mux2t1_dataflow
        port map(i_d0   => s_data3(2),
                 i_d1   => s_data3(6),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(2));

        g_Mux1_4: mux2t1_dataflow
        port map(i_d0   => s_data3(1),
                 i_d1   => s_data3(5),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(1));

        g_Mux0_4: mux2t1_dataflow
        port map(i_d0   => s_data3(0),
                 i_d1   => s_data3(4),
                 i_s    => i_shiftAmount(2),
                 o_o    => s_data4(0));

-------------------------------------
---------- Fifth Row Muxes ----------
-------------------------------------

        g_Mux31_5: mux2t1_dataflow
        port map(i_d0   => s_data4(31),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(31));

        g_Mux30_5: mux2t1_dataflow
        port map(i_d0   => s_data4(30),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(30));

        g_Mux29_5: mux2t1_dataflow
        port map(i_d0   => s_data4(29),
                 i_d1   => s_data4(31),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(29));

        g_Mux28_5: mux2t1_dataflow
        port map(i_d0   => s_data4(28),
                 i_d1   => s_data4(30),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(28));

        g_Mux27_5: mux2t1_dataflow
        port map(i_d0   => s_data4(27),
                 i_d1   => s_data4(29),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(27));

        g_Mux26_5: mux2t1_dataflow
        port map(i_d0   => s_data4(26),
                 i_d1   => s_data4(28),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(26));

        g_Mux25_5: mux2t1_dataflow
        port map(i_d0   => s_data4(25),
                 i_d1   => s_data4(27),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(25));

        g_Mux24_5: mux2t1_dataflow
        port map(i_d0   => s_data4(24),
                 i_d1   => s_data4(26),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(24));

        g_Mux23_5: mux2t1_dataflow
        port map(i_d0   => s_data4(23),
                 i_d1   => s_data4(25),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(23));

        g_Mux22_5: mux2t1_dataflow
        port map(i_d0   => s_data4(22),
                 i_d1   => s_data4(24),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(22));

        g_Mux21_5: mux2t1_dataflow
        port map(i_d0   => s_data4(21),
                 i_d1   => s_data4(23),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(21));

        g_Mux20_5: mux2t1_dataflow
        port map(i_d0   => s_data4(20),
                 i_d1   => s_data4(22),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(20));

        g_Mux19_5: mux2t1_dataflow
        port map(i_d0   => s_data4(19),
                 i_d1   => s_data4(21),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(19));

        g_Mux18_5: mux2t1_dataflow
        port map(i_d0   => s_data4(18),
                 i_d1   => s_data4(20),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(18));

        g_Mux17_5: mux2t1_dataflow
        port map(i_d0   => s_data4(17),
                 i_d1   => s_data4(19),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(17));

        g_Mux16_5: mux2t1_dataflow
        port map(i_d0   => s_data4(16),
                 i_d1   => s_data4(18),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(16));

        g_Mux15_5: mux2t1_dataflow
        port map(i_d0   => s_data4(15),
                 i_d1   => s_data4(17),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(15));

        g_Mux14_5: mux2t1_dataflow
        port map(i_d0   => s_data4(14),
                 i_d1   => s_data4(16),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(14));

        g_Mux13_5: mux2t1_dataflow
        port map(i_d0   => s_data4(13),
                 i_d1   => s_data4(15),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(13));

        g_Mux12_5: mux2t1_dataflow
        port map(i_d0   => s_data4(12),
                 i_d1   => s_data4(14),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(12));

        g_Mux11_5: mux2t1_dataflow
        port map(i_d0   => s_data4(11),
                 i_d1   => s_data4(13),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(11));

        g_Mux10_5: mux2t1_dataflow
        port map(i_d0   => s_data4(10),
                 i_d1   => s_data4(12),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(10));

        g_Mux9_5: mux2t1_dataflow
        port map(i_d0   => s_data4(9),
                 i_d1   => s_data4(11),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(9));

        g_Mux8_5: mux2t1_dataflow
        port map(i_d0   => s_data4(8),
                 i_d1   => s_data4(10),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(8));

        g_Mux7_5: mux2t1_dataflow
        port map(i_d0   => s_data4(7),
                 i_d1   => s_data4(9),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(7));

        g_Mux6_5: mux2t1_dataflow
        port map(i_d0   => s_data4(6),
                 i_d1   => s_data4(8),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(6));

        g_Mux5_5: mux2t1_dataflow
        port map(i_d0   => s_data4(5),
                 i_d1   => s_data4(7),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(5));

        g_Mux4_5: mux2t1_dataflow
        port map(i_d0   => s_data4(4),
                 i_d1   => s_data4(6),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(4));

        g_Mux3_5: mux2t1_dataflow
        port map(i_d0   => s_data4(3),
                 i_d1   => s_data4(5),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(3));

        g_Mux2_5: mux2t1_dataflow
        port map(i_d0   => s_data4(2),
                 i_d1   => s_data4(4),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(2));

        g_Mux1_5: mux2t1_dataflow
        port map(i_d0   => s_data4(1),
                 i_d1   => s_data4(3),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(1));

        g_Mux0_5: mux2t1_dataflow
        port map(i_d0   => s_data4(0),
                 i_d1   => s_data4(2),
                 i_s    => i_shiftAmount(1),
                 o_o    => s_data5(0));

-------------------------------------
---------- Sixth Row Muxes ----------
-------------------------------------

        g_Mux31_6: mux2t1_dataflow
        port map(i_d0   => s_data5(31),
                 i_d1   => s_spacer,
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(31));

        g_Mux30_6: mux2t1_dataflow
        port map(i_d0   => s_data5(30),
                 i_d1   => s_data5(31),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(30));

        g_Mux29_6: mux2t1_dataflow
        port map(i_d0   => s_data5(29),
                 i_d1   => s_data5(30),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(29));

        g_Mux28_6: mux2t1_dataflow
        port map(i_d0   => s_data5(28),
                 i_d1   => s_data5(29),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(28));

        g_Mux27_6: mux2t1_dataflow
        port map(i_d0   => s_data5(27),
                 i_d1   => s_data5(28),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(27));

        g_Mux26_6: mux2t1_dataflow
        port map(i_d0   => s_data5(26),
                 i_d1   => s_data5(27),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(26));

        g_Mux25_6: mux2t1_dataflow
        port map(i_d0   => s_data5(25),
                 i_d1   => s_data5(26),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(25));

        g_Mux24_6: mux2t1_dataflow
        port map(i_d0   => s_data5(24),
                 i_d1   => s_data5(25),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(24));

        g_Mux23_6: mux2t1_dataflow
        port map(i_d0   => s_data5(23),
                 i_d1   => s_data5(24),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(23));

        g_Mux22_6: mux2t1_dataflow
        port map(i_d0   => s_data5(22),
                 i_d1   => s_data5(23),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(22));

        g_Mux21_6: mux2t1_dataflow
        port map(i_d0   => s_data5(21),
                 i_d1   => s_data5(22),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(21));

        g_Mux20_6: mux2t1_dataflow
        port map(i_d0   => s_data5(20),
                 i_d1   => s_data5(21),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(20));

        g_Mux19_6: mux2t1_dataflow
        port map(i_d0   => s_data5(19),
                 i_d1   => s_data5(20),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(19));

        g_Mux18_6: mux2t1_dataflow
        port map(i_d0   => s_data5(18),
                 i_d1   => s_data5(19),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(18));

        g_Mux17_6: mux2t1_dataflow
        port map(i_d0   => s_data5(17),
                 i_d1   => s_data5(18),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(17));

        g_Mux16_6: mux2t1_dataflow
        port map(i_d0   => s_data5(16),
                 i_d1   => s_data5(17),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(16));

        g_Mux15_6: mux2t1_dataflow
        port map(i_d0   => s_data5(15),
                 i_d1   => s_data5(16),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(15));

        g_Mux14_6: mux2t1_dataflow
        port map(i_d0   => s_data5(14),
                 i_d1   => s_data5(15),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(14));

        g_Mux13_6: mux2t1_dataflow
        port map(i_d0   => s_data5(13),
                 i_d1   => s_data5(14),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(13));

        g_Mux12_6: mux2t1_dataflow
        port map(i_d0   => s_data5(12),
                 i_d1   => s_data5(13),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(12));

        g_Mux11_6: mux2t1_dataflow
        port map(i_d0   => s_data5(11),
                 i_d1   => s_data5(12),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(11));

        g_Mux10_6: mux2t1_dataflow
        port map(i_d0   => s_data5(10),
                 i_d1   => s_data5(11),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(10));

        g_Mux9_6: mux2t1_dataflow
        port map(i_d0   => s_data5(9),
                 i_d1   => s_data5(10),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(9));

        g_Mux8_6: mux2t1_dataflow
        port map(i_d0   => s_data5(8),
                 i_d1   => s_data5(9),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(8));

        g_Mux7_6: mux2t1_dataflow
        port map(i_d0   => s_data5(7),
                 i_d1   => s_data5(8),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(7));

        g_Mux6_6: mux2t1_dataflow
        port map(i_d0   => s_data5(6),
                 i_d1   => s_data5(7),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(6));

        g_Mux5_6: mux2t1_dataflow
        port map(i_d0   => s_data5(5),
                 i_d1   => s_data5(6),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(5));

        g_Mux4_6: mux2t1_dataflow
        port map(i_d0   => s_data5(4),
                 i_d1   => s_data5(5),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(4));

        g_Mux3_6: mux2t1_dataflow
        port map(i_d0   => s_data5(3),
                 i_d1   => s_data5(4),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(3));

        g_Mux2_6: mux2t1_dataflow
        port map(i_d0   => s_data5(2),
                 i_d1   => s_data5(3),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(2));

        g_Mux1_6: mux2t1_dataflow
        port map(i_d0   => s_data5(1),
                 i_d1   => s_data5(2),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(1));

        g_Mux0_6: mux2t1_dataflow
        port map(i_d0   => s_data5(0),
                 i_d1   => s_data5(1),
                 i_s    => i_shiftAmount(0),
                 o_o    => s_data6(0));

-------------------------------------
--------- Seventh Row Muxes ---------
-------------------------------------

        g_Mux31_7: mux2t1_dataflow
        port map(i_d0   => s_data6(31),
                 i_d1   => s_data6(0),
                 i_s    => s_dir,
                 o_o    => o_out(31));

        g_Mux30_7: mux2t1_dataflow
        port map(i_d0   => s_data6(30),
                 i_d1   => s_data6(1),
                 i_s    => s_dir,
                 o_o    => o_out(30));

        g_Mux29_7: mux2t1_dataflow
        port map(i_d0   => s_data6(29),
                 i_d1   => s_data6(2),
                 i_s    => s_dir,
                 o_o    => o_out(29));

        g_Mux28_7: mux2t1_dataflow
        port map(i_d0   => s_data6(28),
                 i_d1   => s_data6(3),
                 i_s    => s_dir,
                 o_o    => o_out(28));

        g_Mux27_7: mux2t1_dataflow
        port map(i_d0   => s_data6(27),
                 i_d1   => s_data6(4),
                 i_s    => s_dir,
                 o_o    => o_out(27));

        g_Mux26_7: mux2t1_dataflow
        port map(i_d0   => s_data6(26),
                 i_d1   => s_data6(5),
                 i_s    => s_dir,
                 o_o    => o_out(26));

        g_Mux25_7: mux2t1_dataflow
        port map(i_d0   => s_data6(25),
                 i_d1   => s_data6(6),
                 i_s    => s_dir,
                 o_o    => o_out(25));

        g_Mux24_7: mux2t1_dataflow
        port map(i_d0   => s_data6(24),
                 i_d1   => s_data6(7),
                 i_s    => s_dir,
                 o_o    => o_out(24));

        g_Mux23_7: mux2t1_dataflow
        port map(i_d0   => s_data6(23),
                 i_d1   => s_data6(8),
                 i_s    => s_dir,
                 o_o    => o_out(23));

        g_Mux22_7: mux2t1_dataflow
        port map(i_d0   => s_data6(22),
                 i_d1   => s_data6(9),
                 i_s    => s_dir,
                 o_o    => o_out(22));

        g_Mux21_7: mux2t1_dataflow
        port map(i_d0   => s_data6(21),
                 i_d1   => s_data6(10),
                 i_s    => s_dir,
                 o_o    => o_out(21));

        g_Mux20_7: mux2t1_dataflow
        port map(i_d0   => s_data6(20),
                 i_d1   => s_data6(11),
                 i_s    => s_dir,
                 o_o    => o_out(20));

        g_Mux19_7: mux2t1_dataflow
        port map(i_d0   => s_data6(19),
                 i_d1   => s_data6(12),
                 i_s    => s_dir,
                 o_o    => o_out(19));

        g_Mux18_7: mux2t1_dataflow
        port map(i_d0   => s_data6(18),
                 i_d1   => s_data6(13),
                 i_s    => s_dir,
                 o_o    => o_out(18));

        g_Mux17_7: mux2t1_dataflow
        port map(i_d0   => s_data6(17),
                 i_d1   => s_data6(14),
                 i_s    => s_dir,
                 o_o    => o_out(17));

        g_Mux16_7: mux2t1_dataflow
        port map(i_d0   => s_data6(16),
                 i_d1   => s_data6(15),
                 i_s    => s_dir,
                 o_o    => o_out(16));

        g_Mux15_7: mux2t1_dataflow
        port map(i_d0   => s_data6(15),
                 i_d1   => s_data6(16),
                 i_s    => s_dir,
                 o_o    => o_out(15));

        g_Mux14_7: mux2t1_dataflow
        port map(i_d0   => s_data6(14),
                 i_d1   => s_data6(17),
                 i_s    => s_dir,
                 o_o    => o_out(14));

        g_Mux13_7: mux2t1_dataflow
        port map(i_d0   => s_data6(13),
                 i_d1   => s_data6(18),
                 i_s    => s_dir,
                 o_o    => o_out(13));

        g_Mux12_7: mux2t1_dataflow
        port map(i_d0   => s_data6(12),
                 i_d1   => s_data6(19),
                 i_s    => s_dir,
                 o_o    => o_out(12));

        g_Mux11_7: mux2t1_dataflow
        port map(i_d0   => s_data6(11),
                 i_d1   => s_data6(20),
                 i_s    => s_dir,
                 o_o    => o_out(11));

        g_Mux10_7: mux2t1_dataflow
        port map(i_d0   => s_data6(10),
                 i_d1   => s_data6(21),
                 i_s    => s_dir,
                 o_o    => o_out(10));

        g_Mux9_7: mux2t1_dataflow
        port map(i_d0   => s_data6(9),
                 i_d1   => s_data6(22),
                 i_s    => s_dir,
                 o_o    => o_out(9));

        g_Mux8_7: mux2t1_dataflow
        port map(i_d0   => s_data6(8),
                 i_d1   => s_data6(23),
                 i_s    => s_dir,
                 o_o    => o_out(8));

        g_Mux7_7: mux2t1_dataflow
        port map(i_d0   => s_data6(7),
                 i_d1   => s_data6(24),
                 i_s    => s_dir,
                 o_o    => o_out(7));

        g_Mux6_7: mux2t1_dataflow
        port map(i_d0   => s_data6(6),
                 i_d1   => s_data6(25),
                 i_s    => s_dir,
                 o_o    => o_out(6));

        g_Mux5_7: mux2t1_dataflow
        port map(i_d0   => s_data6(5),
                 i_d1   => s_data6(26),
                 i_s    => s_dir,
                 o_o    => o_out(5));

        g_Mux4_7: mux2t1_dataflow
        port map(i_d0   => s_data6(4),
                 i_d1   => s_data6(27),
                 i_s    => s_dir,
                 o_o    => o_out(4));

        g_Mux3_7: mux2t1_dataflow
        port map(i_d0   => s_data6(3),
                 i_d1   => s_data6(28),
                 i_s    => s_dir,
                 o_o    => o_out(3));

        g_Mux2_7: mux2t1_dataflow
        port map(i_d0   => s_data6(2),
                 i_d1   => s_data6(29),
                 i_s    => s_dir,
                 o_o    => o_out(2));

        g_Mux1_7: mux2t1_dataflow
        port map(i_d0   => s_data6(1),
                 i_d1   => s_data6(30),
                 i_s    => s_dir,
                 o_o    => o_out(1));

        g_Mux0_7: mux2t1_dataflow
        port map(i_d0   => s_data6(0),
                 i_d1   => s_data6(31),
                 i_s    => s_dir,
                 o_o    => o_out(0));

end mixed;