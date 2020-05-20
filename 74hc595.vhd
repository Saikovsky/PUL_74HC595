--Architektura 74HC595
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity top is
Port (	
		  A : in std_logic; --serial data input
        SHIFTCLOCK : in std_logic;
        RESET: in std_logic;
        LATCHCLOCK : in std_logic;
        OUTPUTENABLE: in std_logic;
        Qa: out std_logic:='0';
        Qb: out std_logic:='0';
        Qc: out std_logic:='0';
        Qd: out std_logic:='0';
        Qe: out std_logic:='0';
        Qf: out std_logic:='0';
        Qg: out std_logic:='0';
        Qh: out std_logic:='0';
        SQh: out std_logic -- serial data output
        );
end top;

architecture top_arch of top is

signal SQh_reg : std_logic_vector (7 downto 0);
signal LATCH : std_logic_vector(7 downto 0) := "00000000";

begin

SISO: process (SHIFTCLOCK, RESET)
begin
	if RESET = '0' then
		SQh_reg <= (others => '0');
	elsif (SHIFTCLOCK'event and SHIFTCLOCK = '1') then
		SQh_reg(7 downto 0) <= SQh_reg(6 downto 0) & A;
	end if;
end process;

LATCHs: process(LATCHCLOCK)
begin
	if (LATCHCLOCK'event and LATCHCLOCK ='1') then
		LATCH <= SQh_reg;
	end if;
end process;

SQh <= Sqh_reg(7);
Qa <= 'Z' when OUTPUTENABLE = '1' else LATCH(0);
Qb <= 'Z' when OUTPUTENABLE = '1' else LATCH(1);
Qc <= 'Z' when OUTPUTENABLE = '1' else LATCH(2);
Qd <= 'Z' when OUTPUTENABLE = '1' else LATCH(3);
Qe <= 'Z' when OUTPUTENABLE = '1' else LATCH(4);
Qf <= 'Z' when OUTPUTENABLE = '1' else LATCH(5);
Qg <= 'Z' when OUTPUTENABLE = '1' else LATCH(6);
Qh <= 'Z' when OUTPUTENABLE = '1' else LATCH(7);

end top_arch;