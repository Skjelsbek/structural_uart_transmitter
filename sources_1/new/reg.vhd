library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity reg is
    port
    (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en : in STD_LOGIC;
        din : in STD_LOGIC_VECTOR(3 downto 0);
        dout : out STD_LOGIC_VECTOR(3 downto 0)
    );
end reg;

architecture Behavioral of reg is

    component d_ff_rst_en
    Port
    (
        clk  : in STD_LOGIC;
        rst  : in STD_LOGIC;
        en   : in STD_LOGIC;
        D    : in STD_LOGIC;
        Q    : out STD_LOGIC
    );
    end component d_ff_rst_en;
    
begin
    d_ff_1: d_ff_rst_en
        port map
        (
            clk => clk,
            rst => rst,
            en => en,
            D => din(3),
            Q => dout(3)
        );
    
    d_ff_2: d_ff_rst_en
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        D => din(2),
        Q => dout(2)
    );
    
    d_ff_3: d_ff_rst_en
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        D => din(1),
        Q => dout(1)
    );
    
    d_ff_4: d_ff_rst_en
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        D => din(0),
        Q => dout(0)
    );  
end Behavioral;
