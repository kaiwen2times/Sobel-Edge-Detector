-------------------------------------------------
-- File: max_derivative_tweaked.vhd
-- Entity: max_derivative
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Calculates max derivative its direction, and the perpendicular derivative
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity max_derivative is
    port(
        Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE : in std_logic_vector(10 downto 0);
        EdgeMax : out std_logic_vector(10 downto 0);
        DirMax  : out std_logic_vector(2 downto 0);
        EdgePerp: out std_logic_vector(10 downto 0)
    );
end entity;

architecture behavioral of max_derivative is
  signal abs_Deriv_NE_SW, abs_Deriv_N_S, abs_Deriv_E_W, abs_Deriv_NW_SE : std_logic_vector(9 downto 0):= "0000000000";
  signal EdgeMax_temp, EdgeMax_temp1,EdgeMax_temp2 : std_logic_vector(9 downto 0):= "0000000000";
  signal DirMax_temp  : std_logic_vector(2 downto 0) := "000";
  signal Deriv_index  : std_logic_vector(1 downto 0) := "00";
  signal Deriv_index_temp1, Deriv_index_temp2 : std_logic_vector(1 downto 0) := "00";

begin

process(Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE) is
begin
    -- Calculate absolute values of derivatives
    abs_Deriv_NE_SW <= std_logic_vector(to_unsigned(abs(to_integer(signed(Deriv_NE_SW))),10));
    abs_Deriv_N_S   <= std_logic_vector(to_unsigned(abs(to_integer(signed(Deriv_N_S))),10));
    abs_Deriv_E_W   <= std_logic_vector(to_unsigned(abs(to_integer(signed(Deriv_E_W))),10));
    abs_Deriv_NW_SE <= std_logic_vector(to_unsigned(abs(to_integer(signed(Deriv_NW_SE))),10));
 end process;
  
process(abs_Deriv_NE_SW,abs_Deriv_N_S) is  
begin 
    -- Calculate: EdgeMax - Maximum of absolute values of four derivatives
    if (to_integer(unsigned(abs_Deriv_NE_SW)) > to_integer(unsigned(abs_Deriv_N_S))) then 
        EdgeMax_temp1 <= abs_Deriv_NE_SW;
        Deriv_index_temp1 <= "00";
    else
        EdgeMax_temp1 <= abs_Deriv_N_S;
        Deriv_index_temp1 <= "01";
    end if;
 end process;

process(abs_Deriv_E_W,abs_Deriv_NW_SE) is  
begin 
    if (to_integer(unsigned(abs_Deriv_E_W)) > to_integer(unsigned(abs_Deriv_NW_SE))) then 
        EdgeMax_temp2 <= abs_Deriv_E_W;
        Deriv_index_temp2 <= "10";
    else
        EdgeMax_temp2 <= abs_Deriv_NW_SE;
        Deriv_index_temp2 <= "11";
    end if;

 end process;

 process(EdgeMax_temp1, EdgeMax_temp2, Deriv_index_temp1, Deriv_index_temp2) is  
 begin 
    if (to_integer(unsigned(EdgeMax_temp1)) > to_integer(unsigned(EdgeMax_temp2))) then 
        EdgeMax_temp <= EdgeMax_temp1;
        Deriv_index <= Deriv_index_temp1;
    else
        EdgeMax_temp <= EdgeMax_temp2;
        Deriv_index <= Deriv_index_temp2;
    end if;
  end process;   
    
 process(EdgeMax_temp, Deriv_index, Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE, abs_Deriv_NE_SW,abs_Deriv_N_S,abs_Deriv_E_W,abs_Deriv_NW_SE) is
 begin
    -- Calculate: EdgePerp - Absolute value of derivative of direction perpendicular to DirMax
    --            DirMax - Direction of EdgeMax 
    if Deriv_index = "00" then
        if signed(Deriv_NE_SW) > "0" then DirMax <= "110"; else DirMax <= "111"; end if;
        EdgePerp <= "0"&abs_Deriv_NW_SE;   
    elsif Deriv_index = "01" then
        if signed(Deriv_N_S) > "0" then DirMax <= "010"; else DirMax <= "011"; end if;
        EdgePerp <= "0"&abs_Deriv_E_W;  
    elsif Deriv_index = "10" then
        if signed(Deriv_E_W) > "0" then DirMax <= "000"; else DirMax <= "001"; end if;
        EdgePerp <= "0"&abs_Deriv_N_S;    
    else
        if signed(Deriv_NW_SE) > "0" then DirMax <= "100"; else DirMax <= "101"; end if;
        EdgePerp <= "0"&abs_Deriv_NE_SW;
    end if;
 
    EdgeMax <= "0"&EdgeMax_temp; 
end process;
end behavioral;
