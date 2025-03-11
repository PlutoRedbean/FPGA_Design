module top( 
	input	wire				sys_clk		,
   	input	wire				rst			, 
	output 	wire 	[7:0] 		seg	        ,
	output 	wire 	[7:0]		sel	        ,
   	output 	wire        		scl     	,
   	inout	wire      			sda     
);								 

//signal define
wire    			[7:0]   	rd_data		;
reg					[11:0]		bcd			;
reg					[31:0]		dsp_data	;

//
always@(posedge sys_clk or posedge rst) begin
	if (rst) begin
		dsp_data <= {4'd15,4'd10,4'd10,4'd10,4'd10,4'd10,4'd10,4'd10};
	end else begin
		if(rd_data < 10) begin
			dsp_data <= {4'd15,4'd10,4'd10,4'd10,4'd10,4'd10,4'd10, rd_data[3:0]};
		end else if(rd_data < 100 && rd_data >= 10) begin
			bcd[7:4] <= rd_data / 10;
			bcd[3:0] <= rd_data % 10;
			dsp_data <= {4'd15,4'd10,4'd10,4'd10,4'd10,4'd10,bcd[7:4], bcd[3:0]};
		end else begin
			bcd[11:8] <= rd_data / 100;
			bcd[7:4]  <= rd_data % 100 / 10;
			bcd[3:0]  <= rd_data % 10;
			dsp_data <= {4'd15,4'd10,4'd10,4'd10,4'd10,bcd[11:8],bcd[7:4], bcd[3:0]};
		end
	end 
end

//adc module
adc adc_inst(
	.clk		 		(sys_clk)			,
	.rst	     		(~rst)				,
	.wr_req      		()					,
	.rd_req      		(1'b1)				,
	.device_id   		(7'b101_0100)		,
	.reg_addr    		(8'h00)				,
	.reg_addr_vld		(1'b1)				,
	.wr_data     		()					,
	.wr_data_vld 		()					,
	.rd_data     		(rd_data)			,
	.rd_data_vld 		()					,
	.ready       		()					,
	.scl         		(scl)				,
	.sda         		(sda)
);
// 只读ADC

//seg module
segdisplay segdisplay_inst(
	.clk 				(sys_clk)			,
	.rst 				(~rst)				,
	.seg_number_in 		(dsp_data)			,
	.seg_number 		(seg)		        ,
	.seg_choice 		(sel)
);

endmodule
