-- File: state_machine.vhd
-- Entity: state_machine
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: state_machine
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 

entity state_machine is
    port(
        i_clock    : in std_logic;
        i_valid    : in std_logic;
        i_reset    : in std_logic;
        mem_status : in std_logic;
        calc_status: in std_logic;
        o_valid    : out std_logic;
        o_mode     : out std_logic_vector(1 downto 0)
    );
end entity;

architecture behavioral of state_machine is
type all_states is (waiting, reading, calculating, initial,reset);
  signal state: all_states := reset;
begin
    process(i_clock) is
    begin
        if rising_edge(i_clock) then
            if i_reset = '1' then
                state <= reset;
            else
                case state is
                when initial =>
                    if i_valid = '1' then state <= reading;
                    else state <= initial; end if;
                when reading =>
                    if mem_status = '1' then state <= calculating;
                    else state <= reading; end if;
                when calculating =>  
                    if calc_status = '1' then state <= waiting;
                    else state <= calculating; end if; 
                when waiting =>
                    if i_valid = '1' then state <= reading;
                    else state <= waiting; end if;
                when reset =>
                    state <= waiting;
                end case;   
            end if;  
        end if;   
    end process;
    
    process(i_clock) is
    begin
        if rising_edge(i_clock) then
            case state is
          when initial =>
              o_valid <= '0';
              o_mode <= "10";
          when reading =>
              o_valid <= '0';
              o_mode <= "11";
          when calculating =>
              o_valid <= '0';
              o_mode <= "11";
          when waiting =>
              o_valid <= '1';
              o_mode <= "10";
          when reset =>
              o_valid <= '0';
              o_mode <= "01";
          end case;
        end if;
        end process;
end behavioral;
