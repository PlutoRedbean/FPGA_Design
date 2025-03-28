// 默认为模式0，MSB先行
module M_SPI_driver
#(
    parameter          CPOL    =   0,
    parameter          CPHA    =   0     
)
(
// 系统接口
    input              clk          , 			// 系统时钟
    input              reset        , 			// 复位信号，高电平有效
// 用户接口
    input              SPI_start    ,			// 发送传输开始信号，一个高电平
    input              SPI_end      ,			// 发送传输结束信号，一个高电平
    input        [7:0] data_send    , 			// 要发送的数据(MOSI)
    output  reg        rec_sign  	, 			// 完成接收的信号
// SPI物理接口
    output  reg        SPI_MOSI     , 			// SPI主机输出从机输入
    output  reg        SPI_SCLK	    , 			// SPI时钟
    output  reg        SPI_CS        			// SPI片选信号,低电平有效
);

// 状态定义
localparam IDLE  = 3'b001   ,
           START = 3'b010   ,
           TRANS = 3'b100   ;

reg  [2:0]state, next;

// SPI时钟相关信号
wire      SCLK_start         ;
wire      SCLK_done          ;
wire      SCLK_posedge       ;
wire      SCLK_negedge       ;
reg  [1:0]SCLK_count         ;

// 传输数据相关信号
wire      bit_start          ;
wire      bit_done           ;
reg  [2:0]bit_count          ;

// 数据存储
wire      data_save          ;
reg  [7:0]data_send_r        ;

// SPI_SCLK分频
always @(posedge clk, posedge reset) begin
    if (reset) begin
        SCLK_count <= 1'd0;
    end
    else if (SCLK_start) begin
        if (SCLK_done)
            SCLK_count <= 1'd0;
        else
            SCLK_count <= SCLK_count + 1'd1;
    end
end

always @(posedge clk, posedge reset) begin
    if (reset) begin
        SPI_SCLK <= 1'd0;
    end
    else if (SCLK_start) begin
        SPI_SCLK <= SCLK_count < 2'd2;
    end
end

assign SCLK_posedge = SCLK_start && SCLK_count == 2'd0 ;
assign SCLK_negedge = SCLK_start && SCLK_count == 2'd2 ;
assign SCLK_start   = state != IDLE                    ;
assign SCLK_done    = SCLK_start && SCLK_count == 2'd3 ;

// 锁存数据
always @(posedge clk, posedge reset) begin
    if (reset) begin
        data_send_r <= 1'd0;
    end
    else if (data_save) begin
        data_send_r <= data_send;
    end
end

assign data_save = state == START && bit_count == 3'd0 ||
                   state == TRANS && bit_count == 3'd7;

// 传输数据计数
always @(posedge clk, posedge reset) begin
    if (reset) begin
        bit_count <= 1'd0;
    end
    else if (bit_start) begin
        if (bit_done)
            bit_count <= 1'd0;
        else
            bit_count <= bit_count + 1'd1;
    end
end

assign bit_start = state == TRANS && SCLK_done    ;
assign bit_done  = bit_start && bit_count == 3'd7 ;

// rec_sign赋值
always @(posedge clk, posedge reset) begin
    if (reset) begin
        rec_sign <= 1'd0;
    end
    else begin
        rec_sign <= bit_done;
    end
end

// SPI_CS赋值
always @(posedge clk, posedge reset) begin
    if (reset) begin
        SPI_CS <= 1'd0;
    end
    else begin
        case (state)
            IDLE    : SPI_CS <= 1'd1;
            START   : SPI_CS <= 1'd0;
            TRANS   : SPI_CS <= 1'd0;
            default : SPI_CS <= 1'd1;
        endcase
    end
end

// SPI_MOSI赋值
always @(posedge clk, posedge reset) begin
    if (reset) begin
        SPI_MOSI <= 1'd0;
    end
    else begin
        SPI_MOSI <= data_send_r[7 - bit_count];
    end
end

// 状态转移
always @(*) begin
    case (state)
        IDLE    : next = SPI_start                        ? START : IDLE   ;
        START   : next = SCLK_done                        ? TRANS : START  ;
        TRANS   : next = SCLK_done && bit_done && SPI_end ? IDLE  : TRANS  ;
        default : next = state                                  ; 
    endcase
end

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next;
    end
end

endmodule
