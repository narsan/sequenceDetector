----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:14 08/24/2020 
-- Design Name: 
-- Module Name:    seqdetector - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seqdetector is
port(
clk : in std_logic;
rst : in std_logic;
input : in std_logic;
output : out std_logic
);
end seqdetector;

architecture Behavioral of seqdetector is
type state is (s0,s1,s2,s3,s3prim,s4,s4prim);
signal present_state,next_state : state;
begin
sync_process : process(clk,rst)
begin
if(rst = '1')then
present_state <= s0;
elsif( rising_edge(clk)) then
present_state <= next_state;
end if;
end process;
detect_process : process (present_state,input)
begin
 case (present_state)is
 when s0 =>
   if (input = '0')then
	next_state <= s1;
	else
	next_state <= s0;
	end if;
	
	when s1 =>
   if (input = '1')then
	next_state <= s2;
	else
	next_state <= s1;
	end if;
	
	when s2 =>
   if (input = '0')then
	next_state <= s3;
	else
	next_state <= s3prim;
	end if;
	
	when s3 =>
   if (input = '1')then
	next_state <= s4;
	else
	next_state <= s1;
	end if;
	
	when s3prim =>
   if (input = '0')then
	next_state <= s4prim;
	else
	next_state <= s2;
	end if;
	
	when s4 =>
   if (input = '1')then
	next_state <= s3prim;
	else
	next_state <= s3;
	end if;
	
	when s4prim =>
   if (input = '1')then
	next_state <= s2;
	else
	next_state <= s1;
	end if;
  end case;
end process;
  
process(present_state)
begin
 case present_state is
 when s0 =>
   output <= '0';
 when s1 =>
   output <= '0';
 when s2 =>
   output <= '0';
 when s3 =>
   output <= '0';
 when s3prim =>
   output <= '0';
 when s4 =>
   output <= '1';
 when s4prim =>
   output <= '1';
 end case;
end process; 
end Behavioral;

