`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// �ukasz Lech
// 243 265
// TestBench uk�adu 74HC595
// Grupa PN 10:00
//////////////////////////////////////////////////////////////////////////////////


module top_tb;

reg A = 0, SHIFTCLOCK = 0, RESET = 1, LATCHCLOCK = 0, OUTPUTENABLE = 0, Vcc = 1, GND = 0;
wire Qa = 0, Qb = 0, Qc = 0, Qd = 0, Qe = 0, Qf = 0, Qg = 0, Qh = 0, SQh = 0;


	top uut(
		.A(A), //serial data input
		.SHIFTCLOCK(SHIFTCLOCK), 
		.RESET(RESET), 
		.LATCHCLOCK(LATCHCLOCK),
		.OUTPUTENABLE(OUTPUTENABLE),
		.Vcc(Vcc),
		.GND(GND),
		.Qa(Qa),
		.Qb(Qb),
		.Qc(Qc),
		.Qd(Qd),
		.Qe(Qe),
		.Qf(Qf),
		.Qg(Qg),
		.Qh(Qh),
		.SQh(SQh) //serial data output
	);
	
	
	integer raport, wektory;
	
	initial
	begin
	   raport = $fopen("raport.txt");
	   wektory = $fopen("wektory.txt", "r");
	   $fdisplay(raport, "Qh|Qg|Qf|Qe|Qd|Qc|Qb|Qa");
	   RESET <= 0;
	   #30;
	   RESET <= 1;
	   wektoryTestowe();
	
	   $fclose(raport);
	   $fclose(wektory);
	end
	
	always		// generacja sygna�u zegarowego
	   #20 SHIFTCLOCK = ~SHIFTCLOCK;
	   
	
	task wektoryTestowe;
    reg [3:0] data;
    integer testFile;
	begin
        if (wektory == 0) begin
            $display("Brak wej�ciowych wektor�w testuj�cych");
            $finish;
        end
        #20;
            
        while (!$feof(wektory)) begin
            testFile = $fscanf(wektory, "%b\n", data);
            //reset - latchClock - output enable - serial data input
            RESET <= data[3];
            LATCHCLOCK <= data[2];
            OUTPUTENABLE <= data[1];
            A <= data[0];

            #40;
         end
	end
	endtask;
	
	
	reg latch = 0;
	always @(LATCHCLOCK, OUTPUTENABLE) begin
	
	   if(LATCHCLOCK == 1) begin
	       #5 latch = 1;
	   end
	   
	   if(latch == 1 && OUTPUTENABLE == 0) begin
	        $fdisplay(raport, "%b  %b  %b  %b  %b  %b  %b  %b", Qh, Qg, Qf, Qe, Qd, Qc, Qb, Qa);
	        latch <= 0;
	   end
	end

endmodule
