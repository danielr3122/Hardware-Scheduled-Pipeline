-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of a 32-bit multiplexor.
--
--
-- NOTES:
-- 9/28/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_32 is
    generic(N   : integer := 5; M   : integer := 32);
    port(
        i_s     : in std_logic_vector(N-1 downto 0);    -- Selector input value
        i_d0    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d1    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d2    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d3    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d4    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d5    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d6    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d7    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d8    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d9    : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d10   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d11   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d12   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d13   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d14   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d15   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d16   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d17   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d18   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d19   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d20   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d21   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d22   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d23   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d24   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d25   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d26   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d27   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d28   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d29   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d30   : in std_logic_vector(M-1 downto 0);    -- Data input
        i_d31   : in std_logic_vector(M-1 downto 0);    -- Data input
        o_q     : out std_logic_vector(M-1 downto 0));  -- Data output
end mux_32;

architecture dataflow of mux_32 is

    begin
    with i_s select
        o_q <=  i_d0    when b"00000",
                i_d1    when b"00001",
                i_d2    when b"00010",
                i_d3    when b"00011",
                i_d4    when b"00100",
                i_d5    when b"00101",
                i_d6    when b"00110",
                i_d7    when b"00111",
                i_d8    when b"01000",
                i_d9    when b"01001",
                i_d10   when b"01010",
                i_d11   when b"01011",
                i_d12   when b"01100",
                i_d13   when b"01101",
                i_d14   when b"01110",
                i_d15   when b"01111",
                i_d16   when b"10000",
                i_d17   when b"10001",
                i_d18   when b"10010",
                i_d19   when b"10011",
                i_d20   when b"10100",
                i_d21   when b"10101",
                i_d22   when b"10110",
                i_d23   when b"10111",
                i_d24   when b"11000",
                i_d25   when b"11001",
                i_d26   when b"11010",
                i_d27   when b"11011",
                i_d28   when b"11100",
                i_d29   when b"11101",
                i_d30   when b"11110",
                i_d31   when b"11111",
                x"0000_0000" when others;

end dataflow;
