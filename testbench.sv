`timescale 1ns / 1ps

//`include "halfadder.sv"

module testbench();

// Signals for UUT connection
reg A_in;
reg B_in;
wire S_out;
wire C_out;
reg pass;
integer tests_failed;

// Instantiate the unit under test
halfadder UUT
(
    .a(A_in),
    .b(B_in),
    .c(C_out),
    .s(S_out)
);

initial begin
    // Set up output to VCDD file
    $dumpfile("tb.vcd");
    $dumpvars(0, testbench);

    // Initialize testbench variables
end

// Write Test Stimulus
task test_00();
    begin
        A_in = 1'b0;
        B_in = 1'b0;
        #5;
        pass &= S_out == 0 & C_out == 0;
    end
endtask

task test_01();
    begin
        // Put your test for A = 0, and B = 1
        A_in = 1'b0;
        B_in = 1'b1;
        #5;
        pass &= S_out == 1 & C_out == 0;
    end
endtask

task test_10();
    begin
        // Put your test for A = 1, and B = 0
        A_in = 1'b1;
        B_in = 1'b0;
        #5;
        pass &= S_out == 1 & C_out == 0;
    end
endtask

task test_11 ();
    begin
        // Put your test for A = 1, and B = 1
        A_in = 1'b1;
        B_in = 1'b1;
        #5;
        pass &= S_out == 0 & C_out == 1;
    end
endtask

// Write Checker
initial begin
    //initalize pass
    pass = 1'b1;

    test_00(); #15;
    test_01(); #15;
    test_10(); #15;
    test_11(); #15;

    if (pass) begin
        $display("Tests Passed!");
    end else begin
        $display("Failed tests");
    end

end

endmodule
