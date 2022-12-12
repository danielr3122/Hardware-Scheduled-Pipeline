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

    -- Calculate the clock period as twice the half-period
    constant cCLK_PER  : time := gCLK_HPER * 2;
  
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
             i_EX_readData2         : in std_logic_vector(31 downto 0);
             i_EX_Ovfl              : in std_logic;
             i_EX_ALUout            : in std_logic_vector(31 downto 0);
             i_EX_RegWrAddr         : in std_logic_vector(4 downto 0);
    
             o_MEM_PCNext           : out std_logic_vector(31 downto 0);
             o_MEM_Halt             : out std_logic;
             o_MEM_DMemWr           : out std_logic;
             o_MEM_Write_Data_Sel   : out std_logic_vector(1 downto 0);
             o_MEM_RegWr            : out std_logic;
             o_MEM_DMemData         : out std_logic_vector(31 downto 0);
             o_MEM_Ovfl             : out std_logic;
             o_MEM_ALUout           : out std_logic_vector(31 downto 0);
             o_MEM_RegWrAddr        : out std_logic_vector(4 downto 0));
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
             i_MEM_ALUout           : in std_logic_vector(31 downto 0);
             i_MEM_DMemOut          : in std_logic_vector(31 downto 0);
             i_MEM_RegWrAddr        : in std_logic_vector(4 downto 0);
             
             o_WB_Halt              : out std_logic;
             o_WB_Ovfl              : out std_logic;
             o_WB_ALUout            : out std_logic_vector(31 downto 0);
             o_WB_Write_Data_Sel    : out std_logic_vector(1 downto 0);
             o_WB_DMemOut           : out std_logic_vector(31 downto 0);
             o_WB_PCNext            : out std_logic_vector(31 downto 0);
             o_WB_RegWrAddr         : out std_logic_vector(4 downto 0);
             o_WB_RegWr             : out std_logic);
    end component;

    signal iCLK : std_logic;

    -- Fetch Signals

    signal s_IF_RST, s_IF_WE, s_IF_Flush, s_IF_Stall : std_logic;

    signal s_IF_Inst, s_IF_PCNext, s_ID_Inst, s_ID_PCNext : std_logic_vector(31 downto 0);

    --Decode Signals

    signal s_ID_RST, s_ID_WE, s_ID_Flush, s_ID_Stall,
           s_ID_Halt, s_ID_DMemWr, s_ID_ALUsrc, s_ID_ALUslt, s_ID_nAdd_Sub,
           s_ID_UnsignedSel, s_ID_RegWr, s_EX_Halt, s_EX_DMemWr,
           s_EX_RegWr, s_EX_ALUsrc, s_EX_ALUslt, s_EX_nAdd_Sub, s_EX_UnsignedSel : std_logic;

    signal s_ID_Write_Data_Sel, s_ID_ShiftType, s_ID_RegDest,
           s_EX_Write_Data_Sel, s_EX_ShiftType, s_EX_RegDest : std_logic_vector(1 downto 0);

    signal s_EX_Inst, s_ID_extImm, s_ID_readData1, s_ID_readData2, s_EX_readData1, s_EX_readData2, s_EX_extImm, s_EX_PCNext, s_EX_ALUout : std_logic_vector(31 downto 0);

    signal s_ID_ALUop, s_EX_ALUop : std_logic_vector(3 downto 0);

    -- Execute Signals

    signal s_EX_RST, s_EX_WE, s_EX_Flush, s_EX_Stall : std_logic;

    signal s_EX_Ovfl, s_MEM_Ovfl, s_MEM_Halt, s_MEM_DMemWr, s_MEM_RegWr : std_logic;

    signal s_EX_RegWrAddr, s_MEM_RegWrAddr : std_logic_vector(4 downto 0);

    signal s_MEM_PCNext, s_MEM_DMemData, s_MEM_ALUout : std_logic_vector(31 downto 0);

    signal s_MEM_Write_Data_Sel : std_logic_vector(1 downto 0);

    -- Memory Signals

    signal s_MEM_RST, s_MEM_WE, s_MEM_Flush, s_MEM_Stall : std_logic;

    signal s_WB_Halt, s_WB_Ovfl, s_WB_RegWr : std_logic;

    signal s_WB_ALUout, s_WB_DMemOut, s_WB_PCNext, s_MEM_DMemOut : std_logic_vector(31 downto 0);

    signal s_WB_Write_Data_Sel : std_logic_vector(1 downto 0);

    signal s_WB_RegWrAddr : std_logic_vector(4 downto 0);



