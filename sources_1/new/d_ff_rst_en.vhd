library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity d_ff_rst_en is
    Port
    (
        clk  : in STD_LOGIC;
        rst  : in STD_LOGIC;
        en   : in STD_LOGIC;
        D    : in STD_LOGIC;
        Q    : out STD_LOGIC
    );
end d_ff_rst_en;

architecture Behavioral of d_ff_rst_en is

begin
    process (clk, rst, en, D)
    begin
        if (rst = '1') then
            Q <= '0';
        elsif (rising_edge(clk)) then
            if (en = '1') then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
