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

signal SIPO_reg : std_logic_vector (7 downto 0):="00000000";

signal LATCH : std_logic_vector(7 downto 0):="00000000";
begin

SISO: process (SHIFTCLOCK, RESET)
begin
	if RESET = '0' then
		SQh_reg <= (others => '0');
	elsif (SHIFTCLOCK'event and SHIFTCLOCK = '1') then
		SQh_reg(7 downto 0) <= A & SQh_reg(7 downto 1);
	end if;
end process;

SIPO: process (SHIFTCLOCK, RESET)
begin
	if RESET='0' then
		SIPO_reg <= (others => '0');
	elsif (SHIFTCLOCK'event and SHIFTCLOCK = '1') then
		SIPO_reg <= (A & SIPO_reg(7) & SIPO_reg(6) & SIPO_reg(5) & SIPO_reg(4) 
							& SIPO_reg(3) & SIPO_reg(2) & SIPO_reg(1));
		
	end if;
end process;

LATCHs: process(LATCHCLOCK, OUTPUTENABLE)
begin
	if (LATCHCLOCK'event and LATCHCLOCK ='1') then
		Qa <= SIPO_reg(7);
		Qb <= SIPO_reg(6);
		Qc <= SIPO_reg(5);
		Qd <= SIPO_reg(4);
		Qe <= SIPO_reg(3);
		Qf <= SIPO_reg(2);
		Qg <= SIPO_reg(1);
		Qh <= SIPO_reg(0);
		LATCH<=SIPO_reg;
	elsif(OUTPUTENABLE='1') then
		Qa <= 'Z';
		Qb <= 'Z';
		Qc <= 'Z';
		Qd <= 'Z';
		Qe <= 'Z';
		Qf <= 'Z';
		Qg <= 'Z';
		Qh <= 'Z';
	else
		Qa <= LATCH(7);
		Qb <= LATCH(6);
		Qc <= LATCH(5);
		Qd <= LATCH(4);
		Qe <= LATCH(3);
		Qf <= LATCH(2);
		Qg <= LATCH(1);
		Qh <= LATCH(0);
	end if;
end process;

SQh <= Sqh_reg(0);

end top_arch;