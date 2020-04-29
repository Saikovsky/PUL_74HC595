----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2020 10:41:08
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

entity top is
  Port (A : in std_logic; --serial data input
        SHIFTCLOCK : in std_logic;
        RESET: in std_logic;
        LATCHCLOCK : in std_logic;
        OUTPUTENABLE: in std_logic;
        Qa: out std_logic;
        Qb: out std_logic;
        Qc: out std_logic;
        Qd: out std_logic;
        Qe: out std_logic;
        Qf: out std_logic;
        Qg: out std_logic;
        Qh: out std_logic;
        SQh: out std_logic; -- serial data output
        Vcc: in std_logic;
        GND: in std_logic
        );
end top;

architecture Behavioral of top is

begin


end Behavioral;
