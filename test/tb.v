`timescale 1ps/1ps


module tb();



    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end
endmodule