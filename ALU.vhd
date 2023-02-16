library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory is
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
 
 end memory;
 architecture arch of memory is
 --Program Memory(ROM).
    component program_memory is 
        port (
                clock    : in std_logic;
                address  : in std_logic_vector(7 downto 0);
                data_out : out std_logic_vector(7 downto 0)
        );

end component;   
--Data Memory(RAM).
    component data_memory is
    
    port(
        clock        : in std_logic;
        write_enable : in std_logic;
        address      : in std_logic_vector(7 downto 0);
        data_in      : in std_logic_vector(7 downto 0);
        data_out     : out std_logic_vector(7 downto 0)
    );

end component; 
--Input-Output Ports.
    component IO_ports is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        write_enable: in std_logic;
        address     : in std_logic_vector(7 downto 0);
        data_in     : in std_logic_vector(7 downto 0);
        data_out_00 : out std_logic_vector(7 downto 0);
        data_out_01 : out std_logic_vector(7 downto 0);
        data_out_02 : out std_logic_vector(7 downto 0);
        data_out_03 : out std_logic_vector(7 downto 0);
        data_out_04 : out std_logic_vector(7 downto 0);
        data_out_05 : out std_logic_vector(7 downto 0);
        data_out_06 : out std_logic_vector(7 downto 0);
        data_out_07 : out std_logic_vector(7 downto 0);
        data_out_08 : out std_logic_vector(7 downto 0);
        data_out_09 : out std_logic_vector(7 downto 0);
        data_out_10 : out std_logic_vector(7 downto 0);
        data_out_11 : out std_logic_vector(7 downto 0);
        data_out_12 : out std_logic_vector(7 downto 0);
        data_out_13 : out std_logic_vector(7 downto 0);
        data_out_14 : out std_logic_vector(7 downto 0);
        data_out_15 : out std_logic_vector(7 downto 0)   
    );

end component;
--ALU Signals.
signal rom_sig: std_logic_vector(7 downto 0);--used for data_out for rom.
signal ram_sig: std_logic_vector(7 downto 0);--used for data_out for ram.
begin
--ROM Signals
ROM_T: program_memory port map(
                                clock    => clock,
                                address  => address,
                                data_out => rom_sig

);
--RAM Signals.
RAM_T: data_memory port map(
                                clock => clock,       
                                write_enable => write_enable,
                                address => address,    
                                data_in => data_in,    
                                data_out => ram_sig         

);
--Input Output Ports Signals.
IO_T: IO_ports port map(
                                clock       =>clock,       
                                reset       =>reset,       
                                write_enable=>write_enable,
                                address     =>address,     
                                data_in     =>data_in,     
                                data_out_00 =>data_out_00, 
                                data_out_01 =>data_out_01, 
                                data_out_02 =>data_out_02, 
                                data_out_03 =>data_out_03, 
                                data_out_04 =>data_out_04, 
                                data_out_05 =>data_out_05, 
                                data_out_06 =>data_out_06, 
                                data_out_07 =>data_out_07, 
                                data_out_08 =>data_out_08, 
                                data_out_09 =>data_out_09, 
                                data_out_10 =>data_out_10,
                                data_out_11 =>data_out_11, 
                                data_out_12 =>data_out_12, 
                                data_out_13 =>data_out_13, 
                                data_out_14 =>data_out_14, 
                                data_out_15 =>data_out_15 
                                
);
--MUX Defined.
process(
 port_in_00, --ALL Inputs for MUX
 port_in_01,
 port_in_02,
 port_in_03,
 port_in_04,
 port_in_05,
 port_in_06,
 port_in_07,
 port_in_08,
 port_in_09,
 port_in_10,
 port_in_11,
 port_in_12,
 port_in_13,
 port_in_14,
 port_in_15,
 rom_sig,
 ram_sig,
 address
 )
    begin
        if(address>=x"00" and address <=x"7F") then
            data_out <= rom_sig;
        elsif(address>=x"80" and address <=x"DF") then
            data_out <= ram_sig;    
        elsif(address = x"F0") then -- FOR INPUTS!
            data_out <= port_in_00;
        elsif(address = x"F1") then
            data_out <= port_in_01;
        elsif(address = x"F2") then
            data_out <= port_in_02;
        elsif(address = x"F3") then
            data_out <= port_in_03;
        elsif(address = x"F4") then
            data_out <= port_in_04;
        elsif(address = x"F5") then
            data_out <= port_in_05;
        elsif(address = x"F6") then
            data_out <= port_in_06;
        elsif(address = x"F7") then
            data_out <= port_in_07;
        elsif(address = x"F8") then
            data_out <= port_in_08;
        elsif(address = x"F9") then
            data_out <= port_in_09;
        elsif(address = x"FA") then
            data_out <= port_in_10;
        elsif(address = x"FB") then
            data_out <= port_in_11;
        elsif(address = x"FC") then
            data_out <= port_in_12;
        elsif(address = x"FD") then
            data_out <= port_in_13;
        elsif(address = x"FE") then
            data_out <= port_in_14;
        elsif(address = x"FF") then
            data_out <= port_in_15;
        end if;
            end process;
                end architecture;
                
