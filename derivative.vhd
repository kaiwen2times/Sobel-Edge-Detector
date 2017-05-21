-------------------------------------------------
-- File: derivative.vhd
-- Entity: derivative
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Four directions derivatives
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity derivative is
    port(
        nine_pix    : in  std_logic_vector(71 downto 0); -- 9 pixels
        mem_status  : in std_logic;
        Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE : out std_logic_vector(10 downto 0)
    );
end entity;

architecture behavioral of derivative is
   
begin
process(nine_pix) is
    variable pix1,pix2,pix3,pix4,pix5,pix6,pix7,pix8,pix9: integer :=0;
begin
    -- Put 9 pixels into the corresponding table
    pix1 := to_integer(unsigned(nine_pix(71 downto 64)));
    pix2 := to_integer(unsigned(nine_pix(63 downto 56)));
    pix3 := to_integer(unsigned(nine_pix(55 downto 48)));
    pix4 := to_integer(unsigned(nine_pix(47 downto 40)));
    pix5 := to_integer(unsigned(nine_pix(39 downto 32)));
    pix6 := to_integer(unsigned(nine_pix(31 downto 24)));
    pix7 := to_integer(unsigned(nine_pix(23 downto 16)));
    pix8 := to_integer(unsigned(nine_pix(15 downto 8)));
    pix9 := to_integer(unsigned(nine_pix(7 downto 0))); 
    
    -- Calculate the derivatives for NE/SW, N/S, E/W, NW/SE 
    Deriv_NE_SW <= std_logic_vector(to_signed(((pix2 + 2*pix3 + pix6) - (pix4 + 2*pix7 + pix8)),11));
    Deriv_N_S   <= std_logic_vector(to_signed(((pix1 + 2*pix2 + pix3) - (pix7 + 2*pix8 + pix9)),11));
    Deriv_E_W   <= std_logic_vector(to_signed(((pix3 + 2*pix6 + pix9) - (pix1 + 2*pix4 + pix7)),11));
    Deriv_NW_SE <= std_logic_vector(to_signed(((pix4 + 2*pix1 + pix2) - (pix8 + 2*pix9 + pix6)),11));

end process;  
end behavioral;
