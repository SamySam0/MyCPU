// MU0 16 bit register testbench
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps 

// module header

module mu0_reg16_tb();

// Define any internal connections

reg Clk;
reg Reset;
reg En;
reg[15:0] D;
wire[15:0] Q;


// Instantiate mu0_reg16 as dut (device under test)
mu0_reg16 dut(Clk, Reset, En, D, Q);


// Set up the clock

// the following initial block initialises the clock

initial Clk = 0;

// the following always block creates the clock signal

always 
 begin
    #50
    Clk = ~Clk;     // Inverts the Clock
 end


// Test vectors
initial
 begin
	#0 Reset = 1'b1; En = 1'b1; D = 16'hFFFE;   // Reset goes high and D is not loaded in reg even when En is high 
	#200 Reset = 1'b0;  
	#200 Reset = 1'b0; En = 1'b0; D = 16'hFFFA; // Enable goes Low, the new value of D is not loaded
	#200 Reset = 1'b0; En = 1'b1;  
	#275 Reset = 1'b1;                          // Testing asynchronous behaviour of Reset
	#125 Reset = 1'b0;                          // Loading the data back in reg
	#200 En = 1'b0;
	#200 Reset = 1'b1;                          // When En == 0, Data is still overwritten by the Reset
   #100 $finish;                               // End the simulation  
 end


// Save results as VCD file 
// Do not change
initial
 begin
  $dumpfile("mu0_reg16_tb_results.vcd");  // Save simulation waveforms in this file
  $dumpvars; // Capture all simulation waveforms
 end

endmodule 
