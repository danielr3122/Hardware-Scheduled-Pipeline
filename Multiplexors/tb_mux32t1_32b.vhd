-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_mux32t1_32b.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 32bit 32:1 mux.
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_mux32t1_32b is
        generic(gCLK_HPER   : time := 10 ns);
end tb_mux32t1_32b;

architecture structural of tb_mux32t1_32b is

    component mux32t1_32b is
        generic(N : integer := 32);
        port(i_S        : std_logic_vector(4 downto 0);
             i_D0       : in std_logic_vector(N-1 downto 0);
             i_D1       : in std_logic_vector(N-1 downto 0);
             i_D2       : in std_logic_vector(N-1 downto 0);
             i_D3       : in std_logic_vector(N-1 downto 0);
             i_D4       : in std_logic_vector(N-1 downto 0);
             i_D5       : in std_logic_vector(N-1 downto 0);
             i_D6       : in std_logic_vector(N-1 downto 0);
             i_D7       : in std_logic_vector(N-1 downto 0);
             i_D8       : in std_logic_vector(N-1 downto 0);
             i_D9       : in std_logic_vector(N-1 downto 0);
             i_D10      : in std_logic_vector(N-1 downto 0);
             i_D11      : in std_logic_vector(N-1 downto 0);
             i_D12      : in std_logic_vector(N-1 downto 0);
             i_D13      : in std_logic_vector(N-1 downto 0);
             i_D14      : in std_logic_vector(N-1 downto 0);
             i_D15      : in std_logic_vector(N-1 downto 0);
             i_D16      : in std_logic_vector(N-1 downto 0);
             i_D17      : in std_logic_vector(N-1 downto 0);
             i_D18      : in std_logic_vector(N-1 downto 0);
             i_D19      : in std_logic_vector(N-1 downto 0);
             i_D20      : in std_logic_vector(N-1 downto 0);
             i_D21      : in std_logic_vector(N-1 downto 0);
             i_D22      : in std_logic_vector(N-1 downto 0);
             i_D23      : in std_logic_vector(N-1 downto 0);
             i_D24      : in std_logic_vector(N-1 downto 0);
             i_D25      : in std_logic_vector(N-1 downto 0);
             i_D26      : in std_logic_vector(N-1 downto 0);
             i_D27      : in std_logic_vector(N-1 downto 0);
             i_D28      : in std_logic_vector(N-1 downto 0);
             i_D29      : in std_logic_vector(N-1 downto 0);
             i_D30      : in std_logic_vector(N-1 downto 0);
             i_D31      : in std_logic_vector(N-1 downto 0);
             o_O        : out std_logic_vector(N-1 downto 0));             
    end component;

    signal s_S      : std_logic_vector(4 downto 0) := "00000";
    signal s_D0     : std_logic_vector(31 downto 0) := x"0000_0000"; 
    signal s_D1     : std_logic_vector(31 downto 0) := x"0000_0001";
    signal s_D2     : std_logic_vector(31 downto 0) := x"0000_0002";
    signal s_D3     : std_logic_vector(31 downto 0) := x"0000_0003";
    signal s_D4     : std_logic_vector(31 downto 0) := x"0000_0004";
    signal s_D5     : std_logic_vector(31 downto 0) := x"0000_0005";
    signal s_D6     : std_logic_vector(31 downto 0) := x"0000_0006";
    signal s_D7     : std_logic_vector(31 downto 0) := x"0000_0007";
    signal s_D8     : std_logic_vector(31 downto 0) := x"0000_0008";
    signal s_D9     : std_logic_vector(31 downto 0) := x"0000_0009";
    signal s_D10    : std_logic_vector(31 downto 0) := x"0000_000A";
    signal s_D11    : std_logic_vector(31 downto 0) := x"0000_000B";
    signal s_D12    : std_logic_vector(31 downto 0) := x"0000_000C";
    signal s_D13    : std_logic_vector(31 downto 0) := x"0000_000D";
    signal s_D14    : std_logic_vector(31 downto 0) := x"0000_000E";
    signal s_D15    : std_logic_vector(31 downto 0) := x"0000_000F";
    signal s_D16    : std_logic_vector(31 downto 0) := x"0000_0010";
    signal s_D17    : std_logic_vector(31 downto 0) := x"0000_0011";
    signal s_D18    : std_logic_vector(31 downto 0) := x"0000_0012";
    signal s_D19    : std_logic_vector(31 downto 0) := x"0000_0013";
    signal s_D20    : std_logic_vector(31 downto 0) := x"0000_0014";
    signal s_D21    : std_logic_vector(31 downto 0) := x"0000_0015";
    signal s_D22    : std_logic_vector(31 downto 0) := x"0000_0016";
    signal s_D23    : std_logic_vector(31 downto 0) := x"0000_0017";
    signal s_D24    : std_logic_vector(31 downto 0) := x"0000_0018";
    signal s_D25    : std_logic_vector(31 downto 0) := x"0000_0019";
    signal s_D26    : std_logic_vector(31 downto 0) := x"0000_001A";
    signal s_D27    : std_logic_vector(31 downto 0) := x"0000_001B";
    signal s_D28    : std_logic_vector(31 downto 0) := x"0000_001C";
    signal s_D29    : std_logic_vector(31 downto 0) := x"0000_001D";
    signal s_D30    : std_logic_vector(31 downto 0) := x"0000_001E";
    signal s_D31    : std_logic_vector(31 downto 0) := x"0000_001F";
    signal s_O      : std_logic_vector(31 downto 0);

