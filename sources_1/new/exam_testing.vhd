----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2018 02:10:38 PM
-- Design Name: 
-- Module Name: exam_testing - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity exam_testing is
    Port ( input : in STD_LOGIC;
           output : out STD_LOGIC);
end exam_testing;

architecture Behavioral of exam_testing is

signal test: integer := 1;
begin

process
begin
    if test = 1 then
        output <= '1';
    else
        output <= '0';
    end if;
end process;

end Behavioral;
