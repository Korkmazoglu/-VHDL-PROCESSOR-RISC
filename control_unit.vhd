library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
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
end control_unit;


architecture arch of control_unit is
type control_states is(FETCH_0, FETCH_1, FETCH_2, DECODE_3,--FETCH AND DECODE BEFORE EXECUTION
                       LDA_IMM_4, LDA_IMM_5, LDA_IMM_6, -- LOAD CONSTANT TO A
                       LDA_DIR_4,LDA_DIR_5,LDA_DIR_6,LDA_DIR_7,LDA_DIR_8, --LOAD_A
                       STA_DIR_4,STA_DIR_5,STA_DIR_6,STA_DIR_7, -- STORE
                       ADD_ABB_4,
                       BRA_4,BRA_5,BRA_6, -- SKIP
                       BEQ_4,BEQ_5,BEQ_6,BEQ_7-- SKIP IF
                       ); 
signal current_state: control_states;
signal next_state: control_states;        
--ALL COMMANDS.
   --Loads and Stores.
   constant LOAD_A_CNST     : std_logic_vector (7 downto 0) := x"86";
   constant LOAD_A          : std_logic_vector (7 downto 0) := x"87";
   constant LOAD_B_CNST     : std_logic_vector (7 downto 0) := x"88";
   constant LOAD_B          : std_logic_vector (7 downto 0) := x"89";
   constant SAVE_A          : std_logic_vector (7 downto 0) := x"96";
   constant SAVE_B          : std_logic_vector (7 downto 0) := x"97";
   --Data Manipulations / ALU.
   constant SUM_AB          : std_logic_vector (7 downto 0) := x"42";
   constant SUB_AB          : std_logic_vector (7 downto 0) := x"43";
   constant AND_AB          : std_logic_vector (7 downto 0) := x"44";
   constant OR_AB           : std_logic_vector (7 downto 0) := x"45";
   constant INC_A           : std_logic_vector (7 downto 0) := x"46";
   constant INC_B           : std_logic_vector (7 downto 0) := x"47";
   constant DEC_A           : std_logic_vector (7 downto 0) := x"48";
   constant DEC_B           : std_logic_vector (7 downto 0) := x"49";
   --Branch/JUMP
   constant SKIP            : std_logic_vector (7 downto 0) := x"20";
   constant SKIP_NEG        : std_logic_vector (7 downto 0) := x"21";
   constant SKIP_POZ        : std_logic_vector (7 downto 0) := x"22";
   constant SKIP_0          : std_logic_vector (7 downto 0) := x"23";
   constant SKIP_N0         : std_logic_vector (7 downto 0) := x"24";
   constant SKIP_OFLOW      : std_logic_vector (7 downto 0) := x"25";
   constant SKIP_NOFLOW     : std_logic_vector (7 downto 0) := x"26";
   constant SKIP_CARRY      : std_logic_vector (7 downto 0) := x"27";
   constant SKIP_NCARRY     : std_logic_vector (7 downto 0) := x"46";
--------------------------------------------------------------------------------------------------------------
begin
--Current State Logic
process(clock, reset)
    begin
        if(reset = '1') then
            current_state <= FETCH_0;
        else
            current_state <= next_state;
            end if;
                end process;
