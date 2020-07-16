module acc_tb;
    bit clk, en;
    bit [31:0] x, q;
    acc i_dut (.*);

    initial begin
        automatic bit [31:0] i = 0;
        en <= #2ns i;
        do begin
            x <= #2ns i;
            clk <= #1ns 1;
            clk <= #2ns 0;
            #2ns;
        end while (i++ < 1337);
    end

endmodule

module acc (input clk, input [31:0] x, input en, output [31:0] q);
    bit [31:0] d, q;
    always_ff @(posedge clk) q <= #1ns d;
    always_comb begin
        d <= #2ns q;
        if (en) d <= #2ns q+x;
    end
endmodule
