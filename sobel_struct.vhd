-------------------------------------------------
-- File: sobel_struct.vhd
-- Entity: sobel_struct
-- Architecture: Structural
-- Author: David Lor and Kaiwen Zheng
-- Created: 4/11/17
-- VHDL'93
-- Description: Sobel Edge Detection
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 
entity sobel_struct is
    port(
        i_clock : in  std_logic;                    -- input clock
        i_valid : in  std_logic;                    -- is input valid?
        i_pixel : in  std_logic_vector(7 downto 0); -- 8-bit input
        i_reset : in  std_logic;                    -- reset signal
        o_edge  : out std_logic;                    -- 1-bit output for edge
        o_dir   : out std_logic_vector(2 downto 0); -- 3-bit output for direction
        o_valid : out std_logic;                    -- is output valid?
        o_mode  : out std_logic_vector(1 downto 0)  -- 2-bit output for mode
    );
end entity;

architecture structural of sobel_struct is
component memory
    port(
        i_clock : in  std_logic;                    -- input clock
        i_valid : in  std_logic;                    -- is input valid?
        i_pixel : in  std_logic_vector(7 downto 0); -- 8-bit input
        i_reset : in  std_logic;                    -- reset signal
        mem_status: out std_logic;                  -- 1-when full
        nine_pix: out std_logic_vector(71 downto 0) -- 9 pixels
    );
end component;

component derivative
    port(
        nine_pix    : in  std_logic_vector(71 downto 0); -- 9 pixels
        mem_status  : in std_logic;
        Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE : out std_logic_vector(10 downto 0)
    );
end component;

component max_derivative
    port(
        Deriv_NE_SW, Deriv_N_S, Deriv_E_W, Deriv_NW_SE : in std_logic_vector(10 downto 0);
        EdgeMax : out std_logic_vector(10 downto 0);
        DirMax  : out std_logic_vector(2 downto 0);
        EdgePerp: out std_logic_vector(10 downto 0)
    );
end component;

component threshold
    port(
        EdgeMax      : in std_logic_vector(10 downto 0);
        DirMax       : in std_logic_vector(2 downto 0);
        EdgePerp     : in std_logic_vector(10 downto 0);
        Edge_Present : out std_logic;
        Edge_Dir     : out std_logic_vector(2 downto 0);
        calc_status  : out std_logic
    );
end component;

component state_machine
    port(
        i_clock    : in std_logic;
        i_valid    : in std_logic;
        i_reset    : in std_logic;
        mem_status : in std_logic;
        calc_status: in std_logic;
        o_valid    : out std_logic;
        o_mode     : out std_logic_vector(1 downto 0)
    );
end component;

signal nine_pix_internal : std_logic_vector(71 downto 0):=X"000000000000000000";
signal mem_status_internal: std_logic := '0';
signal calc_status_internal: std_logic := '0';
signal Deriv_NE_SW_internal, Deriv_N_S_internal, Deriv_E_W_internal, Deriv_NW_SE_internal :std_logic_vector(10 downto 0):="00000000000";
signal EdgeMax_internal,EdgePerp_internal : std_logic_vector(10 downto 0):="00000000000";
signal DirMax_internal:std_logic_vector(2 downto 0):= "000";
begin
    mem0 : memory port map(i_clock,i_valid,i_pixel,i_reset,mem_status_internal,nine_pix_internal);
    deriv0: derivative port map(nine_pix_internal,mem_status_internal,Deriv_NE_SW_internal, Deriv_N_S_internal, Deriv_E_W_internal, Deriv_NW_SE_internal);
    max_deriv0: max_derivative port map(Deriv_NE_SW_internal, Deriv_N_S_internal, Deriv_E_W_internal, Deriv_NW_SE_internal,EdgeMax_internal,DirMax_internal,EdgePerp_internal);
    thres0:threshold port map(EdgeMax_internal,DirMax_internal,EdgePerp_internal,o_edge,o_dir,calc_status_internal);
    sm0: state_machine port map(i_clock,i_valid,i_reset,mem_status_internal,calc_status_internal,o_valid,o_mode);
end structural;
