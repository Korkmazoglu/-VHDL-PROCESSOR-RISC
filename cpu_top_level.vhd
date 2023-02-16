library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cpu is
    port(
            clock       : in std_logic;
            reset       : in std_logic;
            from_memory : in std_logic_vector(7 downto 0);
            --outputs
            to_memory   : out std_logic_vector(7 downto 0);
            address     : out std_logic_vector(7 downto 0);
            write_enable: out std_logic
            );
end cpu;

architecture arch of cpu is
    --Control Unit
        component control_unit is
    port(
            clock        : in std_logic;
            reset        : in std_logic;
            CCR_result   : in std_logic_vector(3 downto 0);
            IR           : in std_logic_vector( 7 downto 0);
            --Outputs
            IR_LOAD      : out std_logic; --control bit for IR.
            MAR_LOAD     : out std_logic;
            PC_LOAD      : out std_logic;
            PC_INC       : out std_logic; 
            A_LOAD       : out std_logic;
            B_LOAD       : out std_logic;
            ALU_Sel      : out std_logic_vector(2 downto 0);
            CCR_LOAD     : out std_logic;
            BUS1_Sel     : out std_logic_vector(1 downto 0);
            BUS2_Sel     : out std_logic_vector(1 downto 0);
            write_enable : out std_logic
    );
end component;
    --Datapath  
        component datapath is
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
end component;

--Signals

signal IR_LOAD      :  std_logic; --control bit for IR.
signal MAR_LOAD     :  std_logic;                      
signal PC_LOAD      :  std_logic;                      
signal PC_INC       :  std_logic;                      
signal A_LOAD       :  std_logic;                      
signal B_LOAD       :  std_logic;                      
signal ALU_Sel      :  std_logic_vector(2 downto 0);   
signal CCR_LOAD     :  std_logic;                      
signal BUS1_Sel     :  std_logic_vector(1 downto 0);   
signal BUS2_Sel     :  std_logic_vector(1 downto 0);   
signal IR           :  std_logic_vector(7 downto 0);
signal CCR_result   :  std_logic_vector(3 downto 0); -- NZVC

----------------------------------------------------------------------------------------
begin
    control_unit_t: control_unit port map(
            clock        =>  clock,
            reset        =>  reset,
            CCR_result   =>  CCR_result,  
            IR           =>  IR,                       
            IR_LOAD      =>  IR_LOAD,      
            MAR_LOAD     =>  MAR_LOAD,    
            PC_LOAD      =>  PC_LOAD,      
            PC_INC       =>  PC_INC,       
            A_LOAD       =>  A_LOAD,       
            B_LOAD       =>  B_LOAD,       
            ALU_Sel      =>  ALU_Sel,      
            CCR_LOAD     =>  CCR_LOAD,     
            BUS1_Sel     =>  BUS1_Sel,    
            BUS2_Sel     =>  BUS2_Sel,     
            write_enable =>  write_enable  
    ); 
    datapath_t: datapath port map(
            clock        => clock,      
            reset        => reset,     
            IR_LOAD      => IR_LOAD,    
            MAR_LOAD     => MAR_LOAD,   
            PC_LOAD      => PC_LOAD,    
            PC_INC       => PC_INC,     
            A_LOAD       => A_LOAD,     
            B_LOAD       => B_LOAD,     
            ALU_Sel      => ALU_Sel,    
            CCR_LOAD     => CCR_LOAD,   
            BUS1_Sel     => BUS1_Sel,   
            BUS2_Sel     => BUS2_Sel,   
            from_memory  => from_memory,  
            IR           => IR,         
            address      => address,    
            CCR_result   => CCR_result, 
            to_memory    => to_memory
    );
        end architecture;
         
