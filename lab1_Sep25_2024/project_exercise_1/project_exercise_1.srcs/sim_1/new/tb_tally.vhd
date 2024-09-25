library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_tally is
end tb_tally;

architecture behavior of tb_tally is
    -- Component Declaration for the Unit Under Test (UUT)
    component tally
        Port (
            scoresA : in std_logic_vector(2 downto 0);
            scoresB : in std_logic_vector(2 downto 0);
            winner : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal scoresA : std_logic_vector(2 downto 0);
    signal scoresB : std_logic_vector(2 downto 0);
    signal winner : std_logic_vector(1 downto 0);

    -- Function to calculate expected result
    function expected_result(a, b : std_logic_vector(2 downto 0)) return std_logic_vector is
        variable intScoresA, intScoresB : integer := 0;
        variable result : std_logic_vector(1 downto 0) := "00";
    begin
        -- Count votes for contestant A
        for i in 0 to 2 loop
            if a(i) = '1' then
                intScoresA := intScoresA + 1;
            end if;
        end loop;

        -- Count votes for contestant B
        for i in 0 to 2 loop
            if b(i) = '1' then
                intScoresB := intScoresB + 1;
            end if;
        end loop;

        -- Determine result
        if intScoresA > intScoresB then
            result := "10"; -- winner is A
        elsif intScoresA < intScoresB then
            result := "01"; -- winner is B
        else
            if intScoresA = 0 and intScoresB = 0 then
                result := "00"; -- tie
            else
                result := "11"; -- tie
            end if;
        end if;

        return result;
    end function;

    -- Function to convert std_logic_vector to string
    function convert_score_vector_to_string(vec : std_logic_vector) return string is
        variable result : string(1 to vec'length);
    begin
        for i in 0 to vec'length - 1 loop
            case vec(i) is
                when '0' =>
                    result(i + 1) := '0'; -- append the string
                when '1' =>
                    result(i + 1) := '1';
                when others =>
                    result(i + 1) := '?'; -- should not happen, but handle it
            end case;
        end loop;
        return result;
    end function;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: tally
        port map (
            scoresA => scoresA,
            scoresB => scoresB,
            winner => winner
        );

    -- Testbench Process
    process
        variable i, j : integer;
        variable expected_winner : std_logic_vector(1 downto 0);
    begin
        -- Generate all possible input combinations
        for i in 0 to 7 loop -- scoresA
            for j in 0 to 7 loop -- scoresB
                scoresA <= std_logic_vector(to_unsigned(i, 3));
                scoresB <= std_logic_vector(to_unsigned(j, 3));
                -- Wait for a short time to ensure output is updated
                wait for 50 ns;

                -- Compute expected result
                expected_winner := expected_result(scoresA, scoresB);

                -- Assert the output matches the expected result
                assert (winner = expected_winner)
                    --report "Testbench failed"
                    report "Testbench failed for scoresA=" & convert_score_vector_to_string(scoresA) &
                           "  scoresB=" & convert_score_vector_to_string(scoresB) &
                           "  result Expected winner=" & convert_score_vector_to_string(expected_winner) &
                           "  but got winner=" & convert_score_vector_to_string(winner)
                    
                    severity error;
            end loop;
        end loop;

        -- End simulation
        wait;
    end process;
end behavior;
