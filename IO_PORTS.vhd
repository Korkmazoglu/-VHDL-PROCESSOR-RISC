library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IO_ports is
    port(
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
        address: in std_logic_vector(7 downto 0);
        data_in: in std_logic_vector(7 downto 0);
        data_out_00: out std_logic_vector(7 downto 0);
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
end IO_ports;
architecture arch of IO_ports is 
begin
--
process(clock,reset)
begin
   if(reset = '1') then
    data_out_00<=(others=>'0');
    data_out_01<=(others=>'0');
    data_out_02<=(others=>'0');
    data_out_03<=(others=>'0');
    data_out_04<=(others=>'0');
    data_out_05<=(others=>'0');
    data_out_06<=(others=>'0');
    data_out_07<=(others=>'0');
    data_out_08<=(others=>'0');
    data_out_09<=(others=>'0');
    data_out_10<=(others=>'0');
    data_out_11<=(others=>'0');
    data_out_12<=(others=>'0');
    data_out_13<=(others=>'0');
    data_out_14<=(others=>'0');
    data_out_15<=(others=>'0');
   
  elsif(rising_edge(clock)) then
        if(write_enable='1') then
            case address is
                when x"E0" =>
                    data_out_00 <= data_in;
                when x"E1" =>
                    data_out_01 <= data_in;
                when x"E2" =>
                    data_out_02 <= data_in;
                when x"E3" =>
                    data_out_03 <= data_in;        
                when x"E4" =>
                    data_out_04 <= data_in; 
                when x"E5" =>
                    data_out_05 <= data_in;
                when x"E6" =>
                    data_out_06 <= data_in;
                when x"E7" =>
                    data_out_07 <= data_in;
                when x"E8" =>
                    data_out_08 <= data_in;
                when x"E9" =>
                    data_out_09 <= data_in;
                when x"EA" =>
                    data_out_10 <= data_in;
                when x"EB" =>
                    data_out_11 <= data_in;
                when x"EC" =>
                    data_out_12 <= data_in;    
                when x"ED" =>
                    data_out_13 <= data_in;  
                when x"EE" =>
                    data_out_14 <= data_in;
                when x"EF" =>
                    data_out_15 <= data_in;
               when others =>
                    data_out_00<=(others=>'0');
                            data_out_01<=(others=>'0');
                            data_out_02<=(others=>'0');
                            data_out_03<=(others=>'0');
                            data_out_04<=(others=>'0');
                            data_out_05<=(others=>'0');
                            data_out_06<=(others=>'0');
                            data_out_07<=(others=>'0');
                            data_out_08<=(others=>'0');
                            data_out_09<=(others=>'0');
                            data_out_10<=(others=>'0');
                            data_out_11<=(others=>'0');
                            data_out_12<=(others=>'0');
                            data_out_13<=(others=>'0');
                            data_out_14<=(others=>'0');
                            data_out_15<=(others=>'0');
             end case;
                end if;
                    end if;
                        end process;
end architecture;


