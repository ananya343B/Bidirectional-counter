module pes_bc_tb;

    // Inputs
    reg Clk;
    reg reset;
    reg UpOrDown;

    // Outputs
    wire [3:0] Count;

    // Instantiate the Unit Under Test (UUT)
    pes_bc uut (
        .Clk(Clk), 
        .reset(reset), 
        .UpOrDown(UpOrDown), 
        .Count(Count)
    );

//Generate clock with 10 ns clk period.
    initial Clk = 0;
    always #5 Clk = ~Clk;
    
    initial begin
        // Apply Inputs
	    $dumpfile("pes_bc_out.vcd");
	    $dumpvars(0,pes_bc_tb);
        reset = 0;
        UpOrDown = 0;
        #30;
        UpOrDown = 1;
      #30;
        reset = 1;
        UpOrDown = 0;
        #100;
        reset = 0;  
	#10000 $finish;
    end
      
endmodule
