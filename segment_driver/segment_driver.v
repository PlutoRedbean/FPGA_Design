/**
 *  这是数码管驱动。mode决定了数码管读取数字编码后的结果还是原始数据来显示。
 *  0表示输出编码后的结果，1表示原始数据输入。seg1~8表示每个八段数码管。
 *  seg_en表示哪个数码管需要被启用
 *  reg sel是数码管的sel，高电平启用
 *  reg seg是数码管的seg，高电平启用
 */
module segment_driver(
    input wire clk,
    input wire reset,
    input wire [7:0] seg_en,
    input wire [7:0] mode,
    input wire [7:0] seg1,
    input wire [7:0] seg2,
    input wire [7:0] seg3,
    input wire [7:0] seg4,
    input wire [7:0] seg5,
    input wire [7:0] seg6,
    input wire [7:0] seg7,
    input wire [7:0] seg8,
    output reg [7:0] sel,
    output reg [7:0] seg
);

    parameter MAX_TIME = 5000;

    reg [8:0]switch;
    reg [12:0]counter;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            counter <= 1'd0;
        end
        else begin
            if (counter < MAX_TIME - 1'd1) begin
                counter <= counter + 1'd1;
            end
            else begin
                counter <= 1'd0;
            end
        end
    end

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            seg <= 8'hFF;
            sel <= 8'hFF;
        end
        else begin
            case (switch)
                8'b10000000 : begin
                    sel = {7'b1111111, seg_en[0]};
                    seg <= mode[0] ? input_decode(seg1) : seg1;
                end
                8'b01000000 : begin
                    sel = {6'b111111, seg_en[1], 1'b1};
                    seg <= mode[1] ? input_decode(seg2) : seg2;
                end
                8'b00100000 : begin
                    sel = {5'b11111, seg_en[2], 2'b11};
                    seg <= mode[2] ? input_decode(seg3) : seg3;
                end
                8'b00010000 : begin
                    sel = {4'b1111, seg_en[3], 3'b111};
                    seg <= mode[3] ? input_decode(seg4) : seg4;
                end
                8'b00001000 : begin
                    sel = {3'b111, seg_en[4], 4'b1111};
                    seg <= mode[4] ? input_decode(seg5) : seg5;
                end
                8'b00000100 : begin
                    sel = {2'b11, seg_en[5], 5'b11111};
                    seg <= mode[5] ? input_decode(seg6) : seg6;
                end
                8'b00000010 : begin
                    sel = {1'b1, seg_en[6], 6'b111111};
                    seg <= mode[6] ? input_decode(seg7) : seg7;
                end
                8'b00000001 : begin
                    sel = {seg_en[7], 7'b1111111};
                    seg <= mode[7] ? input_decode(seg8) : seg8;
                end
                default : begin
                    sel <= 8'hFF;
                    seg <= 8'hFF;
                end
            endcase
        end
    end

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            switch <= 8'b00000001;
        end
        else begin
            if (counter >= MAX_TIME - 1'd1) begin
                switch <= { switch[6:0], switch[7] };
            end
        end
    end

    function [7:0]input_decode(input [7:0]num);
        case (num)
            8'h00   : input_decode = 8'hC0;
            8'h01   : input_decode = 8'hF9;
            8'h02   : input_decode = 8'hA4;
            8'h03   : input_decode = 8'hB0;
            8'h04   : input_decode = 8'h99;
            8'h05   : input_decode = 8'h92;
            8'h06   : input_decode = 8'h82;
            8'h07   : input_decode = 8'hF8;
            8'h08   : input_decode = 8'h80;
            8'h09   : input_decode = 8'h90;
            8'h0a   : input_decode = 8'h88;
            8'h0b   : input_decode = 8'h83;
            8'h0c   : input_decode = 8'hc6;
            8'h0d   : input_decode = 8'hA1;
            8'h0e   : input_decode = 8'h86;
            8'h0f   : input_decode = 8'h8E;
            default : input_decode = 8'h00;
        endcase
    endfunction

endmodule
