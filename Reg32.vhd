LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Reg32 IS
   PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      wr_en : IN STD_LOGIC;
      data_in : IN UNSIGNED(31 DOWNTO 0);
      data_out : OUT UNSIGNED(31 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE behaviour OF Reg32 IS
   SIGNAL registro : UNSIGNED(31 DOWNTO 0);
BEGIN
   PROCESS (clk, rst, wr_en) -- acionado se houver mudança em clk, rst ou wr_en
   BEGIN
      IF rst = '1' THEN
         registro <= "00000000000000000000000000000000";
      ELSIF wr_en = '1' THEN
         IF rising_edge(clk) THEN
            registro <= data_in;
         END IF;
      END IF;
   END PROCESS;

   data_out <= registro; -- conexao direta, fora do processo
END ARCHITECTURE;