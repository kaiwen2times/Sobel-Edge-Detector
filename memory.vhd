-------------------------------------------------
-- File: memory.vhd
-- Entity: memory
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Storage of 9 8-bit pixels
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
        i_clock : in  std_logic;                    -- input clock
        i_valid : in  std_logic;                    -- is input valid?
        i_pixel : in  std_logic_vector(7 downto 0); -- 8-bit input
        i_reset : in  std_logic;                    -- reset signal
        mem_status: out std_logic;                  -- 1-when full
        nine_pix: out std_logic_vector(71 downto 0) -- 9 pixels
    );
end entity;

architecture behavioral of memory is
signal pixels_temp : std_logic_vector(71 downto 0):=X"000000000000000000";
signal PC : integer := 0; 
begin
    process(i_clock, i_reset)
    begin
        if i_reset = '1' then
            mem_status <= '0';
            PC <= 0;
            nine_pix <= X"000000000000000000";

        elsif rising_edge(i_clock) then
            if PC = 0 then 
                if i_valid = '1' then pixels_temp(71 downto 64) <= i_pixel; PC <= 1; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 0; end if;
            elsif PC = 1 then 
                if i_valid = '1' then pixels_temp(63 downto 56) <= i_pixel; PC <= 2; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 1; end if;
            elsif PC = 2 then
                if i_valid = '1' then pixels_temp(55 downto 48) <= i_pixel; PC <= 3; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 2; end if;
            elsif PC = 3 then
                if i_valid = '1' then pixels_temp(47 downto 40) <= i_pixel; PC <= 4; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 3; end if;
            elsif PC = 4 then
                if i_valid = '1' then pixels_temp(39 downto 32) <= i_pixel; PC <= 5; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 4; end if;
            elsif PC = 5 then
                if i_valid = '1' then pixels_temp(31 downto 24) <= i_pixel; PC <= 6; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 5; end if;
            elsif PC = 6 then
                if i_valid = '1' then pixels_temp(23 downto 16) <= i_pixel; PC <= 7; mem_status <= '0'; nine_pix <= X"000000000000000000";          
                else PC <= 6; end if;
            elsif PC = 7 then
                if i_valid = '1' then pixels_temp(15 downto 8) <= i_pixel;  PC <= 8; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 7; end if;
            elsif PC = 8 then
                if i_valid = '1' then pixels_temp(7 downto 0) <= i_pixel;  PC <= 9; mem_status <= '0'; nine_pix <= X"000000000000000000";
                else PC <= 8; end if;
            else 
                PC <= 0;
                mem_status <= '1';
                nine_pix <= pixels_temp;
            end if;          
        end if;
    end process;
end behavioral;
