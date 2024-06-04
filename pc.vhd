LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clk : IN STD_LOGIC;
        imm : IN UNSIGNED(31 DOWNTO 0);
        cond : IN STD_LOGIC;
        jumpcond, jump : IN STD_LOGIC;
        addr : OUT UNSIGNED(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behaviour OF pc IS

    COMPONENT Reg8 IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            wr_en : IN STD_LOGIC;
            data_in : IN UNSIGNED(7 DOWNTO 0);
            data_out : OUT UNSIGNED(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL new_addr : UNSIGNED(7 DOWNTO 0);

    -- TODO: JALR

BEGIN
    REG : Reg8 PORT MAP(clk, '0', '1', new_addr, addr);

    new_addr <= addr + imm WHEN jump ELSE
        addr + imm WHEN jumpcond AND cond ELSE
        addr + 4;
END ARCHITECTURE;