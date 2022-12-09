-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- regFile_MIPS.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a MIPS register
--              file containing 32 registers. Register zero must always
--              output zero. This implementation utilizes a 5:32 decoder
--              and two 32:1 32bit muxes.
--
-- 09/22/2022 by BR::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity regFile_MIPS is
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
end regFile_MIPS;

architecture mixed of regFile_MIPS is 

    component decoder5t32 is
        port(i_A   : in std_logic_vector(4 downto 0);
             o_F   : out std_logic_vector(31 downto 0));
    end component;

    component register_N is
        generic(N : integer := 32);
        port(i_Clock    : in std_logic;
             i_Reset    : in std_logic;
             i_WriteEn  : in std_logic;
             i_Data     : in std_logic_vector(N-1 downto 0);
             o_Data     : out std_logic_vector(N-1 downto 0));
    end component;
    
    component mux32t1_32b is 
        generic(N : integer := 32);
        port(i_S        : in std_logic_vector(4 downto 0);
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
    
    --SIGNALS: intermediate signals between components and levels
    signal s_oDecode            : std_logic_vector(31 downto 0);

    type bus_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal s_RegData_Bus_Array : bus_array; 

begin

    ---------------------------------------------------------------------------
    -- Level 0: Decoder
    ---------------------------------------------------------------------------
    g_Decoder: decoder5t32
        port MAP(i_A    => i_WriteReg,
                 o_F    => s_oDecode);
    ---------------------------------------------------------------------------
    -- Level 2: Register 0 -> 31
    ---------------------------------------------------------------------------
    g_Register0: register_N 
        port MAP(i_Clock         => i_Clock,
                 i_Reset         => '1',
                 i_WriteEn       => '0',
                 i_Data          => x"0000_0000",
                 o_Data          => s_RegData_Bus_Array(0));
    
    G_NBit_REGISTER: for i in 1 to 31 generate
        REGI: register_N port map (
                i_Clock         => i_Clock,
                i_Reset         => i_Reset,
                i_WriteEn       => i_RegWrite and s_oDecode(i),
                i_Data          => i_WriteData,
                o_Data          => s_RegData_Bus_Array(i));
    end generate G_NBit_REGISTER;
    ---------------------------------------------------------------------------
    -- Level 3: Connect Registers to Multiplexors
    ---------------------------------------------------------------------------
    g_Read1_MUX: mux32t1_32b
        port MAP(i_S            => i_ReadReg1,
                i_D0            => s_RegData_Bus_Array(0),
                i_D1            => s_RegData_Bus_Array(1),
                i_D2            => s_RegData_Bus_Array(2),
                i_D3            => s_RegData_Bus_Array(3),
                i_D4            => s_RegData_Bus_Array(4),
                i_D5            => s_RegData_Bus_Array(5),
                i_D6            => s_RegData_Bus_Array(6),
                i_D7            => s_RegData_Bus_Array(7),
                i_D8            => s_RegData_Bus_Array(8),
                i_D9            => s_RegData_Bus_Array(9),
                i_D10           => s_RegData_Bus_Array(10),
                i_D11           => s_RegData_Bus_Array(11),
                i_D12           => s_RegData_Bus_Array(12),
                i_D13           => s_RegData_Bus_Array(13),
                i_D14           => s_RegData_Bus_Array(14),
                i_D15           => s_RegData_Bus_Array(15),
                i_D16           => s_RegData_Bus_Array(16),
                i_D17           => s_RegData_Bus_Array(17),
                i_D18           => s_RegData_Bus_Array(18),
                i_D19           => s_RegData_Bus_Array(19),
                i_D20           => s_RegData_Bus_Array(20),
                i_D21           => s_RegData_Bus_Array(21),
                i_D22           => s_RegData_Bus_Array(22),
                i_D23           => s_RegData_Bus_Array(23),
                i_D24           => s_RegData_Bus_Array(24),
                i_D25           => s_RegData_Bus_Array(25),
                i_D26           => s_RegData_Bus_Array(26),
                i_D27           => s_RegData_Bus_Array(27),
                i_D28           => s_RegData_Bus_Array(28),
                i_D29           => s_RegData_Bus_Array(29),
                i_D30           => s_RegData_Bus_Array(30),
                i_D31           => s_RegData_Bus_Array(31),
                o_O             => o_ReadData1);

    g_Read2_MUX: mux32t1_32b
        port MAP(i_S            => i_ReadReg2,
                i_D0            => s_RegData_Bus_Array(0),
                i_D1            => s_RegData_Bus_Array(1),
                i_D2            => s_RegData_Bus_Array(2),
                i_D3            => s_RegData_Bus_Array(3),
                i_D4            => s_RegData_Bus_Array(4),
                i_D5            => s_RegData_Bus_Array(5),
                i_D6            => s_RegData_Bus_Array(6),
                i_D7            => s_RegData_Bus_Array(7),
                i_D8            => s_RegData_Bus_Array(8),
                i_D9            => s_RegData_Bus_Array(9),
                i_D10           => s_RegData_Bus_Array(10),
                i_D11           => s_RegData_Bus_Array(11),
                i_D12           => s_RegData_Bus_Array(12),
                i_D13           => s_RegData_Bus_Array(13),
                i_D14           => s_RegData_Bus_Array(14),
                i_D15           => s_RegData_Bus_Array(15),
                i_D16           => s_RegData_Bus_Array(16),
                i_D17           => s_RegData_Bus_Array(17),
                i_D18           => s_RegData_Bus_Array(18),
                i_D19           => s_RegData_Bus_Array(19),
                i_D20           => s_RegData_Bus_Array(20),
                i_D21           => s_RegData_Bus_Array(21),
                i_D22           => s_RegData_Bus_Array(22),
                i_D23           => s_RegData_Bus_Array(23),
                i_D24           => s_RegData_Bus_Array(24),
                i_D25           => s_RegData_Bus_Array(25),
                i_D26           => s_RegData_Bus_Array(26),
                i_D27           => s_RegData_Bus_Array(27),
                i_D28           => s_RegData_Bus_Array(28),
                i_D29           => s_RegData_Bus_Array(29),
                i_D30           => s_RegData_Bus_Array(30),
                i_D31           => s_RegData_Bus_Array(31),
                o_O             => o_ReadData2);
end mixed;