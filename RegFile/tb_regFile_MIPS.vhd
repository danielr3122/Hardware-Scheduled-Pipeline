-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_regFile_MIPS.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the MIPS Register
--              File which utilizes 32 32bit registers.
--              
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_regFile_MIPS is 
    generic(gCLK_HPER   : time := 50 ns);
end tb_regFile_MIPS;

architecture behavior of tb_regFile_MIPS is
  
    -- Calculate the clock period as twice the half-period
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component regFile_MIPS is
        generic(N : integer := 32;
                M : integer := 5); 
        port(i_Clock        : in std_logic;
             i_Reset        : in std_logic;
             i_RegWrite     : in std_logic;
             i_WriteReg     : in std_logic_vector(M-1 downto 0);
             i_ReadReg1     : in std_logic_vector(M-1 downto 0);
             i_ReadReg2     : in std_logic_vector(M-1 downto 0);
             i_WriteData    : in std_logic_vector(N-1 downto 0);
             o_ReadData1    : out std_logic_vector(N-1 downto 0);
             o_ReadData2    : out std_logic_vector(N-1 downto 0));
    end component;

    signal s_Clock, s_Reset, s_RegWrite             : std_logic;
    signal s_WriteReg, s_ReadReg1, s_ReadReg2       : std_logic_vector(4 downto 0);
    signal s_WriteData, s_ReadData1, s_ReadData2    : std_logic_vector(31 downto 0);

begin

    DUT0: regFile_MIPS
    port map(i_Clock            => s_Clock,
             i_Reset            => s_Reset,
             i_RegWrite         => s_RegWrite,
             i_WriteReg         => s_WriteReg,
             i_ReadReg1         => s_ReadReg1,
             i_ReadReg2         => s_ReadReg2,
             i_WriteData        => s_WriteData,
             o_ReadData1        => s_ReadData1,
             o_ReadData2        => s_ReadData2);

    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_Clock: process
    begin
        s_Clock <= '0';
        wait for gCLK_HPER;
        s_Clock <= '1';
        wait for gCLK_HPER;
    end process;   

    -- TestBench Process
    P_TB: process
    begin
        
        -- Reset Register File
        s_Reset         <= '1';
        s_RegWrite      <= '0';
        s_WriteReg      <= "00000";
        s_ReadReg1      <= "00000";
        s_ReadReg2      <= "00000";
        s_WriteData     <= x"0000_0000";
        wait for cCLK_PER;
        
        s_Reset <= '0';
        wait for cCLK_PER;

        -- Write 25 into register 25
        s_RegWrite      <= '1';
        s_WriteReg      <= "11001";
        s_WriteData     <= x"0000_0019";
        wait for cCLK_PER;

        -- Read Register 25 out of Read Data 1 Line, change write data while reg write is off
        s_RegWrite      <= '0';
        s_ReadReg1      <= "11001";
        s_WriteData     <= x"FFFF_FFFF";
        wait for cCLK_PER;

        -- ReWrite into register 25, but with "AAAA_AAAA"
        s_RegWrite      <= '1';
        s_WriteReg      <= "11001";
        s_WriteData     <= x"AAAA_AAAA";
        wait for cCLK_PER;

        -- Read Register 25 out of Read Data 2 Line
        s_RegWrite      <= '0';
        s_ReadReg2      <= "11001";
        wait for cCLK_PER;

        -- Attempt to write into register zero
        s_RegWrite      <= '1';
        s_WriteReg      <= "00000";
        s_WriteData     <= x"BEEF_3210";
        wait for cCLK_PER;

        -- Read Register 0 out of Both data output lines
        s_RegWrite      <= '0';
        s_ReadReg1      <= "00000";
        s_ReadReg2      <= "00000";
        wait for cCLK_PER;

        s_Reset <= '1';
        wait for cCLK_PER;

    wait;
    end process;

end behavior;