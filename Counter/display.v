`include "seg_control.v"
`include "one_Hz.v"
`include "BCDcounter.v"

module display(
    input clk,
    input reset,
    output [7:0] seg,
    output [7:0] sel
);
    wire Hz;
    wire [3:0] one;
    wire [3:0] ten;
    wire [3:0] hundred;
    wire [3:0] thousand;
    // reg [31:0] num;

    one_Hz one_Hz_Gen ( .clk(clk), .reset(reset), .Hz(Hz) );

    wire carry_0, carry_1, carry_2, trash;
    BCDcounter BCDcounter_one ( .clk(Hz), .reset(reset), .num(one), .carry(carry_0) );
    BCDcounter BCDcounter_ten ( .clk(carry_0), .reset(reset), .num(ten), .carry(carry_1) );
    BCDcounter BCDcounter_hundred ( .clk(carry_1), .reset(reset), .num(hundred), .carry(carry_2) );
    BCDcounter BCDcounter_thousand ( .clk(carry_2), .reset(reset), .num(thousand), .carry(trash) );

    // always @(posedge Hz, posedge reset) begin
    //     if (reset) begin
    //         num <= 32'd0;
    //     end
    //     else begin
    //         num <= num + 1;
    //     end
    // end

    seg_control seg_control_u0 (
        .clk(clk),
        .seg_en(8'b11000011),   //0 for enable, 1 for disable
        .num1(4'h0),
        .num2(4'h0),
        .num3(one),
        .num4(ten),
        .num5(hundred),
        .num6(thousand),
        .num7(4'h0),
        .num8(4'h0),
        .seg(seg),
        .sel(sel)
    );
    
endmodule
