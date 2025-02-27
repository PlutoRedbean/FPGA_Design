module BCDcounter (
	input clk,
	input reset,
	// input enable,
	output reg [3:0] num,
    output reg carry
);

    initial begin
        num = 4'd0;
    end
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            num <= 4'd0;
        end
        else begin
            if (num < 4'd9) begin
                num <= num + 4'd1;
                carry <= 0;
            end
            else  begin
                num <= 4'd0;
                carry <= 1;
            end
        end
    end
endmodule
