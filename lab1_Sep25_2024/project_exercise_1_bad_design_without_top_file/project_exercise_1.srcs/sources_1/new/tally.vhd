----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2024 03:07:26 PM
-- Design Name: 
-- Module Name: tally - loopy
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
use IEEE.NUMERIC_STD.ALL; -- for using unsigned variables in this file

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tally is
 port (
     --scoresA, scoresB : in std_logic_vector(2 downto 0);
     --winner : out std_logic_vector(1 downto 0)
     --zedboard
     -- Switch inputs for scores
     --SW0, SW1, SW2 : in STD_LOGIC; -- Score for A
     --SW3, SW4, SW5 : in STD_LOGIC; -- Score for B
     -- LED outputs for results
     --LD0, LD1 : out STD_LOGIC -- Result indicators (winner)
     SW0 : in STD_LOGIC;
     SW1 : in STD_LOGIC;
     SW2 : in STD_LOGIC;
     SW3 : in STD_LOGIC;
     SW4 : in STD_LOGIC;
     SW5 : in STD_LOGIC;

     LD0 : out STD_LOGIC;
     LD1 : out STD_LOGIC
 );
end tally;

architecture loopy of tally is
    --signal sigscoreA : integer := 0;
    --signal sigscoreB : integer := 0;
    signal scoresA : std_logic_vector(2 downto 0); -- Scores for contestant A
    signal scoresB : std_logic_vector(2 downto 0); -- Scores for contestant B
    signal winner : std_logic_vector(1 downto 0);
begin
    --process (scoresA, scoresB)
    process(SW0, SW1, SW2, SW3, SW4, SW5)
        --seems can't convert bit of logic vector to unsigned # unsigned(scoresB(0))
        -- maybe change to unsigned(3 downto 0) ?
        variable intScoresA : integer;
        variable intScoresB : integer;
    begin
        intScoresA := 0;
        intScoresB := 0;
        ---------------------------------------------------------------------------------------
        --read input from switches and assign to scoreA
        -- Assign values from switches to scoresA and scoresB
        scoresA <= (SW0, SW1, SW2);  -- Assign SW0, SW1, SW2 to scoresA
        scoresB <= (SW3, SW4, SW5);  -- Assign SW3, SW4, SW5 to scoresB
        ---------------------------------------------------------------------------------------
        -- count votes for contestant A
        for i in 0 to 2 loop
            if scoresA(i) = '1' then
                intScoresA := intScoresA + 1;
            end if;
        end loop;
        
        --count votes for contestant B
        for i in 0 to 2 loop
            if scoresB(i) = '1' then
                intScoresB := intScoresB + 1;
            end if;
        end loop;
        
        --determine the winner
        if intScoresA > intScoresB then
            winner <= "10"; -- winner is A
        elsif intScoresA < intScoresB then
            winner <= "01"; -- winner is B
        elsif intScoresA = 0 and intScoresB = 0 then  -- tie
            winner <= "00";
        else
            winner <= "11"; -- tie
        end if;
        
        -- Map winner result to LEDs
        LD0 <= winner(1); -- Assign the first bit of winner to LD0
        LD1 <= winner(0); -- Assign the second bit of winner to LD1
    end process;
end loopy;