begin

    DUT0: mux32t1_32b
    port map(i_S    => s_S,   
             i_D0   => s_D0,  
             i_D1   => s_D1, 
             i_D2   => s_D2,  
             i_D3   => s_D3,  
             i_D4   => s_D4,  
             i_D5   => s_D5,  
             i_D6   => s_D6,  
             i_D7   => s_D7,  
             i_D8   => s_D8,  
             i_D9   => s_D9,  
             i_D10  => s_D10, 
             i_D11  => s_D11, 
             i_D12  => s_D12, 
             i_D13  => s_D13, 
             i_D14  => s_D14, 
             i_D15  => s_D15, 
             i_D16  => s_D16, 
             i_D17  => s_D17, 
             i_D18  => s_D18, 
             i_D19  => s_D19, 
             i_D20  => s_D20, 
             i_D21  => s_D21, 
             i_D22  => s_D22, 
             i_D23  => s_D23, 
             i_D24  => s_D24, 
             i_D25  => s_D25, 
             i_D26  => s_D26, 
             i_D27  => s_D27, 
             i_D28  => s_D28, 
             i_D29  => s_D29, 
             i_D30  => s_D30, 
             i_D31  => s_D31, 
             o_O    => s_O);
             
    P_TEST_CASES: process
    begin 
        wait for gCLK_HPER/2;
    
        s_S     <= "00000";
        wait for gCLK_HPER/2;
        s_S     <= "00001";
        wait for gCLK_HPER/2;
        s_S     <= "00010";
        wait for gCLK_HPER/2;
        s_S     <= "00011";
        wait for gCLK_HPER/2;
        s_S     <= "00100";
        wait for gCLK_HPER/2;
        s_S     <= "00101";
        wait for gCLK_HPER/2;
        s_S     <= "00110";
        wait for gCLK_HPER/2;
        s_S     <= "00111";
        wait for gCLK_HPER/2;
        s_S     <= "01000";
        wait for gCLK_HPER/2;
        s_S     <= "01001";
        wait for gCLK_HPER/2;
        s_S     <= "01010";
        wait for gCLK_HPER/2;
        s_S     <= "01011";
        wait for gCLK_HPER/2;
        s_S     <= "01100";
        wait for gCLK_HPER/2;
        s_S     <= "01101";
        wait for gCLK_HPER/2;
        s_S     <= "01110";
        wait for gCLK_HPER/2;
        s_S     <= "01111";
        wait for gCLK_HPER/2;
        s_S     <= "10000";
        wait for gCLK_HPER/2;
        s_S     <= "10001";
        wait for gCLK_HPER/2;
        s_S     <= "10010";
        wait for gCLK_HPER/2;
        s_S     <= "10011";
        wait for gCLK_HPER/2;
        s_S     <= "10100";
        wait for gCLK_HPER/2;
        s_S     <= "10101";
        wait for gCLK_HPER/2;
        s_S     <= "10110";
        wait for gCLK_HPER/2;
        s_S     <= "10111";
        wait for gCLK_HPER/2;
        s_S     <= "11000";
        wait for gCLK_HPER/2;
        s_S     <= "11001";
        wait for gCLK_HPER/2;
        s_S     <= "11010";
        wait for gCLK_HPER/2;
        s_S     <= "11011";
        wait for gCLK_HPER/2;
        s_S     <= "11100";
        wait for gCLK_HPER/2;
        s_S     <= "11101";
        wait for gCLK_HPER/2;
        s_S     <= "11110";
        wait for gCLK_HPER/2;
        s_S     <= "11111";
        wait for gCLK_HPER/2;
    
    end process;

end structural;