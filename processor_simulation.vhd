library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity processor_simulation is
--  Port ( );
end processor_simulation;

architecture Behavioral of processor_simulation is

component top_level is
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
    end component;
----------------------------------------------------------------
constant clock_period: time := 20 ns;
----------------------------------------------------------------
           signal clock     : std_logic;
           signal reset     : std_logic;
           signal port_in_00: std_logic_vector(7 downto 0);
           signal port_in_01: std_logic_vector(7 downto 0);
           signal port_in_02: std_logic_vector(7 downto 0);
           signal port_in_03: std_logic_vector(7 downto 0);
           signal port_in_04: std_logic_vector(7 downto 0);
           signal port_in_05: std_logic_vector(7 downto 0);
           signal port_in_06: std_logic_vector(7 downto 0);
           signal port_in_07: std_logic_vector(7 downto 0);
           signal port_in_08: std_logic_vector(7 downto 0);
           signal port_in_09: std_logic_vector(7 downto 0);
           signal port_in_10: std_logic_vector(7 downto 0);
           signal port_in_11: std_logic_vector(7 downto 0);
           signal port_in_12: std_logic_vector(7 downto 0);
           signal port_in_13: std_logic_vector(7 downto 0);
           signal port_in_14: std_logic_vector(7 downto 0);
           signal port_in_15: std_logic_vector(7 downto 0);
           --
           signal data_out   : std_logic_vector(7 downto 0); 
           signal data_out_00: std_logic_vector(7 downto 0);-- Means port_out as used.
           signal data_out_01: std_logic_vector(7 downto 0);
           signal data_out_02: std_logic_vector(7 downto 0);
           signal data_out_03: std_logic_vector(7 downto 0);
           signal data_out_04: std_logic_vector(7 downto 0);
           signal data_out_05: std_logic_vector(7 downto 0);
           signal data_out_06: std_logic_vector(7 downto 0);
           signal data_out_07: std_logic_vector(7 downto 0);
           signal data_out_08: std_logic_vector(7 downto 0);
           signal data_out_09: std_logic_vector(7 downto 0);
           signal data_out_10: std_logic_vector(7 downto 0);
           signal data_out_11: std_logic_vector(7 downto 0);
           signal data_out_12: std_logic_vector(7 downto 0);
           signal data_out_13: std_logic_vector(7 downto 0);
           signal data_out_14: std_logic_vector(7 downto 0);
           signal data_out_15: std_logic_vector(7 downto 0);
           
begin
clock_process: process
                    begin
                        clock <= '0';
                        wait for clock_period/2;
                        clock <= '1';
                        wait for clock_period/2;
                        end process;
                        
                        
uut: top_level port map(
                         clock              =>  clock      ,
                         reset              =>  reset      ,
                         port_in_00         =>  port_in_00 ,
                         port_in_01         =>  port_in_01 ,
                         port_in_02         =>  port_in_02 ,
                         port_in_03         =>  port_in_03 ,
                         port_in_04         =>  port_in_04 ,
                         port_in_05         =>  port_in_05 ,
                         port_in_06         =>  port_in_06 ,
                         port_in_07         =>  port_in_07 ,
                         port_in_08         =>  port_in_08 ,
                         port_in_09         =>  port_in_09 ,
                         port_in_10         =>  port_in_10 ,
                         port_in_11         =>  port_in_11 ,
                         port_in_12         =>  port_in_12 ,
                         port_in_13         =>  port_in_13 ,
                         port_in_14         =>  port_in_14 ,
                         port_in_15         =>  port_in_15 ,
                         --           
                         data_out        =>       data_out   ,
                         data_out_00     =>       data_out_00,
                         data_out_01     =>       data_out_01,
                         data_out_02     =>       data_out_02,
                         data_out_03     =>       data_out_03,
                         data_out_04     =>       data_out_04,
                         data_out_05     =>       data_out_05,
                         data_out_06     =>       data_out_06,
                         data_out_07     =>       data_out_07,
                         data_out_08     =>       data_out_08,
                         data_out_09     =>       data_out_09,
                         data_out_10     =>       data_out_10,
                         data_out_11     =>       data_out_11,
                         data_out_12     =>       data_out_12,
                         data_out_13     =>       data_out_13,
                         data_out_14     =>       data_out_14,
                         data_out_15     =>       data_out_15
                            );

process
    begin
        reset <= '1';
        wait for 40ns;
        reset <= '0';
        wait for clock_period*2;
        
        wait for clock_period*200;
        wait;
        end process;
            


end Behavioral;
