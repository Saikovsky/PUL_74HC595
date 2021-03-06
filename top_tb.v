`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// �ukasz Lech
// 243 265
// TestBench uk�adu 74HC595
// Grupa PN 10:00
//////////////////////////////////////////////////////////////////////////////////


module top_tb;

reg A = 0, SHIFTCLOCK = 0, RESET = 1, LATCHCLOCK = 0, OUTPUTENABLE = 0;
wire Qa, Qb, Qc, Qd, Qe, Qf, Qg, Qh, SQh;


	top uut(
		.A(A), //serial data input
		.SHIFTCLOCK(SHIFTCLOCK), 
		.RESET(RESET), 
		.LATCHCLOCK(LATCHCLOCK),
		.OUTPUTENABLE(OUTPUTENABLE),
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
	   $fdisplay(raport, "SQh|Qh|Qg|Qf|Qe|Qd|Qc|Qb|Qa");
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
	
	
	always @(posedge SHIFTCLOCK) begin
	   
	   if(RESET == 0)
	        $fdisplay(raport, "            RESET                ");
	   else
	   	    $fdisplay(raport, "%b   %b  %b  %b  %b  %b  %b  %b  %b", SQh, Qh, Qg, Qf, Qe, Qd, Qc, Qb, Qa);
	  
	end

endmodule
