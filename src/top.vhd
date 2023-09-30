library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity based_graphic_card is
    port(
        clk      : in std_logic;                        -- l'horloge de la carte à 100 MHz
        -- led      : out std_logic_vector(15 downto 0);    -- les 16 LED
        Hsync    : out std_logic;
        Vsync    : out std_logic;
        vgaRed   : out std_logic_vector(3 downto 0);
        vgaBlue  : out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0)
    );
end;

architecture arch of based_graphic_card is
    signal clk_div2: std_logic := '0';
    signal clk_div4: std_logic := '0';

    signal pxl_line: unsigned (11 downto 0) := to_unsigned(0, 12);
    signal pxl_row: unsigned (11 downto 0) := to_unsigned(0, 12);

    signal hsync_reg: std_logic := '0';
    signal vsync_reg: std_logic := '0';
    signal hsync_reg_q: std_logic := '0';
    signal vsync_reg_q: std_logic := '0';

    constant H_PW: integer := 96;
    constant H_FP: integer := 16;
    constant H_BP: integer := 16;
    constant H_WIDTH: integer := 640;
    constant H_TOTAL: integer := 800;

    constant V_PW: integer := 2;
    constant V_FP: integer := 10;
    constant V_BP: integer := 33;
    constant V_HEIGHT: integer := 480;
    constant V_TOTAL: integer := 525;
begin

divide_clk2: process(clk)
begin
    if rising_edge(clk) then
        clk_div2 <= not clk_div2;
    end if;
end process divide_clk2;

divide_clk4: process(clk_div2)
begin
    if rising_edge(clk_div2) then
        clk_div4 <= not clk_div4;
    end if;
end process divide_clk4;

horizontal_counter: process(clk_div4)
begin
    if rising_edge(clk_div4) then
        if pxl_row = H_TOTAL - 1 then
            pxl_row <= to_unsigned(0, pxl_row'length);
        else
            pxl_row <= pxl_row + 1;
        end if;
    end if;
end process;

vertical_counter: process(clk_div4)
begin
    if rising_edge(clk_div4) then
        if pxl_line = V_TOTAL - 1 and pxl_row = H_TOTAL - 1 then
            pxl_line <= to_unsigned(0, pxl_line'length);
        else
            pxl_line <= pxl_line + 1;
        end if;
    end if;
end process;

process (clk_div4)
begin
  if (rising_edge(clk_div4)) then
    hsync_reg <= '1' when (pxl_row >= (H_FP + H_WIDTH - 1)) and (pxl_row < (H_FP + H_WIDTH + H_PW - 1)) else '0';
  end if;
end process;

process (clk_div4)
begin
  if (rising_edge(clk_div4)) then
    vsync_reg <= '1' when (pxl_line >= (V_FP + V_HEIGHT - 1)) and (pxl_line < (V_FP + V_HEIGHT + V_PW - 1)) else '0';
  end if;
end process;

dflipflop: process(clk_div4) begin
    if rising_edge(clk_div4) then
        hsync_reg_q <= hsync_reg;
        vsync_reg_q <= vsync_reg;
    end if;
end process;

Hsync <= hsync_reg_q;
Vsync <= vsync_reg_q;
vgaBlue <= "0000";
vgaGreen <= "0000";
vgaRed <= "0000";
        
end arch;