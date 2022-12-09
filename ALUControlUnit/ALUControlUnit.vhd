-------------------------------------------------------------------------
-- Daniel Rosenhamer
-- Student of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- ALUControlUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is an implementation of our ALU Control Unit.
--
--
-- NOTES:
-- 11/4/22 created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALUControlUnit is
    generic(K   : integer := 5; L   : integer := 4; M   : integer := 2);
    port(
        i_ALUControlOp  : in std_logic_vector(K-1 downto 0);    -- ALU Control Unit input
        o_shiftType     : out std_logic_vector(M-1 downto 0);   -- Shift type selector
        o_ALUop         : out std_logic_vector(L-1 downto 0);   -- ALUop selector
        o_ALUslt        : out std_logic;                        -- ALUslt selector
        o_nAdd_Sub      : out std_logic;                        -- Add/Sub selector
        o_unsignedSel   : out std_logic);                       -- Signed/unsigned selector
end ALUControlUnit;

architecture dataflow of ALUControlUnit is

    begin

        with i_ALUControlOp select
            o_shiftType <= "00" when "01000",
                           "01" when "01001",
                           "10" when "01010",
                           "00" when others;

        with i_ALUControlOp select
            o_ALUop <= "0000" when "00000" | "00001" | "01101" | "01110" | "10011" | "10100",
                       "0001" when "00010" | "00011" | "01100" | "10101" | "10110" | "10111",
                       "0010" when "00100" | "01111",
                       "0011" when "00111",
                       "0100" when "00101" | "10000",
                       "0101" when "00110" | "10001",
                       "0110" when "01000" | "01001" | "01010",
                       "0111" when "01011",
                       "1000" when "10010",
                       "1001" when "11000",
                       "0000" when others;

        with i_ALUControlOp select
            o_ALUslt <= '0' when "00000" | "00001" | "00010" | "00011" | "00100" | "00101"
                               | "00110" | "00111" | "01000" | "01001" | "01010" | "01011"
                               | "01101" | "01110" | "01111" | "10000" | "10001" | "10010" 
                               | "10011" | "10100" | "10101" | "10110" | "11000" | "11001" 
                               | "11010" | "11011" | "11100" | "11101" | "11110" | "11111",
                        '1' when "01100" | "10111",
                        '0' when others;

        with i_ALUControlOp select
            o_nAdd_Sub <= '0' when "00000" | "00001" | "01101" | "01110" | "10011" | "10100",
                          '1' when "00010" | "00011" | "01100" | "10101" | "10110" | "10111",
                          '0' when others;

        with i_ALUControlOp select
            o_unsignedSel <= '0' when "00000" | "00010" | "00100" | "00101"
                                    | "00110" | "00111" | "01000" | "01001" | "01010" | "01011"
                                    | "01100" | "01101" | "01111" | "10000" | "10001" | "10010" 
                                    | "10011" | "10100" | "10101" | "10110" | "10111",
                             '1' when "00001" | "00011" | "01110",
                             '0' when others;

end dataflow;
