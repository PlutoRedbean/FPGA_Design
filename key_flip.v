module key_led(
    input s1, s2, s3, s4, clk,
    output led1, led2, led3, led4
);
    reg b1, b2, b3;
    reg l1, l2, l3;

    always @(posedge clk) begin
        b1 <= s1;
        b2 <= s2;
        b3 <= s3;
        l1 <= ~s1 & b1 ? ~l1 : l1;
        l2 <= ~s2 & b2 ? ~l2 : l2;
        l3 <= ~s3 & b3 ? ~l3 : l3;
        if (~s4) begin
            l1 <= 1'b1;
            l2 <= 1'b1;
            l3 <= 1'b1;
        end
    end
    assign led1 = l1;
    assign led2 = l2;
    assign led3 = l3;
    assign led4 = 1;
endmodule