--Next State Logic
process(current_state,IR,CCR_result)
    begin
        case current_state is
            when  FETCH_0 =>
                next_state <= FETCH_1;
            when  FETCH_1 =>
                next_state <= FETCH_2;
            when  FETCH_2 =>
                next_state <= DECODE_3;
            when  DECODE_3 =>
                if(IR = LOAD_A_CNST) then
                    next_state <= LDA_IMM_4;
                elsif(IR = LOAD_A) then
                    next_state <= LDA_DIR_4;
                elsif(IR = SAVE_A) then
                    next_state <= STA_DIR_4;
                elsif(IR = SUM_AB) then
                    next_state <= ADD_ABB_4;
                elsif(IR = SKIP) then
                    next_state <= BRA_4;
                elsif(IR = SKIP_0) then
                    if(CCR_result(2) = '1') then
                         next_state <= BEQ_4;
                    else
                         next_state <= BEQ_7;
                            end if;
                else
                    next_state <= FETCH_0;
                        end if;
           -----------------------------------------
            when  LDA_IMM_4 =>
                    next_state <= LDA_IMM_5;
            when  LDA_IMM_5 =>
                    next_state <= LDA_IMM_6;
            when  LDA_IMM_6 =>
                    next_state <= FETCH_0;
          ------------------------------------------
            when  LDA_DIR_4 =>
                    next_state <= LDA_DIR_5;
            when  LDA_DIR_5 =>
                    next_state <= LDA_DIR_6;
            when  LDA_DIR_6 =>
                    next_state <= LDA_DIR_7;
            when  LDA_DIR_7 =>
                    next_state <= LDA_DIR_8;
            when  LDA_DIR_8 =>
                    next_state <= FETCH_0;
            when  STA_DIR_4 =>
                    next_state <= STA_DIR_5;
            ---------------------------------------
            when  STA_DIR_5 =>
                    next_state <= STA_DIR_6;
            when  STA_DIR_6 =>
                    next_state <= STA_DIR_7;
            when  STA_DIR_7 =>
                    next_state <= FETCH_0;
            ---------------------------------------
            when  ADD_ABB_4 =>
                    next_state <= FETCH_0;
           ----------------------------------------
            when  BRA_4 =>
                    next_state <= BRA_5;   
            when  BRA_5 =>
                    next_state <= BRA_6;
            when  BRA_6 =>
                    next_state <= FETCH_0;
            ----------------------------------------
            when  BEQ_4 =>
                    next_state <= BEQ_5;
            when  BEQ_5 =>
                    next_state <= BEQ_6;
            when  BEQ_6 =>
                    next_state <= FETCH_0;
            when  BEQ_7 =>
                    next_state <= FETCH_0;
            ----------------------------------------
            when others =>
                    next_state <= FETCH_0;
                end case;
                    end process;
 
 --Output Logic
    process(current_state)
        begin
        IR_LOAD <= '0';
        MAR_LOAD <= '0';
        PC_LOAD <= '0';
        A_LOAD <= '0';
        write_enable <='0';
        ALU_Sel <= (others =>'0');
        CCR_LOAD <= '0';
        BUS1_Sel <= (others =>'0');
        BUS2_Sel <= (others =>'0');
            case current_state is
            when  FETCH_0 =>
                BUS1_Sel <= "00"; --PC
                BUS2_Sel <= "01"; --BUS1
                MAR_LOAD <= '1';
            when  FETCH_1 =>
                PC_INC<='1';
            when  FETCH_2 =>
                BUS2_Sel <= "10";
                IR_LOAD <= '1';
            when  DECODE_3 =>
              -- State has already changed.
           -----------------------------------------
            when  LDA_IMM_4 =>
                BUS1_Sel <= "00"; --PC
                BUS2_Sel <= "01"; --BUS1
                MAR_LOAD <= '1';
            when  LDA_IMM_5 =>
                    PC_INC<='1';
            when  LDA_IMM_6 =>
                    BUS2_Sel <= "10";
                    A_LOAD <= '1'; 
          ------------------------------------------
            when  LDA_DIR_4 =>
                    BUS1_Sel <= "00"; --PC
                    BUS2_Sel <= "01"; --BUS1
                    MAR_LOAD <= '1';
            when  LDA_DIR_5 =>
                    PC_INC<='1';
            when  LDA_DIR_6 =>
                   BUS2_Sel <= "10"; --BUS1
                    MAR_LOAD <= '1';
            when  LDA_DIR_7 =>
                   -- waiting data
            when  LDA_DIR_8 =>
                    BUS2_Sel <= "10"; --BUS1
                    A_LOAD <= '1';
            ---------------------------------------
            when  STA_DIR_4 =>
                    BUS1_Sel <= "00"; --PC
                    BUS2_Sel <= "01"; --BUS1
                    MAR_LOAD <= '1';
            when  STA_DIR_5 =>
                    PC_INC<='1';
            when  STA_DIR_6 =>
                    BUS2_Sel <= "10"; --BUS1
                    MAR_LOAD <= '1';
            when  STA_DIR_7 =>
                    BUS1_Sel <="01";
                    write_enable <= '1';
            ---------------------------------------
            when  ADD_ABB_4 =>
                    BUS1_Sel <= "01"; -- A_reg
                    BUS2_Sel <= "00"; -- ALU result
                    ALU_Sel  <= "000"; -- adding command
                    A_LOAD   <= '1';
                    CCR_LOAD <= '1';
           ----------------------------------------
            when  BRA_4 =>
                    BUS1_Sel <= "00"; --PC
                    BUS2_Sel <= "01"; --BUS1
                    MAR_LOAD <= '1';   
            when  BRA_5 =>
                  -- waiting for data
            when  BRA_6 =>
                    BUS2_Sel <= "10";
                    PC_LOAD  <= '1';
            ----------------------------------------
            when  BEQ_4 =>
                    BUS1_Sel <= "00"; --PC
                    BUS2_Sel <= "01"; --BUS1
                    MAR_LOAD <= '1'; 
            when  BEQ_5 =>
                   --
            when  BEQ_6 =>
                    BUS2_Sel <= "10";
                    PC_LOAD  <= '1'; 
            when  BEQ_7 =>
                    PC_INC<='1';
            ----------------------------------------
            when others =>
                    IR_LOAD <= '0';
        MAR_LOAD <= '0';
        PC_LOAD <= '0';
        A_LOAD <= '0';
        write_enable <='0';
        ALU_Sel <= (others =>'0');
        CCR_LOAD <= '0';
        BUS1_Sel <= (others =>'0');
        BUS2_Sel <= (others =>'0');
                end case;
           end process;
                    end architecture;
                                
