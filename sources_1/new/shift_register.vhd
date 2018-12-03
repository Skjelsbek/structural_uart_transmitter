library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity shift_register is
    port
    (
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        en      : in STD_LOGIC;
        count   : in STD_LOGIC_VECTOR(1 downto 0);
        din     : in STD_LOGIC_VECTOR(3 downto 0);
        dout    : out STD_LOGIC
    );
end shift_register;

architecture Behavioral of shift_register is
    
    signal reg, reg_next: std_logic_vector(3 downto 0);
    
begin
    -- Register
    process (clk, rst, en, din)
    begin
        if (rst = '1') then
            reg <= "0000";
        elsif (rising_edge(clk)) then
            if (en = '1') then
                reg <= reg_next;
            end if;
        end if;
    end process;
    
    -- Next state logic
    process (count, din, reg)
    begin
        case count is
            when "00" =>
                reg_next <= din(0) & reg(3 downto 1);
            when "01" =>
                reg_next <= din(1) & reg(3 downto 1);
            when "10" =>
                reg_next <= din(2) & reg(3 downto 1);
            when others =>
                reg_next <= din(3) & reg(3 downto 1);
        end case;
    end process;    
    
    -- Output logic
    dout <= reg(0);
end Behavioral;
