-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- tb_register_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the N-bit Register
--              utilizing the dffg.vhd.
--              
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_register_N is 
    generic(gCLK_HPER   : time := 50 ns);
end tb_register_N;

architecture behavior of tb_register_N is
  
    -- Calculate the clock period as twice the half-period
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component register_N is 
        generic(N : integer := 32);
        port(i_Clock        : in std_logic;
             i_Reset        : in std_logic;
             i_WriteEn      : in std_logic;
             i_Data         : in std_logic_vector(N-1 downto 0);
             o_Data         : out std_logic_vector(N-1 downto 0));
    end component;

    -- Intermediate Control Signals
    signal s_Clock, s_Reset, s_WriteEn      : std_logic;
    signal s_iData, s_oData                 : std_logic_vector(31 downto 0);

begin

    DUT0: register_N
    port map(i_Clock    => s_Clock,
             i_Reset    => s_Reset,
             i_WriteEn  => s_WriteEn,
             i_Data     => s_iData,
             o_Data     => s_oData);

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

    -- Testbench Process
    P_TB: process
    begin
        -- Reset the Register
        s_Reset     <= '1';
        s_WriteEn   <= '0';
        s_iData     <= x"00000000";
        wait for cCLK_PER;

        -- Turn Off Reset, Attempt to fill new data with write disabled
        s_Reset     <= '0';
        s_iData     <= x"AAAA_AAAA";
        wait for cCLK_PER;
        -- Register Data remain zero until write is enabled

        -- Enable Write
        s_WriteEn   <= '1';
        wait for cCLK_PER;
        -- Register should update to input data's value

        -- Enable Write
        s_WriteEn   <= '0';
        wait for cCLK_PER;

        -- Reset the Register
        s_Reset     <= '1';
        wait for cCLK_PER;

    wait;
    end process;

end behavior; 