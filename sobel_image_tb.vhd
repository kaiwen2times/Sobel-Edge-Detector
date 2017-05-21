-------------------------------------------------
-- File: memory.vhd
-- Entity: memory
-- Architecture: Behavioral
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Detects edges from the input image
-------------------------------------------------

library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity sobel_tb is
end entity;

architecture behav of sobel_tb is 

    component sobel_struct is
	port(
	  i_clock : in std_logic;
	  i_valid : in std_logic;
	  i_pixel : in std_logic_vector(7 downto 0);
	  i_reset : in std_logic;
	  o_edge : out std_logic;
	  o_dir : out std_logic_vector(2 downto 0);
	  o_valid : out std_logic;
	  o_mode : out std_logic_vector(1 downto 0)
	);
    end component;
    
	signal o_dir : std_logic_vector(2 downto 0);
    signal o_mode : std_logic_vector(1 downto 0);
    signal i_clock, i_valid, i_reset, o_edge, o_valid : std_logic := '0';
    signal i_pixel : std_logic_vector(7 downto 0) := "00000000";
    
    signal read_flag : std_logic := '0';
    signal sobel_flag : std_logic := '0';
    signal convo_flag : std_logic := '0';

    type image_matrix is array(0 to 255, 0 to 255) of integer; -- image
    type cache_matrix is array(0 to 253, 0 to 253) of integer; -- results

    signal image  : image_matrix := (others=>(others=>0));	--initialized to zeros
    signal cache : cache_matrix := (others=>(others=>0));	--initialized to zeros

	signal htime : time := 10 ns;
	signal ftime : time := 20 ns;

	begin

	uut: sobel_struct port map (
	  i_clock => i_clock,
	  i_valid => i_valid,
	  i_pixel => i_pixel,
	  i_reset => i_reset,
	  o_edge => o_edge,
	  o_dir => o_dir,
	  o_valid => o_valid,
	  o_mode => o_mode
	);

	--clock process
    process
    begin
        i_clock <= '0';
        wait for htime;
        i_clock <= '1';
        wait for htime;
    end process;

	--read process
	reading :
	process
		file file_pointer : text;
		variable value : integer;
		variable line_content : line;
		variable row : integer := 0;
	begin
		file_open(file_pointer,"/home/kxz6582/digicdesign/phase2/images/test2.txt",READ_MODE);
		while not endfile(file_pointer) loop
			readline (file_pointer,line_content);
			for column in 0 to 255 loop
				read(line_content, value);
				image(row, column) <= value;
			end loop;
			row := row + 1;
			if row > 255 then
				row := 255;
			end if;
		end loop;
		file_close(file_pointer);
		read_flag <= '1';
		wait;
	end process;
    
	-- convolution process
    process
    begin
		wait until read_flag = '1';
		wait until i_clock = '0';
		-- convolution table  
        for i in 1 to 254 loop
            for j in 1 to 254 loop
                for m in 0 to 2 loop
                    for n in 0 to 2 loop
                        i_pixel <= std_logic_vector(to_unsigned(image(i+m-1, j+n-1),8));
                        i_valid <= '1';
                        wait for ftime;
                        i_valid <= '0';
                        wait for ftime;                           
                    end loop;                
                end loop;
                wait until o_valid = '1';
				if o_edge = '1' then
                	cache(i-1, j-1) <= 255;
		        end if;
                wait for ftime;
                i_reset <= '1';
                wait for ftime;
                i_reset <= '0';
                wait for ftime;                        
            end loop;        
        end loop;
        sobel_flag <= '1';
    end process;


	--write process
    process
    file file_pointer : text;
	variable line_content : line;
    begin
        wait until sobel_flag = '1';
        file_open(file_pointer, "/home/kxz6582/digicdesign/phase2/images/sobel_test2.pgm", WRITE_MODE);
        write(line_content, string'("P2 254 254 255")); -- pgm file header
        writeline(file_pointer, line_content);
        for row in 0 to 253 loop
            for col in 0 to 253 loop
                write(line_content, cache(row, col));
                write(line_content, ' ');         
            end loop;
            writeline(file_pointer, line_content);     
        end loop;    
        file_close(file_pointer);
		wait;
    end process;
    
end behav;


