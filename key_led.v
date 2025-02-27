module key_led(
    input s1,
    input reset,
    input clk,
    output led1
);
    
    parameter A = 2'd0,
              B = 2'd1,
              C = 2'd2;
    
    reg [1:0]state, next;
    reg l1;
    
    wire check;
    reg [35:0] num;
    always @(posedge clk) begin
        if (reset || check) begin
            num <= 1'd0;
        end
        else begin
            num <= num + 1'd1;
        end
    end
    assign check = (num == 36'd500000) ? 1 : 0; // 10ms更新一次

    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = ~s1 ? B : A;
            B : next = ~s1 ? C : A;
            C : next = ~s1 ? C : A;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge check) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end
    
    // Output logic
    always @(posedge check) begin
        if (reset) begin
            l1 <= 1'd0;
        end
        else begin
            l1 <= (next == C);
        end
    end

    assign led1 = l1;
    
endmodule