begin

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

    DUT0: IF_ID_Register
        port map(i_CLK       => iCLK,
                 i_RST       => (s_IF_RST or s_IF_Flush),
                 i_WE        => (s_IF_WE or s_IF_Stall), 
                 i_IF_Inst   => s_IF_Inst,
                 i_IF_PCNext => s_IF_PCNext,
                 o_ID_Inst   => s_ID_Inst,
                 o_ID_PCNext => s_ID_PCNext);

    DUT1: ID_EX_Register
        port map(i_CLK               => iCLK,
                 i_RST               => (s_ID_RST or s_ID_Flush),
                 i_WE                => (s_ID_WE or s_ID_Stall),
                 i_ID_PCNext         => s_ID_PCNext,
                 i_ID_Halt           => s_ID_Halt,
                 i_ID_DMemWr         => s_ID_DMemWr,
                 i_ID_Write_Data_Sel => s_ID_Write_Data_Sel,
                 i_ID_ALUsrc         => s_ID_ALUsrc,
                 i_ID_ShiftType      => s_ID_ShiftType,
                 i_ID_ALUop          => s_ID_ALUop,
                 i_ID_ALUslt         => s_ID_ALUslt,
                 i_ID_nAdd_Sub       => s_ID_nAdd_Sub,
                 i_ID_UnsignedSelect => s_ID_UnsignedSel,
                 i_ID_RegWr          => s_ID_RegWr,
                 i_ID_RegDest        => s_ID_RegDest,
                 i_ID_Inst           => s_ID_Inst,
                 i_ID_extendedImm    => s_ID_extImm,
                 i_ID_readData1      => s_ID_readData1,
                 i_ID_readData2      => s_ID_readData2,
                 o_EX_PCNext         => s_EX_PCNext,
                 o_EX_Halt           => s_EX_Halt,
                 o_EX_DMemWr         => s_EX_DMemWr,
                 o_EX_Write_Data_Sel => s_EX_Write_Data_Sel,
                 o_EX_RegWr          => s_EX_RegWr,
                 o_EX_readData1      => s_EX_readData1,
                 o_EX_readData2      => s_EX_readData2,
                 o_EX_extendedImm    => s_EX_extImm,
                 o_EX_ALUsrc         => s_EX_ALUsrc,
                 o_EX_ShiftType      => s_EX_ShiftType,
                 o_EX_ALUop          => s_EX_ALUop,
                 o_EX_ALUslt         => s_EX_ALUslt,
                 o_EX_nAdd_Sub       => s_EX_nAdd_Sub,
                 o_EX_UnsignedSelect => s_EX_UnsignedSel,
                 o_EX_RegDest        => s_EX_RegDest,
                 o_EX_Inst           => s_EX_Inst);

        DUT2: EX_MEM_Register
            port map(i_CLK                => iCLK,
                     i_RST                => (s_EX_RST or s_EX_Flush),
                     i_WE                 => (s_EX_WE or s_EX_Stall),
                     i_EX_PCNext          => s_EX_PCNext,
                     i_EX_Halt            => s_EX_Halt,
                     i_EX_DMemWr          => s_EX_DMemWr,
                     i_EX_Write_Data_Sel  => s_EX_Write_Data_Sel,
                     i_EX_RegWr           => s_EX_RegWr,
                     i_EX_readData2       => s_EX_readData2,
                     i_EX_Ovfl            => s_EX_Ovfl,
                     i_EX_ALUout          => s_EX_ALUout,
                     i_EX_RegWrAddr       => s_EX_RegWrAddr,
                     o_MEM_PCNext         => s_MEM_PCNext,
                     o_MEM_Halt           => s_MEM_Halt,
                     o_MEM_DMemWr         => s_MEM_DMemWr,
                     o_MEM_Write_Data_Sel => s_MEM_Write_Data_Sel,
                     o_MEM_RegWr          => s_MEM_RegWr,
                     o_MEM_DMemData       => s_MEM_DMemData,
                     o_MEM_Ovfl           => s_MEM_Ovfl,
                     o_MEM_ALUout         => s_MEM_ALUout,
                     o_MEM_RegWrAddr      => s_MEM_RegWrAddr);

        DUT3: MEM_WB_Register
            port map(i_CLK                => iCLK,
                     i_RST                => (s_MEM_RST or s_MEM_Flush),
                     i_WE                 => (s_MEM_WE or s_MEM_Stall),
                     i_MEM_PCNext         => s_MEM_PCNext,
                     i_MEM_Halt           => s_MEM_Halt,
                     i_MEM_Write_Data_Sel => s_MEM_Write_Data_Sel,
                     i_MEM_RegWr          => s_MEM_RegWr,
                     i_MEM_Ovfl           => s_MEM_Ovfl,
                     i_MEM_ALUout         => s_MEM_ALUout,
                     i_MEM_DMemOut        => s_MEM_DMemOut,
                     i_MEM_RegWrAddr      => s_MEM_RegWrAddr,
                               
                     o_WB_Halt            => s_WB_Halt,
                     o_WB_Ovfl            => s_WB_Ovfl,
                     o_WB_ALUout          => s_WB_ALUout,
                     o_WB_Write_Data_Sel  => s_WB_Write_Data_Sel,
                     o_WB_DMemOut         => s_WB_DMemOut,
                     o_WB_PCNext          => s_WB_PCNext,
                     o_WB_RegWrAddr       => s_WB_RegWrAddr,
                     o_WB_RegWr           => s_WB_RegWr);

    -- TestBench Process
    P_TB: process
    begin
        
        -- Reset Registers
        s_IF_RST <= '1';
        s_IF_WE <= '0';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '1';
        s_ID_WE <= '0';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
    
        s_EX_RST <= '1';
        s_EX_WE <= '0';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
    
        s_MEM_RST <= '1';
        s_MEM_WE <= '0';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"00000000";
        wait for cCLK_PER;
        
        -- Write to Registers
        s_IF_RST <= '0';
        s_IF_WE <= '1';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '1';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '1';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '1';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"10101010";
        wait for cCLK_PER;
        
        -- No new value input, values continue through other registers
        s_IF_RST <= '0';
        s_IF_WE <= '0';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '1';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '1';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '1';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"10101010";
        wait for cCLK_PER;
        
        -- Write again to Registers
        s_IF_RST <= '0';
        s_IF_WE <= '1';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '1';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '1';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '1';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"01010101";
        wait for cCLK_PER;
        
        -- Write again to Registers
        s_IF_RST <= '0';
        s_IF_WE <= '1';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '1';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '1';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '1';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"01010101";

        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        
        -- After stalls, flush
        s_IF_RST <= '0';
        s_IF_WE <= '0';
        s_IF_Flush <= '1';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '0';
        s_ID_Flush <= '1';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '0';
        s_EX_Flush <= '1';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '0';
        s_MEM_Flush <= '1';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"11110000";
        wait for cCLK_PER;
        
        -- Write data in after flush
        s_IF_RST <= '0';
        s_IF_WE <= '1';
        s_IF_Flush <= '0';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '1';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '1';
        s_EX_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '1';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"00001111";

        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;
        wait for cCLK_PER;

        s_IF_RST <= '0';
        s_IF_WE <= '0';
        s_IF_Flush <= '1';
        s_IF_Stall <= '0';

        s_ID_RST <= '0';
        s_ID_WE <= '0';
        s_ID_Flush <= '0';
        s_IF_Stall <= '0';
        
        s_EX_RST <= '0';
        s_EX_WE <= '0';
        s_EX_Flush <= '1';
        s_IF_Stall <= '0';
        
        s_MEM_RST <= '0';
        s_MEM_WE <= '0';
        s_MEM_Flush <= '0';
        s_IF_Stall <= '0';

        s_IF_Inst <= x"11111111";
        wait for cCLK_PER;

    wait;
    end process;

end behavior;