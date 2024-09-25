----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2024 01:07:39 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
--  Port ( );
    Port (SW0 : in STD_LOGIC; -- A's vote 0
          SW1 : in STD_LOGIC; -- A's vote 1
          SW2 : in STD_LOGIC; -- A's vote 2
          SW3 : in STD_LOGIC; -- B's vote 0
          SW4 : in STD_LOGIC; -- B's vote 1
          SW5 : in STD_LOGIC; -- B's vote 2
          SW6 : in STD_LOGIC;
          SW7 : in STD_LOGIC;

          LD0 : out STD_LOGIC; -- winner display bit 0
          LD1 : out STD_LOGIC; -- winner display bit 1
          LD2 : out STD_LOGIC;
          LD3 : out STD_LOGIC;
          LD4 : out STD_LOGIC;
          LD5 : out STD_LOGIC;
          LD6 : out STD_LOGIC;
          LD7 : out STD_LOGIC;

          JA1 : out STD_LOGIC;
          JA2 : out STD_LOGIC;
          JA3 : out STD_LOGIC);
end top;

architecture Behavioral of top is
    -- Signals for the scores and the winner
    signal scoresA : std_logic_vector(2 downto 0);
    signal scoresB : std_logic_vector(2 downto 0);
    signal winner  : std_logic_vector(1 downto 0);

    -- Component declaration of tally (winner determination)
    component tally
        Port (
            scoresA : in std_logic_vector(2 downto 0);
            scoresB : in std_logic_vector(2 downto 0);
            winner : out std_logic_vector(1 downto 0)
        );
    end component;
begin
    -- Mapping switches to the votes of contestant A and B
    scoresA <= SW2 & SW1 & SW0; -- 3-bit vector from SW0, SW1, SW2
    scoresB <= SW5 & SW4 & SW3; -- 3-bit vector from SW3, SW4, SW5

    -- Instantiate the tally component to determine the winner
    winner_determine: tally
        port map (
            scoresA => scoresA,
            scoresB => scoresB,
            winner  => winner
        );

    -- Map the result (winner) to the LEDs
    LD0 <= winner(1); -- Display bit 0 of winner on LD0
    LD1 <= winner(0); -- Display bit 1 of winner on LD1

    LD2 <= '0';
    LD3 <= '0';
    LD4 <= '0';
    LD5 <= '0';
    LD6 <= '0';
    LD7 <= '0';

end Behavioral;
