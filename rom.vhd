library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity program_memory is 
        port (
                clock : in std_logic;
                address : in std_logic_vector(7 downto 0);
                data_out : out std_logic_vector(7 downto 0)
        );
end program_memory;
--128 bytes of ROM used
architecture arch of program_memory is
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
   
   type rom_type is array ( 0 to 127 ) of std_logic_vector( 7 downto 0 );
   -- for writing command area.
   constant ROM: rom_type :=(
                        0 => LOAD_A_CNST,
                        1 => x"7F",
                        2 => SAVE_A,
                        3 => x"20",
                        4 => SKIP,
                        5 => x"00",
                        others =>x"00" 
   ); 
   signal enable: std_logic;
   
   begin 
   --address check
   process(address) 
   begin
   if (address >= x"00" and address <= x"7F") then 
   enable <= '1'; 
   else
   enable <= '0';
   end if;   
   end process;
  --transfer 
   process(clock)
   begin
   if (rising_edge(clock)) then
            if(enable = '1') then
                data_out <= ROM(to_integer (unsigned(address)));
            end if;
   end if;
   end process;      
   end architecture;
