library IEEE;
library adk;
use adk.adk_components.all;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity sobel_tb is
end;

architecture bench of sobel_tb is

  component sobel_struct
     port (
        i_clock : IN std_logic ;
        i_valid : IN std_logic ;
        i_pixel : IN std_logic_vector (7 DOWNTO 0) ;
        i_reset : IN std_logic ;
        o_edge : OUT std_logic ;
        o_dir : OUT std_logic_vector (2 DOWNTO 0) ;
        o_valid : OUT std_logic ;
        o_mode : OUT std_logic_vector (1 DOWNTO 0)) ;
  end component;

  signal i_clock: std_logic;
  signal i_valid: std_logic;
  signal i_pixel: std_logic_vector (7 DOWNTO 0);
  signal i_reset: std_logic;
  signal o_edge: std_logic;
  signal o_dir: std_logic_vector (2 DOWNTO 0);
  signal o_valid: std_logic;
  signal o_mode: std_logic_vector (1 DOWNTO 0);

  -- clock period
  constant clk_period : time := 500 ns;
  constant t_between  : time := 12* clk_period;
begin

  uut: sobel_struct port map ( i_clock => i_clock,
                        i_valid => i_valid,
                        i_pixel => i_pixel,
                        i_reset => i_reset,
                        o_edge  => o_edge,
                        o_dir   => o_dir,
                        o_valid => o_valid,
                        o_mode  => o_mode );
  clk_process :process
  begin
     i_clock <= '1';
     wait for clk_period/2;
     i_clock <= '0';
     wait for clk_period/2;
  end process;
  stimulus: process
  begin
    
    -- Put initialisation code here
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
  
     --test case 2
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 3
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 4
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 5
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 6
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 7
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 8
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 9
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 10
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;

    -- test case 11
    wait for t_between;
    i_reset <= '1';
    wait for clk_period;
    i_reset <= '0';
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;   
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;  
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period; 
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(0,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;
    i_valid <= '1';i_pixel <= std_logic_vector(to_unsigned(255,8));wait for clk_period;i_valid <= '0';wait for clk_period;

   -- Put test bench stimulus code here
    wait;
  end process;
end;
