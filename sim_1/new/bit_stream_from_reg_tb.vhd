library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity bit_stream_from_reg_tb is
end bit_stream_from_reg_tb;

architecture Behavioral of bit_stream_from_reg_tb is
    component bit_stream_from_reg
        port
        (
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            stream : out std_logic
        );
    end component bit_stream_from_reg;
    
    signal clk: std_logic := '0';
    signal rst, wr_en, stream: std_logic;    
    
begin

    UUT: bit_stream_from_reg
    port map
    (
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        stream => stream
    );
    
    process
    begin
        clk <= not clk;
        wait for 5ns;
    end process;
    
    process
    begin
        rst <= '1';
        wr_en <= '1';
        wait for 20ns;
        rst <= '0';        
        wait for 10ns;
        wr_en <= '0';
        wait;
    end process;

end Behavioral;
