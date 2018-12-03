library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity reg_file is
    port
    (
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        en      : in STD_LOGIC;
        wr_addr : in STD_LOGIC_VECTOR(1 downto 0);
        r_addr  : in STD_LOGIC_VECTOR(1 downto 0);
        wr_data : in STD_LOGIC_VECTOR(3 downto 0);
        r_data  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end reg_file;

architecture Behavioral of reg_file is
    
    component reg
    port
    (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en : in STD_LOGIC;
        din : in STD_LOGIC_VECTOR(3 downto 0);
        dout : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component reg;
    
    signal din_1, din_2, din_3, din_4: std_logic_vector(3 downto 0);
    signal dout_1, dout_2, dout_3, dout_4: std_logic_vector(3 downto 0);
    
begin
    reg_1: reg
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        din => din_1,
        dout => dout_1
    );
    
    reg_2: reg
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        din => din_2,
        dout => dout_2
    );
    
    reg_3: reg
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        din => din_3,
        dout => dout_3
    );
    
    reg_4: reg
    port map
    (
        clk => clk,
        rst => rst,
        en => en,
        din => din_4,
        dout => dout_4
    );
    
    process (clk, rst, en, wr_addr, wr_data)
    begin
        if (rst = '1') then
            din_1 <= "0001";
            din_2 <= "0010";
            din_3 <= "0011";
            din_4 <= "0100";
        elsif (rising_edge(clk)) then
            if (en = '1') then
                case wr_addr is
                    when "00" => 
                        din_1 <= wr_data;     
                    when "01" => 
                        din_2 <= wr_data;
                    when "10" =>
                        din_3 <= wr_data;
                    when others => 
                        din_4 <= wr_data;
                end case;
            end if;
        end if;
    end process;
    
    -- Output logic
    with r_addr select
        r_data <=   dout_1 when "00",
                    dout_2 when "01",
                    dout_3 when "10",
                    dout_4 when others;
end Behavioral;
