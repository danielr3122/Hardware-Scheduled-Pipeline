-------------------------------------------------------------------------
-- Daniel Rosenhamer
-------------------------------------------------------------------------
-- tb_pipeline.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the pipeline registers.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pipeline is 
    generic(gCLK_HPER   : time := 50 ns);
end tb_pipeline;

architecture behavior of tb_pipeline is
  
    component IF_ID_Register is
        generic(N   : integer := 32);
        port(i_CLK              : in std_logic;
             i_RST              : in std_logic;
             i_WE               : in std_logic;
             i_IF_Inst          : in std_logic_vector(N-1 downto 0);
             i_IF_PCNext        : in std_logic_vector(N-1 downto 0);
             o_ID_Inst          : out std_logic_vector(N-1 downto 0);
             o_ID_PCNext        : out std_logic_vector(N-1 downto 0));
    end component;

    component ID_EX_Register is
        port(i_CLK                  : in std_logic;
             i_RST                  : in std_logic;
             i_WE                   : in std_logic;
    
             i_ID_PCNext            : in std_logic_vector(31 downto 0);
             i_ID_Halt              : in std_logic;
             i_ID_DMemWr            : in std_logic;
             i_ID_Write_Data_Sel    : in std_logic_vector(1 downto 0);
             i_ID_ALUsrc            : in std_logic;
             i_ID_ShiftType         : in std_logic_vector(1 downto 0);
             i_ID_ALUop             : in std_logic_vector(3 downto 0);
             i_ID_ALUslt            : in std_logic;
             i_ID_nAdd_Sub          : in std_logic;
             i_ID_UnsignedSelect    : in std_logic;
             i_ID_RegWr             : in std_logic;
             i_ID_JumpInstr         : in std_logic;
             i_ID_RegDest           : in std_logic_vector(1 downto 0);
             i_ID_Inst              : in std_logic_vector(31 downto 0);
             i_ID_extendedImm       : in std_logic_vector(31 downto 0);
             i_ID_readData1         : in std_logic_vector(31 downto 0);
             i_ID_readData2         : in std_logic_vector(31 downto 0);
    
             o_EX_PCNext            : out std_logic_vector(31 downto 0);
             o_EX_Halt              : out std_logic;
             o_EX_DMemWr            : out std_logic;
             o_EX_Write_Data_Sel    : out std_logic_vector(1 downto 0);
             o_EX_RegWr             : out std_logic;
             o_EX_JumpInstr         : out std_logic;
             o_EX_readData1         : out std_logic_vector(31 downto 0);
             o_EX_readData2         : out std_logic_vector(31 downto 0);
             o_EX_extendedImm       : out std_logic_vector(31 downto 0);
             o_EX_ALUsrc            : out std_logic;
             o_EX_ShiftType         : out std_logic_vector(1 downto 0);
             o_EX_ALUop             : out std_logic_vector(3 downto 0);
             o_EX_ALUslt            : out std_logic;
             o_EX_nAdd_Sub          : out std_logic;
             o_EX_UnsignedSelect    : out std_logic;
             o_EX_RegDest           : out std_logic_vector(1 downto 0);
             o_EX_Inst              : out std_logic_vector(31 downto 0));
    end component;

    component EX_MEM_Register is
        port(i_CLK                  : in std_logic;
             i_RST                  : in std_logic;
             i_WE                   : in std_logic;
    
             i_EX_PCNext            : in std_logic_vector(31 downto 0);
             i_EX_Halt              : in std_logic;
             i_EX_DMemWr            : in std_logic;
             i_EX_Write_Data_Sel    : in std_logic_vector(1 downto 0);
             i_EX_RegWr             : in std_logic;
             i_EX_Ovfl              : in std_logic;
             i_EX_ALUout            : in std_logic_vector(31 downto 0);
             i_EX_OpDataB           : in std_logic_vector(31 downto 0);
             i_EX_RegDest           : in std_logic_vector(1 downto 0);
             i_EX_RegWrAddr         : in std_logic_vector(4 downto 0);
             i_EX_Inst              : in std_logic_vector(31 downto 0);
    
             o_MEM_PCNext           : out std_logic_vector(31 downto 0);
             o_MEM_Halt             : out std_logic;
             o_MEM_Write_Data_Sel   : out std_logic_vector(1 downto 0);
             o_MEM_RegWr            : out std_logic;
             o_MEM_Ovfl             : out std_logic;
             o_MEM_DMemWr           : out std_logic;
             o_MEM_DMemData         : out std_logic_vector(31 downto 0);
             o_MEM_ALUout           : out std_logic_vector(31 downto 0);
             o_MEM_RegDest          : out std_logic_vector(1 downto 0);
             o_MEM_RegWrAddr        : out std_logic_vector(4 downto 0);
             o_MEM_Inst             : out std_logic_vector(31 downto 0));
    end component;

    component MEM_WB_Register is
        generic(N   : integer := 32);
        port(i_CLK                  : in std_logic;
             i_RST                  : in std_logic;
             i_WE                   : in std_logic;
    
             i_MEM_PCNext           : in std_logic_vector(31 downto 0);
             i_MEM_Halt             : in std_logic;
             i_MEM_Write_Data_Sel   : in std_logic_vector(1 downto 0);
             i_MEM_RegWr            : in std_logic;
             i_MEM_Ovfl             : in std_logic;
             i_MEM_DMemOut          : in std_logic_vector(31 downto 0);
             i_MEM_ALUout           : in std_logic_vector(31 downto 0);
             i_MEM_RegDest          : in std_logic_vector(1 downto 0);
             i_MEM_RegWrAddr        : in std_logic_vector(4 downto 0);
             i_MEM_Inst             : in std_logic_vector(31 downto 0);
             
             o_WB_Halt              : out std_logic;
             o_WB_Ovfl              : out std_logic;
             o_WB_ALUout            : out std_logic_vector(31 downto 0);
             o_WB_Write_Data_Sel    : out std_logic_vector(1 downto 0);
             o_WB_DMemOut           : out std_logic_vector(31 downto 0);
             o_WB_PCNext            : out std_logic_vector(31 downto 0);
             o_WB_RegDest           : out std_logic_vector(1 downto 0);
             o_WB_RegWrAddr         : out std_logic_vector(4 downto 0);
             o_WB_Inst              : out std_logic_vector(31 downto 0);
             o_WB_RegWr             : out std_logic);
    end component;

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER  : time := gCLK_HPER * 2;

    signal iCLK : std_logic;

    -- IF/ID Signals

    signal si_IF_RST, si_IF_WE, si_IF_Stall, si_IF_Flush : std_logic;

    signal si_IF_Inst, si_IF_PCNext, so_ID_Inst, so_ID_PCNext : std_logic_vector(31 downto 0);

    -- ID/EX Signals

    signal si_ID_RST, si_ID_WE, si_ID_Stall, si_ID_Flush,
           si_ID_Halt, si_ID_DMemWr, si_ID_ALUsrc, si_ID_ALUslt,
           si_ID_nAdd_Sub, si_ID_UnsignedSel, si_ID_RegWr, si_ID_JumpInstr,
           so_EX_Halt, so_EX_DMemWr, so_EX_ALUsrc, so_EX_ALUslt,
           so_EX_nAdd_Sub, so_EX_UnsignedSel, so_EX_RegWr, so_EX_JumpInstr : std_logic;

    signal si_ID_PCNext, si_ID_Inst, si_ID_extImm, si_ID_readData1, si_ID_readData2,
           so_EX_PCNext, so_EX_readData1, so_EX_readData2, so_EX_extImm, so_EX_Inst : std_logic_vector(31 downto 0);

    signal si_ID_Write_Data_Sel, si_ID_ShiftType, si_ID_RegDest,
           so_EX_Write_Data_Sel, so_EX_ShiftType, so_EX_RegDest : std_logic_vector(1 downto 0);

    signal si_ID_ALUop, so_EX_ALUop : std_logic_vector(3 downto 0);

    -- EX/MEM Signals

    signal si_EX_RST, si_EX_WE, si_EX_Stall, si_EX_Flush,
           si_EX_Halt, si_EX_DMemWr, si_EX_RegWr, si_EX_Ovfl,
           so_MEM_Halt, so_MEM_RegWr, so_MEM_Ovfl, so_MEM_DMemWr : std_logic;

    signal si_EX_PCNext, si_EX_ALUout, si_EX_OpDataB, si_EX_Inst,
           so_MEM_PCNext, so_MEM_DMemData, so_MEM_ALUout, so_MEM_Inst : std_logic_vector(31 downto 0);

    signal si_EX_Write_Data_Sel, si_EX_RegDest, so_MEM_Write_Data_Sel, so_MEM_RegDest : std_logic_vector(1 downto 0);

    signal si_EX_RegWrAddr, so_MEM_RegWrAddr : std_logic_vector(4 downto 0);

    -- MEM/WB Signals
    
    signal si_MEM_RST, si_MEM_WE, si_MEM_Stall, si_MEM_Flush,
           si_MEM_Halt, si_MEM_RegWr, si_MEM_Ovfl, so_WB_Halt, 
           so_WB_Ovfl, so_WB_RegWr : std_logic;

    signal si_MEM_PCNext, si_MEM_DMemOut, si_MEM_ALUout, si_MEM_Inst,
           so_WB_ALUout, so_WB_DMemOut, so_WB_PCNext, so_WB_Inst : std_logic_vector(31 downto 0);

    signal si_MEM_Write_Data_Sel, si_MEM_RegDest, so_WB_Write_Data_Sel, so_WB_RegDest : std_logic_vector(1 downto 0);

    signal si_MEM_RegWrAddr, so_WB_RegWrAddr : std_logic_vector(4 downto 0);

