-- Szymon Kaczmarek

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
Port (	
		  A : in std_logic; --serial data input
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

architecture top_arch of top is

signal SQh_reg : std_logic_vector (7 downto 0);

signal SIPO_reg : std_logic_vector (7 downto 0);
      
begin

SISO: process (SHIFTCLOCK, RESET)
begin
	if RESET = '0' then
		SQh_reg <= (others => '0');
	elsif (SHIFTCLOCK'event and SHIFTCLOCK = '1') then
		SQh_reg(7 downto 0) <= A & SQh_reg(7 downto 1);
	end if;
end process;

SIPO: process (LATCHCLOCK, RESET)
begin
	if RESET = '0' then
		SIPO_reg <= (others => '0');
	elsif (LATCHCLOCK'event and LATCHCLOCK = '1') then
		SIPO_reg <= (A & SIPO_reg(7) & SIPO_reg(6) & SIPO_reg(5) & SIPO_reg(4) 
							& SIPO_reg(3) & SIPO_reg(2) & SIPO_reg(1));
	end if;
end process;

Qa <= SIPO_reg(7);
Qb <= SIPO_reg(6);
Qc <= SIPO_reg(5);
Qd <= SIPO_reg(4);
Qe <= SIPO_reg(3);
Qf <= SIPO_reg(2);
Qg <= SIPO_reg(1);
Qh <= SIPO_reg(0);

SQh <= Sqh_reg(0);

end top_arch;

