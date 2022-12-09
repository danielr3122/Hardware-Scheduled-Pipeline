-------------------------------------------------------------------------
-- Brayton Rude
-- rude87@iastate.edu
-------------------------------------------------------------------------
-- ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an ALU for a 
--              single cycle mips processor.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is 
    port(i_opA                : in std_logic_vector(31 downto 0);
         i_opB                : in std_logic_vector(31 downto 0);
         i_RQBimm             : in std_logic_vector(7 downto 0);
         i_shamt              : in std_logic_vector(4 downto 0);
         i_shiftType          : in std_logic_vector(1 downto 0);
         i_ALUop              : in std_logic_vector(3 downto 0);
         i_ALUslt             : in std_logic;
         i_nAdd_Sub           : in std_logic;
         i_unsignedSelect     : in std_logic;
         o_ALUzero            : out std_logic;
         o_Overflow           : out std_logic;
         o_ALUresult          : out std_logic_vector(31 downto 0));
end ALU;

architecture mixed of ALU is

    ---------------------------------------------------------------------------
    -- AddSub unit signals and components
    ---------------------------------------------------------------------------

    component add_sub_N is
        generic(N : integer := 32);
        port(i_A        : in std_logic_vector(N-1 downto 0);
             i_B        : in std_logic_vector(N-1 downto 0);
             nAdd_Sub   : in std_logic;
             o_SumDiff  : out std_logic_vector(N-1 downto 0);
             o_Overflow : out std_logic);
    end component;

    component mux2t1 is
        port(i_d0       : in std_logic;
             i_d1       : in std_logic;
             i_s        : in std_logic;
             o_o        : out std_logic);
    end component;
    
    component mux2t1_32b is 
        generic(N : integer := 32);
        port(i_s        : in std_logic;
             i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component;
 
    signal s_OF                 : std_logic;
    signal s_addSubResult       : std_logic_vector(31 downto 0);
    signal s_addSubSltResult    : std_logic_vector(31 downto 0);
    signal s_sltResult          : std_logic_vector(31 downto 0);

    ---------------------------------------------------------------------------
    -- Logic Signals
    ---------------------------------------------------------------------------

    signal s_ANDresult, 
           s_ORresult, 
           s_NOTresult, 
           s_XORresult, 
           s_NORresult, 
           s_LUIresult          : std_logic_vector(31 downto 0);
    signal s_luiImm16b          : std_logic_vector(15 downto 0);
    signal s_RQBresult          : std_logic_vector(31 downto 0);

    ---------------------------------------------------------------------------
    -- Shift Signals and Components
    ---------------------------------------------------------------------------
    
    component barrelShifter_32 is
        generic(L : integer := 2; M : integer := 5; N : integer := 32);
        port(
            i_shiftAmount   : in std_logic_vector(M-1 downto 0);    -- shift amount input
            i_shiftType     : in std_logic_vector(L-1 downto 0);    -- shift type input
            i_in            : in std_logic_vector(N-1 downto 0);    -- data input
            o_out           : out std_logic_vector(N-1 downto 0)    -- data output
        );
    end component;

    signal s_ShiftResult        : std_logic_vector(31 downto 0);
    
    ---------------------------------------------------------------------------
    -- Final Mux Unit Component
    ---------------------------------------------------------------------------
    
    component mux16t1_32 is
        generic(M   : integer := 4; N   : integer := 32);
        port(i_d0       : in std_logic_vector(N-1 downto 0);
             i_d1       : in std_logic_vector(N-1 downto 0);
             i_d2       : in std_logic_vector(N-1 downto 0);
             i_d3       : in std_logic_vector(N-1 downto 0);
             i_d4       : in std_logic_vector(N-1 downto 0);
             i_d5       : in std_logic_vector(N-1 downto 0);
             i_d6       : in std_logic_vector(N-1 downto 0);
             i_d7       : in std_logic_vector(N-1 downto 0);
             i_d8       : in std_logic_vector(N-1 downto 0);
             i_d9       : in std_logic_vector(N-1 downto 0);
             i_d10      : in std_logic_vector(N-1 downto 0);
             i_d11      : in std_logic_vector(N-1 downto 0);
             i_d12      : in std_logic_vector(N-1 downto 0);
             i_d13      : in std_logic_vector(N-1 downto 0);
             i_d14      : in std_logic_vector(N-1 downto 0);
             i_d15      : in std_logic_vector(N-1 downto 0);
             i_s        : in std_logic_vector(M-1 downto 0);
             o_o        : out std_logic_vector(N-1 downto 0));
    end component; 


begin

  ---------------------------------------------------------------------------
  -- ADD and SUBTRACT Unit
  ---------------------------------------------------------------------------

    g_Add_Sub_N: add_sub_N
        port MAP(i_A            => i_opA,
                 i_B            => i_opB,
                 nAdd_Sub       => i_nAdd_Sub,
                 o_SumDiff      => s_addSubResult,
                 o_Overflow     => s_OF);

    g_UnsignedSelect_Mux2t1: mux2t1
        port MAP(i_d0       => s_OF,
                 i_d1       => '0',
                 i_s        => i_unsignedSelect,
                 o_o        => o_Overflow);

    g_SetLessThanResult_Mux2t1: mux2t1_32b
        port MAP(i_s        => s_addSubResult(31),
                 i_d0       => x"00000000",
                 i_d1       => x"00000001",
                 o_o        => s_sltResult);

    g_SLTorALUres_Mux2t1: mux2t1_32b
        port MAP(i_s        => i_ALUslt,
                 i_d0       => s_addSubResult,
                 i_d1       => s_sltResult,
                 o_o        => s_addSubSltResult);
    
    with s_AddSubResult select
        o_ALUzero <= '1' when x"00000000",
                     '0' when others;
    
  ---------------------------------------------------------------------------
  -- Logical Bitwise Units
  ---------------------------------------------------------------------------

    s_ANDresult <= i_opA and i_opB;
    s_ORresult <= i_opA or i_opB;
    s_NOTresult <= (not i_opA);
    s_XORresult <= i_opA xor i_opB;
    s_NORresult <= i_opA nor i_opB;
    s_luiImm16b <= i_opB(15 downto 0);
    s_LUIresult <= s_luiImm16b & x"0000";
    s_RQBresult <= i_RQBimm & i_RQBimm & i_RQBimm & i_RQBimm;

  ---------------------------------------------------------------------------
  -- Shift Unit
  ---------------------------------------------------------------------------
    
  g_ShiftUnit_BarrelShifter: barrelShifter_32
        port MAP(i_shiftAmount      => i_shamt,
                 i_shiftType        => i_shiftType,
                 i_in               => i_opB,
                 o_out              => s_ShiftResult);

  ---------------------------------------------------------------------------
  -- Final Mux
  ---------------------------------------------------------------------------

    g_FinalALUMux: mux16t1_32
        port MAP(i_d0               => s_addSubSltResult, 
                 i_d1               => s_addSubSltResult,
                 i_d2               => s_ANDresult,
                 i_d3               => s_NORresult,
                 i_d4               => s_ORresult,
                 i_d5               => s_XORresult,
                 i_d6               => s_ShiftResult,
                 i_d7               => s_NOTresult,
                 i_d8               => s_LUIresult,
                 i_d9               => s_RQBresult,
                 i_d10              => x"00000000",
                 i_d11              => x"00000000",
                 i_d12              => x"00000000",
                 i_d13              => x"00000000",
                 i_d14              => x"00000000",
                 i_d15              => x"00000000",
                 i_s                => i_ALUop,
                 o_o                => o_ALUresult);

end mixed;
    
