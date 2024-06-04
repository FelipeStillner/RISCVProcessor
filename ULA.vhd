LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT (
        clk : IN STD_LOGIC;
        s1, s2 : IN UNSIGNED(31 DOWNTO 0);
        sel : IN UNSIGNED(4 DOWNTO 0);
        cond : OUT STD_LOGIC;
        res : OUT UNSIGNED(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behaviour OF ula IS

    SIGNAL eq, ne, lt, ge, ltu, geu : STD_LOGIC;
    SIGNAL aadd, asub, lxor, lor, land, lsl, lsr, asr : UNSIGNED(31 DOWNTO 0);
    -- TODO: SETS
BEGIN
    -- OPERATIONS
    res <= aadd WHEN sel = "00000" ELSE
        asub WHEN sel = "00001" ELSE
        lxor WHEN sel = "01000" ELSE
        lor WHEN sel = "01001" ELSE
        land WHEN sel = "01010" ELSE
        lsl WHEN sel = "01011" ELSE
        lsr WHEN sel = "01100" ELSE
        asr WHEN sel = "00010" ELSE
        "00000000000000000000000000000000";
    aadd <= s1 + s2;
    asub <= s1 - s2;
    lxor <= s1 xor s2;
    lor <= s1 or s2;
    land <= s1 and s2;
    lsl <= s1 sll to_integer(s2);
    lsr <= s1 srl to_integer(s2);
    asr <= s1 sra to_integer(s2);

    -- CONDITIONS TO JUMP
    cond <= eq WHEN sel = "10000" ELSE
        ne WHEN sel = "10001" ELSE
        lt WHEN sel = "10010" ELSE
        ge WHEN sel = "10011" ELSE
        ltu WHEN sel = "10100" ELSE
        geu WHEN sel = "10101" ELSE
        '0';
    eq <= '1' WHEN s1 = s2 ELSE
        '0';
    ne <= NOT eq;
    lt <= '1' WHEN signed(s1) < signed(s2) ELSE
        '0';
    ge <= '1' WHEN signed(s1) >= signed(s2) ELSE
        '0';
    ltu <= '1' WHEN s1 < s2 ELSE
        '0';
    geu <= '1' WHEN s1 >= s2 ELSE
        '0';
END ARCHITECTURE;