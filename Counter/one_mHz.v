module one_mHz (
    input clk,
    input reset,
    output mHz
); 

    reg [35:0] num;
    always @(posedge clk, posedge reset) begin
        if (reset || mHz) begin
            num <= 0;
        end
        else begin
            num <= num + 1;
        end
    end

    assign mHz = (num == 36'd50000) ? 1 : 0; //这里设为奇数（49999999）时，只能display偶数？

endmodule
