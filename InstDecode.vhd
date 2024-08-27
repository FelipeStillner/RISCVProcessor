LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InstDecode IS
    PORT (
        inst : IN UNSIGNED(2 DOWNTO 0);
        read_reg, write_reg : OUT STD_LOGIC;
        lui : OUT STD_LOGIC;
        sel : OUT UNSIGNED(4 DOWNTO 0);
        read_mem, write_mem : OUT STD_LOGIC;
        jumpcond, jump : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behaviour OF InstDecode IS

SIGNAL funct3 : UNSIGNED(2 DOWNTO 0);
SIGNAL funct7 : UNSIGNED(6 DOWNTO 0);
SIGNAL opc : UNSIGNED(6 DOWNTO 0);

BEGIN
    -- FUNCT
    opc <= inst(6 downto 0);
    funct3 <= inst(14 downto 12);
    funct7 <= inst(31 downto 25);

    -- JUMP
    jumpcond <= '1' WHEN opc = "1100011" ELSE
        '0';
    jump <= '1' WHEN opc = "1101111" OR opc = "1100111" ELSE
        '0';

    -- LUI
    lui <= '1' WHEN opc = "0110111" ELSE
        '0';

    -- SEL
    sel <= "00000" WHEN (opc = "0010011" AND funct3 = "000") OR (opc = "0110011" AND funct3 = "000" AND funct7 = "0000000") ELSE
        "00001" WHEN (opc = "0110011" AND funct3 = "000" AND funct7 = "0100000") ELSE
        "01000" WHEN (opc = "0010011" AND funct3 = "100") OR (opc = "0110011" AND funct3 = "100" AND funct7 = "0000000") ELSE
        "01001" WHEN (opc = "0010011" AND funct3 = "110") OR (opc = "0110011" AND funct3 = "110" AND funct7 = "0000000") ELSE
        "01010" WHEN (opc = "0010011" AND funct3 = "111") OR (opc = "0110011" AND funct3 = "111" AND funct7 = "0000000") ELSE
        "11111";
    END ARCHITECTURE;