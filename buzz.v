module buzz (
	input clk,
    input s1,
    input reset,
    output buzz_driver
);

// 1.25kHz，50%占空比

    reg [15:0]counter;
    reg b1;
    reg enable;
    reg driver;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 16'd0;
            b1 <= 1'd0;
            enable <= 1'd0;
            driver <= 1'd0;
        end
        else begin
            b1 <= s1;
            enable <= ~s1 & b1 ? ~enable : enable;
            if (enable & counter < 16'd40000) begin
                counter <= counter + 1'd1;
            end
            else if (counter >= 16'd40000) begin
                counter <= 16'd0;
            end
            if (enable & counter >= 16'd20000) begin
                driver <= 1'd1;
            end
            else begin
                driver <= 1'd0;
            end
        end
    end

    assign buzz_driver = driver;
    
endmodule
