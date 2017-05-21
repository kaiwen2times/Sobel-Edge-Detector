-------------------------------------------------
-- File: threshold.vhd
-- Entity: threshold
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Threshold calculations
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity threshold is
    port(
        EdgeMax      : in std_logic_vector(10 downto 0);
        DirMax       : in std_logic_vector(2 downto 0);
        EdgePerp     : in std_logic_vector(10 downto 0);
        Edge_Present : out std_logic;
        Edge_Dir     : out std_logic_vector(2 downto 0);
        calc_status  : out std_logic
    );
end entity;

architecture behavioral of threshold is
begin
process(EdgeMax,DirMax,EdgePerp,) is
begin
	calc_status <= '0';
    -- Check if the maximum derivative is above the threshold
    if unsigned(EdgeMax) + unsigned(EdgePerp)/8 >= 80 then
        Edge_Present <= '1';
        Edge_Dir <= DirMax;
    else
        Edge_Present <= '0';
        Edge_Dir <= "000";
    end if;
    calc_status <= '1';
end process;
end behavioral;
