library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_m_counter is
    generic
    (
        M: integer := 4;
        N: integer := 2
    );
    port
    (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en : in STD_LOGIC;
        count : out STD_LOGIC_VECTOR (N - 1 downto 0);
        max_tick : out STD_LOGIC
    );
end mod_m_counter;

architecture Behavioral of mod_m_counter is
    
    signal state_reg, state_next: unsigned(N - 1 downto 0);
begin
    
    -- Register part
    process (clk, rst, en)
    begin
        if (rst = '1') then
            state_reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (en = '1') then
                state_reg <= state_next;
            end if;
        end if;
    end process;
    
    -- Next state logic
    state_next <=   (others => '0') when state_reg = M-1 else
                    state_reg + 1;                           
    
    -- Output logic
    count <= std_logic_vector(state_reg);
    
    max_tick <= '1' when state_reg = M-1 and en = '1' else
                '0';
end Behavioral;
