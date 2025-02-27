`include "one_mHz.v"

module seg_control(
    input clk,
    input [7:0] seg_en,
    input [3:0] num1,
    input [3:0] num2,
    input [3:0] num3,
    input [3:0] num4,
    input [3:0] num5,
    input [3:0] num6,
    input [3:0] num7,
    input [3:0] num8,   //87654321
    output reg [7:0] sel,
    output reg [7:0] seg
);

    reg [2:0] display;

    wire mHz;
    one_mHz one_mHz_Gen ( .clk(clk), .reset(reset), .mHz(mHz) );

    always @(posedge mHz) begin
        if (display < 7) begin
            display <= display + 1;
        end
        else begin
            display <= 0;
        end
        case (display)
            4'd0 : begin
                sel <= {7'b1111111, seg_en[0]};
                case (num1)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd1 : begin
                sel <= {6'b111111, seg_en[1], 1'b1};
                case (num2)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end  
            4'd2 : begin
                sel <= {5'b11111, seg_en[2], 2'b11};
                case (num3)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd3 : begin
                sel <= {4'b1111, seg_en[3], 3'b111};
                case (num4)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd4 : begin
                sel <= {3'b111, seg_en[4], 4'b1111};
                case (num5)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd5 : begin
                sel <= {2'b11, seg_en[5], 5'b11111};
                case (num6)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd6 : begin
                sel <= {1'b1, seg_en[6], 6'b111111};
                case (num7)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            4'd7 : begin
                sel <= {seg_en[7], 7'b1111111};
                case (num8)
                    4'h0 : seg <= 8'hC0;
                    4'h1 : seg <= 8'hF9;
                    4'h2 : seg <= 8'hA4;
                    4'h3 : seg <= 8'hB0;
                    4'h4 : seg <= 8'h99;
                    4'h5 : seg <= 8'h92;
                    4'h6 : seg <= 8'h82;
                    4'h7 : seg <= 8'hF8;
                    4'h8 : seg <= 8'h80;
                    4'h9 : seg <= 8'h90;
                    4'ha : seg <= 8'h88; //10001000
                    4'hb : seg <= 8'h83; //10000011
                    4'hc : seg <= 8'hc6; //11000110
                    4'hd : seg <= 8'hA1; //10100001
                    4'he : seg <= 8'h86; //10000110
                    4'hf : seg <= 8'h8E; //10001110
                    default : seg <= 8'h7f;
                endcase
            end
            default : begin
                sel <= 8'hff;
                seg <= 8'h7f;
            end
        endcase
    end
endmodule
