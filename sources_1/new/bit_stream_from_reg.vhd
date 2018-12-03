library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity bit_stream_from_reg is
    port
    (
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        stream : out STD_LOGIC
    );
end bit_stream_from_reg;

architecture Behavioral of bit_stream_from_reg is

    component reg_file
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
    end component reg_file;
    
    component mod_m_counter
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
    end component mod_m_counter;
    
    component shift_register
        port
        (
            clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            en      : in STD_LOGIC;
            count   : in STD_LOGIC_VECTOR(1 downto 0);
            din     : in STD_LOGIC_VECTOR(3 downto 0);
            dout    : out STD_LOGIC
        );
    end component shift_register;    
        
    signal wr_addr, r_addr: std_logic_vector(1 downto 0);
    signal wr_data, r_data: std_logic_vector(3 downto 0);
    signal count_4, count_4_2: std_logic_vector(1 downto 0);    
    signal max_tick_500ms: std_logic;
    signal max_tick_4: std_logic;
    
begin
    
    counter_500ms: mod_m_counter
        generic map
        (
            --M => 50000000,
            --N => 26
            M => 2,
            N => 1
        )
        port map
        (
            clk => clk,
            rst => rst,
            en => '1',
            count => open,
            max_tick => max_tick_500ms
        );
    
    counter_4: mod_m_counter
    generic map
    (
        M => 4,
        N => 2
    )
    port map
    (
        clk => clk,
        rst => rst,
        en => max_tick_500ms,
        count => count_4,
        max_tick => max_tick_4
    );

    counter_4_2: mod_m_counter
    generic map
    (
        M => 4,
        N => 2
    )
    port map
    (
        clk => clk,
        rst => rst,
        en => max_tick_4,
        count => count_4_2,
        max_tick => open
    );
        
    memory: reg_file
    port map
    (
        clk => clk,
        rst => rst,
        en => wr_en,
        wr_addr => wr_addr,
        r_addr => count_4_2,
        wr_data => wr_data,
        r_data => r_data
    );
    
    sreg: shift_register
    port map
    (
        clk => clk,
        rst => rst,
        en => '1',
        count => count_4,
        din => r_data,
        dout => stream
    );
end Behavioral;
