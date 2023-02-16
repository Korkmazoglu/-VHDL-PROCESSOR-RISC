library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_level is
    port(
            clock: in std_logic;
            reset: in std_logic;
            port_in_00: in std_logic_vector(7 downto 0);
            port_in_01: in std_logic_vector(7 downto 0);
            port_in_02: in std_logic_vector(7 downto 0);
            port_in_03: in std_logic_vector(7 downto 0);
            port_in_04: in std_logic_vector(7 downto 0);
            port_in_05: in std_logic_vector(7 downto 0);
            port_in_06: in std_logic_vector(7 downto 0);
            port_in_07: in std_logic_vector(7 downto 0);
            port_in_08: in std_logic_vector(7 downto 0);
            port_in_09: in std_logic_vector(7 downto 0);
            port_in_10: in std_logic_vector(7 downto 0);
            port_in_11: in std_logic_vector(7 downto 0);
            port_in_12: in std_logic_vector(7 downto 0);
            port_in_13: in std_logic_vector(7 downto 0);
            port_in_14: in std_logic_vector(7 downto 0);
            port_in_15: in std_logic_vector(7 downto 0);
            --Outputs
            data_out: out std_logic_vector(7 downto 0); 
            data_out_00: out std_logic_vector(7 downto 0);-- Means port_out as used.
            data_out_01: out std_logic_vector(7 downto 0);
            data_out_02: out std_logic_vector(7 downto 0);
            data_out_03: out std_logic_vector(7 downto 0);
            data_out_04: out std_logic_vector(7 downto 0);
            data_out_05: out std_logic_vector(7 downto 0);
            data_out_06: out std_logic_vector(7 downto 0);
            data_out_07: out std_logic_vector(7 downto 0);
            data_out_08: out std_logic_vector(7 downto 0);
            data_out_09: out std_logic_vector(7 downto 0);
            data_out_10: out std_logic_vector(7 downto 0);
            data_out_11: out std_logic_vector(7 downto 0);
            data_out_12: out std_logic_vector(7 downto 0);
            data_out_13: out std_logic_vector(7 downto 0);
            data_out_14: out std_logic_vector(7 downto 0);
            data_out_15: out std_logic_vector(7 downto 0)  
    );
    end top_level;
architecture arch of top_level is
 --CPU
    component cpu is
    port(
            clock       : in std_logic;
            reset       : in std_logic;
            from_memory : in std_logic_vector(7 downto 0);
            --outputs
            to_memory   : out std_logic_vector(7 downto 0);
            address     : out std_logic_vector(7 downto 0);
            write_enable: out std_logic
            );
end component;
 --Memory Blocks
    component memory is
    port(
            clock: in std_logic;
            reset: in std_logic;
            write_enable: in std_logic;
            address: in std_logic_vector(7 downto 0);
            data_in: in std_logic_vector(7 downto 0);
            port_in_00: in std_logic_vector(7 downto 0);
            port_in_01: in std_logic_vector(7 downto 0);
            port_in_02: in std_logic_vector(7 downto 0);
            port_in_03: in std_logic_vector(7 downto 0);
            port_in_04: in std_logic_vector(7 downto 0);
            port_in_05: in std_logic_vector(7 downto 0);
            port_in_06: in std_logic_vector(7 downto 0);
            port_in_07: in std_logic_vector(7 downto 0);
            port_in_08: in std_logic_vector(7 downto 0);
            port_in_09: in std_logic_vector(7 downto 0);
            port_in_10: in std_logic_vector(7 downto 0);
            port_in_11: in std_logic_vector(7 downto 0);
            port_in_12: in std_logic_vector(7 downto 0);
            port_in_13: in std_logic_vector(7 downto 0);
            port_in_14: in std_logic_vector(7 downto 0);
            port_in_15: in std_logic_vector(7 downto 0);
            --Outputs
            data_out   : out std_logic_vector(7 downto 0); 
            data_out_00: out std_logic_vector(7 downto 0);-- Means port_out as used.
            data_out_01: out std_logic_vector(7 downto 0);
            data_out_02: out std_logic_vector(7 downto 0);
            data_out_03: out std_logic_vector(7 downto 0);
            data_out_04: out std_logic_vector(7 downto 0);
            data_out_05: out std_logic_vector(7 downto 0);
            data_out_06: out std_logic_vector(7 downto 0);
            data_out_07: out std_logic_vector(7 downto 0);
            data_out_08: out std_logic_vector(7 downto 0);
            data_out_09: out std_logic_vector(7 downto 0);
            data_out_10: out std_logic_vector(7 downto 0);
            data_out_11: out std_logic_vector(7 downto 0);
            data_out_12: out std_logic_vector(7 downto 0);
            data_out_13: out std_logic_vector(7 downto 0);
            data_out_14: out std_logic_vector(7 downto 0);
            data_out_15: out std_logic_vector(7 downto 0)  
    );
 
 end component;
 --Signals
 signal write_enable: std_logic;
 signal address: std_logic_vector(7 downto 0);
 signal from_memory: std_logic_vector(7 downto 0);
 signal to_memory: std_logic_vector(7 downto 0);
 signal data_in: std_logic_vector(7 downto 0);
    
    begin
    --CPU PORT MAP
        cpu_t: cpu port map(
                           clock       =>clock,       
                           reset       =>reset,      
                           from_memory =>from_memory, 
                           --outputs   =>--outputs   
                           to_memory   =>to_memory,   
                           address     =>address,     
                           write_enable=>write_enable
        
        );
     --MEMORY PORTMAP 
            datapath_t: memory port map( 
            clock       => clock,      
            reset       => reset,      
            write_enable=> write_enable,
            address     => address,    
            data_in     => data_in,    
            port_in_00  => port_in_00, 
            port_in_01  => port_in_01, 
            port_in_02  => port_in_02,
            port_in_03  => port_in_03,
            port_in_04  => port_in_04, 
            port_in_05  => port_in_05, 
            port_in_06  => port_in_06, 
            port_in_07  => port_in_07, 
            port_in_08  => port_in_08, 
            port_in_09  => port_in_09, 
            port_in_10  => port_in_10, 
            port_in_11  => port_in_11, 
            port_in_12  => port_in_12, 
            port_in_13  => port_in_13, 
            port_in_14  => port_in_14, 
            port_in_15  => port_in_15, 
            data_out    => data_out,   
            data_out_00 => data_out_00,
            data_out_01 => data_out_01,
            data_out_02 => data_out_02,
            data_out_03 => data_out_03,
            data_out_04 => data_out_04,
            data_out_05 => data_out_05,
            data_out_06 => data_out_06,
            data_out_07 => data_out_07,
            data_out_08 => data_out_08,
            data_out_09 => data_out_09,
            data_out_10 => data_out_10,
            data_out_11 => data_out_11,
            data_out_12 => data_out_12,
            data_out_13 => data_out_13,
            data_out_14 => data_out_14,
            data_out_15 => data_out_15      
        );
        end architecture;
        
