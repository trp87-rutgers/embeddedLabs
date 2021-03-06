----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2018 03:14:30 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
    port (
    clk, en : in std_logic;
    hcount, vcount : out std_logic_vector (9 downto 0);
    vid, hs, vs : out std_logic
    );
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal hcounter, vcounter : std_logic_vector(9 downto 0) := (others => '0');


begin
    hcount <= hcounter;
    vcount <= vcounter;
    process(clk) begin
        if (rising_edge(clk) and en = '1') then
            hcounter <= std_logic_vector(unsigned(hcounter) + 1);
            if unsigned(hcounter) = 800 then
                hcounter <= (others => '0');
            end if;
            
            if unsigned(hcounter) = 0 then
                vcounter <= std_logic_vector(unsigned(vcounter) + 1);
            end if;
            
            if unsigned(vcounter) = 525 then
                vcounter <= (others => '0');
            end if;
            
            
            if unsigned(hcounter) < 640 and unsigned(vcounter) < 480 then
                vid <= '1';
            else
                vid <= '0';
            end if;
            
            if unsigned(hcounter) >= 656 and unsigned(hcounter) <= 751 then
                hs <= '0';
            else
                hs <= '1';
            end if;
            
            if unsigned(vcounter) = 490 or unsigned(vcounter) = 491 then
                vs <= '0';
            else
                vs <= '1'; 
            end if;
            
        end if;
    end process;

end Behavioral;
