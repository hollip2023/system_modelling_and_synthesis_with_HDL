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
     scoresA : in std_logic_vector(2 downto 0); -- Total scores for A
     scoresB : in std_logic_vector(2 downto 0); -- Total scores for B
     winner : out std_logic_vector(1 downto 0)  -- Winner vector
 );
end tally;

architecture loopy of tally is
begin
    process (scoresA, scoresB)
        --seems can't convert bit of logic vector to unsigned # unsigned(scoresB(0))
        -- maybe change to unsigned(3 downto 0) ?
        variable intScoresA : integer := 0;
        variable intScoresB : integer := 0;
    begin
        -- Reset score counters at the beginning of each process execution
        intScoresA := 0;
        intScoresB := 0;
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
    end process;
end loopy;
