library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    port(
            clock   : in std_logic;
            reset   : in std_logic;
            IR_LOAD : in std_logic; --control bit for IR.
            MAR_LOAD: in std_logic;
            PC_LOAD : in std_logic;
            PC_INC  : in std_logic; 
            A_LOAD  : in std_logic;
            B_LOAD  : in std_logic;
            ALU_Sel : in std_logic_vector(2 downto 0);
            CCR_LOAD: in std_logic;
            BUS1_Sel: in std_logic_vector(1 downto 0);
            BUS2_Sel: in std_logic_vector(1 downto 0);
            from_memory: in std_logic_vector(7 downto 0); -- data from the memory block.
            --Outputs
            IR: out std_logic_vector(7 downto 0);
            address: out std_logic_vector(7 downto 0);
            CCR_result: out std_logic_vector(3 downto 0); -- NZVC
            to_memory: out std_logic_vector(7 downto 0) -- data going to memory block
            );
end datapath;

architecture arch of datapath is 
    component ALU is
        port(
            A         : in std_logic_vector(7 downto 0);
            B         : in std_logic_vector(7 downto 0);
            ALU_Sel   : in std_logic_vector(2 downto 0);
            --Outputs
            NZVC      : out std_logic_vector(3 downto 0);
            ALU_result: out std_logic_vector(7 downto 0)
    );
end component;
    signal BUS1      : std_logic_vector(7 downto 0);
    signal BUS2      : std_logic_vector(7 downto 0);
    signal ALU_result: std_logic_vector(7 downto 0);
    signal IR_reg    : std_logic_vector(7 downto 0);
    signal MAR       : std_logic_vector(7 downto 0);
    signal PC        : std_logic_vector(7 downto 0);
    signal A_reg     : std_logic_vector(7 downto 0);
    signal B_reg     : std_logic_vector(7 downto 0);
    signal CCR_in    : std_logic_vector(3 downto 0);
    signal CCR       : std_logic_vector(3 downto 0);
begin
    --BUS1
        BUS1 <= PC when BUS1_Sel = "000" else
                A_reg  when BUS1_Sel = "001" else
                B_reg  when BUS1_Sel = "010" ;
    --BUS2   
        BUS2 <= ALU_result  when BUS2_Sel = "000" else
                BUS1        when BUS2_Sel = "001" else
                from_memory when BUS2_Sel = "010" ;
                
--IR
process(clock, reset)
begin
    if(reset = '1') then
        IR_reg <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(IR_LOAD = '1') then
                IR_reg <= BUS2;
            else
            IR_reg <= (others =>'0');  
           
                end if;
        end if;
    end if;
end process;   
     
--MAR
process(clock, reset)
begin
    if(reset = '1') then
        MAR <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(MAR_LOAD = '1') then
                MAR <= BUS2;
            else
                MAR <= (others =>'0');  
           
                end if;
        end if;
    end if;
end process;

address <= MAR; -- signal to real

--PC
process(clock, reset)
begin
    if(reset = '1') then
        PC <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(PC_LOAD = '1') then
                PC <= BUS2;
            elsif(PC_INC='1') then
                PC <= PC + x"01";
                end if;
        end if;
    end if;
end process;

--A REG
process(clock, reset)
begin
    if(reset = '1') then
        A_reg <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(A_LOAD = '1') then
                A_reg <= BUS2;
            else
            A_reg <= (others =>'0');  
           
                end if;
        end if;
    end if;
end process;   

--B REG
process(clock, reset)
begin
    if(reset = '1') then
        B_reg <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(B_LOAD = '1') then
                B_reg <= BUS2;
            else
            B_reg <= (others =>'0');  
           
                end if;
        end if;
    end if;
end process;         

--ALU 
ALU_T : ALU port map ( A => A_reg, B => B_reg, ALU_result => ALU_result, NZVC => CCR_in, ALU_Sel => ALU_Sel);  

--CCR
process(clock, reset)
begin
    if(reset = '1') then
        CCR <= (others =>'0');
    else
        if(rising_edge(clock)) then
            if(CCR_LOAD = '1') then
                CCR <= CCR_in;
            else
            CCR <= (others =>'0');  
           
                end if;
        end if;
    end if;
end process;
CCR_result <= CCR;
to_memory <= BUS1;
end architecture;

