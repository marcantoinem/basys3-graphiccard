library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_top is end;

architecture sim of test_top is

signal clk: std_logic := '0';
signal Hsync: std_logic := '0';
signal Vsync: std_logic := '0';
signal vgaRed   : std_logic_vector(3 downto 0);
signal vgaBlue  : std_logic_vector(3 downto 0);
signal vgaGreen : std_logic_vector(3 downto 0);

component based_graphic_card is
    port(
        clk      : in std_logic;                        -- l'horloge de la carte à 100 MHz
        -- led      : out std_logic_vector(15 downto 0);    -- les 16 LED
        Hsync    : out std_logic;
        Vsync    : out std_logic;
        vgaRed   : out std_logic_vector(3 downto 0);
        vgaBlue  : out std_logic_vector(3 downto 0);
        vgaGreen : out std_logic_vector(3 downto 0)
    );
end component;

begin

    UUT: based_graphic_card port map(
        clk => clk,
        Hsync => Hsync,
        Vsync => Vsync,
        vgaRed => vgaRed,
        vgaGreen => vgaGreen,
        vgaBlue => vgaBlue
    );
    
    process begin
        clk <= not(clk);
        wait for 5 ns;
    end process;

end sim;