begin

    DUT0: IF_ID_Register
        port map(i_CLK       => iCLK,
                 i_RST       => (si_IF_RST or si_IF_Flush),
                 i_WE        => (si_IF_WE or si_IF_Stall), 
                 i_IF_Inst   => si_IF_Inst,
                 i_IF_PCNext => si_IF_PCNext,
                 o_ID_Inst   => so_ID_Inst,
                 o_ID_PCNext => so_ID_PCNext);

    DUT1: ID_EX_Register
        port map(i_CLK               => iCLK,
                 i_RST               => (si_ID_RST or si_ID_Flush),
                 i_WE                => (si_ID_WE or si_ID_Stall),
                 i_ID_PCNext         => si_ID_PCNext,
                 i_ID_Halt           => si_ID_Halt,
                 i_ID_DMemWr         => si_ID_DMemWr,
                 i_ID_Write_Data_Sel => si_ID_Write_Data_Sel,
                 i_ID_ALUsrc         => si_ID_ALUsrc,
                 i_ID_ShiftType      => si_ID_ShiftType,
                 i_ID_ALUop          => si_ID_ALUop,
                 i_ID_ALUslt         => si_ID_ALUslt,
                 i_ID_nAdd_Sub       => si_ID_nAdd_Sub,
                 i_ID_UnsignedSelect => si_ID_UnsignedSel,
                 i_ID_RegWr          => si_ID_RegWr,
                 i_ID_JumpInstr      => si_ID_JumpInstr,
                 i_ID_RegDest        => si_ID_RegDest,
                 i_ID_Inst           => so_ID_Inst,
                 i_ID_extendedImm    => si_ID_extImm,
                 i_ID_readData1      => si_ID_readData1,
                 i_ID_readData2      => si_ID_readData2,
                 o_EX_PCNext         => so_ID_PCNext,
                 o_EX_Halt           => so_EX_Halt,
                 o_EX_DMemWr         => so_EX_DMemWr,
                 o_EX_Write_Data_Sel => so_EX_Write_Data_Sel,
                 o_EX_RegWr          => so_EX_RegWr,
                 o_EX_JumpInstr      => so_EX_JumpInstr,
                 o_EX_readData1      => so_EX_readData1,
                 o_EX_readData2      => so_EX_readData2,
                 o_EX_extendedImm    => so_EX_extImm,
                 o_EX_ALUsrc         => so_EX_ALUsrc,
                 o_EX_ShiftType      => so_EX_ShiftType,
                 o_EX_ALUop          => so_EX_ALUop,
                 o_EX_ALUslt         => so_EX_ALUslt,
                 o_EX_nAdd_Sub       => so_EX_nAdd_Sub,
                 o_EX_UnsignedSelect => so_EX_UnsignedSel,
                 o_EX_RegDest        => so_EX_RegDest,
                 o_EX_Inst           => so_EX_Inst);

        DUT2: EX_MEM_Register
            port map(i_CLK                => iCLK,
                     i_RST                => (si_EX_RST or si_EX_Flush),
                     i_WE                 => (si_EX_WE or si_EX_Stall),
                     i_EX_PCNext          => so_ID_PCNext,
                     i_EX_Halt            => so_EX_Halt,
                     i_EX_DMemWr          => so_EX_DMemWr,
                     i_EX_Write_Data_Sel  => so_EX_Write_Data_Sel,
                     i_EX_RegWr           => so_EX_RegWr,
                     i_EX_Ovfl            => si_EX_Ovfl,
                     i_EX_ALUout          => si_EX_ALUout,
                     i_EX_OpDataB         => si_EX_OpDataB,
                     i_EX_RegDest         => so_EX_RegDest,
                     i_EX_RegWrAddr       => si_EX_RegWrAddr,
                     i_EX_Inst            => so_EX_Inst,
                     o_MEM_PCNext         => so_MEM_PCNext,
                     o_MEM_Halt           => so_MEM_Halt,
                     o_MEM_Write_Data_Sel => so_MEM_Write_Data_Sel,
                     o_MEM_RegWr          => so_MEM_RegWr,
                     o_MEM_Ovfl           => so_MEM_Ovfl,
                     o_MEM_DMemWr         => so_MEM_DMemWr,
                     o_MEM_DMemData       => so_MEM_DMemData,
                     o_MEM_ALUout         => so_MEM_ALUout,
                     o_MEM_RegDest        => so_MEM_RegDest,
                     o_MEM_RegWrAddr      => so_MEM_RegWrAddr,
                     o_MEM_Inst           => so_MEM_Inst);

        DUT3: MEM_WB_Register
            port map(i_CLK                => iCLK,
                     i_RST                => (si_MEM_RST or si_MEM_Flush),
                     i_WE                 => (si_MEM_WE or si_MEM_Stall),
                     i_MEM_PCNext         => so_MEM_PCNext,
                     i_MEM_Halt           => so_MEM_Halt,
                     i_MEM_Write_Data_Sel => so_MEM_Write_Data_Sel,
                     i_MEM_RegWr          => so_MEM_RegWr,
                     i_MEM_Ovfl           => so_MEM_Ovfl,
                     i_MEM_DMemOut        => si_MEM_DMemOut,
                     i_MEM_ALUout         => so_MEM_ALUout,
                     i_MEM_RegDest        => so_MEM_RegDest,
                     i_MEM_RegWrAddr      => so_MEM_RegWrAddr,
                     i_MEM_Inst           => so_EX_Inst,
                     o_WB_Halt            => so_WB_Halt,
                     o_WB_Ovfl            => so_WB_Ovfl,
                     o_WB_ALUout          => so_WB_ALUout,
                     o_WB_Write_Data_Sel  => so_WB_Write_Data_Sel,
                     o_WB_DMemOut         => so_WB_DMemOut,
                     o_WB_PCNext          => so_WB_PCNext,
                     o_WB_RegDest         => so_WB_RegDest,
                     o_WB_RegWrAddr       => so_WB_RegWrAddr,
                     o_WB_Inst            => so_WB_Inst,
                     o_WB_RegWr           => so_WB_RegWr);

    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_Clock: process
    begin
        iCLK <= '0';
        wait for gCLK_HPER;
        iCLK <= '1';
        wait for gCLK_HPER;
    end process;   

    -- TestBench Process
    P_TB: process
    begin
        
        -- Reset Registers
        si_IF_RST <= '1';
        si_IF_WE <= '0';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '1';
        si_ID_WE <= '0';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '1';
        si_EX_WE <= '0';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '1';
        si_MEM_WE <= '0';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"00000000";
        wait for cCLK_PER;
        
        -- Write to Registers
        si_IF_RST <= '0';
        si_IF_WE <= '1';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '1';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '1';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '1';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"10101010";
        wait for cCLK_PER;
        
        -- No new value input, values continue through other registers
        si_IF_RST <= '0';
        si_IF_WE <= '0';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '1';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '1';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '1';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"10101010";
        wait for cCLK_PER;
        
        -- Write again to Registers
        si_IF_RST <= '0';
        si_IF_WE <= '1';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '1';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '1';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '1';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"01010101";
        wait for cCLK_PER;
        
        -- Write again to Registers
        si_IF_RST <= '0';
        si_IF_WE <= '1';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '1';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '1';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '1';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"01010101";

        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        
        -- After stalls, flush
        si_IF_RST <= '0';
        si_IF_WE <= '0';
        si_IF_Flush <= '1';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '0';
        si_ID_Flush <= '1';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '0';
        si_EX_Flush <= '1';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '0';
        si_MEM_Flush <= '1';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"11110000";
        wait for cCLK_PER;
        
        -- Write data in after flush
        si_IF_RST <= '0';
        si_IF_WE <= '1';
        si_IF_Flush <= '0';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '1';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '1';
        si_EX_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '1';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"00001111";

        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;

        si_IF_RST <= '0';
        si_IF_WE <= '0';
        si_IF_Flush <= '1';
        si_IF_Stall <= '0';

        si_ID_RST <= '0';
        si_ID_WE <= '0';
        si_ID_Flush <= '0';
        si_IF_Stall <= '0';
        
        si_EX_RST <= '0';
        si_EX_WE <= '0';
        si_EX_Flush <= '1';
        si_IF_Stall <= '0';
        
        si_MEM_RST <= '0';
        si_MEM_WE <= '0';
        si_MEM_Flush <= '0';
        si_IF_Stall <= '0';

        si_IF_Inst <= x"11111111";
        wait for cCLK_PER;

    wait;
    end process;

end behavior;