`timescale 1ns / 1ps

module final_top_distr(
    input clk,
    input resetn,
    input [23:0] input_img,
    input HSYNC,
    input VSYNC,

    input [8:0] start_row, //watermark 
    input [9:0] start_col,

    output [23:0] output_img,
    output valid
);

    // top module output reg
    reg [23:0] output_output_img;
    reg output_valid;
    reg [8:0] row; // current pixel
    reg [9:0] col;

    // interface output
    wire ena;
    wire wea;
    wire [9*8-1:0] addra;
    wire [9*24-1:0] dina;

    // control input
    wire [24*9-1:0] mux_data_in;
    wire [8:0] row_in;
    wire [9:0] col_in;

    // control output
    wire [8*9-1:0] blkram_read_address;
    wire [24*9-1:0] bram_data;
    wire [24*9-1:0] mux_data_in;
    wire [24*9-1:0] mux_data_out;
    wire [8:0] row_out;
    wire [9:0] col_out;

    // convolution input
    wire [23:0] pixel_out;

    // watermark output
    wire hvalid;
    wire vvalid;

    initial begin
        if (~resetn) begin
            row <= 0;
//            col <= 0; // original (0,1)
            col <= -1;
            output_output_img <= 0;
            output_valid <= 0;
        end
    end

    always @(negedge resetn) begin
        row <= 0;
//        col <= 0; // original (0,1)
        col <= -1;
        output_output_img <= 0;
        output_valid <= 0;
    end

    always @(posedge clk && resetn) begin
        if (HSYNC && VSYNC) begin
            // current pixel
//            if (col == 10'd640) begin // row, col starts from (0, 1), in sync with tb. original code
//                col <= 1;
            if (col == 10'd639) begin // row, col starts from (0, 0). modified version
                col <= 0;
                row <= row + 1;
            end
            else begin
                col <= col + 1;
            end
        end
    end

    // control input
    assign row_in = row;
    assign col_in = col;
    assign mux_data_in = bram_data;

    // final output
    assign valid = hvalid && vvalid;

    interface I1(.clk(clk), .resetn(resetn), .input_img(input_img), .HSYNC(HSYNC), .VSYNC(VSYNC),
        .ena(ena), .wea(wea), .addra(addra), .dina(dina), .enb(), .web(), .addrb(), .dinb());

    block_ram B1(.clk(clk), .ena(ena), .wea(wea), .addra(addra[7:0]), .dina(dina[23:0]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[7:0]), .dinb(), .doutb(bram_data[23:0]));
    block_ram B2(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*2-1:8]), .dina(dina[24*2-1:24]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*2-1:8]), .dinb(), .doutb(bram_data[24*2-1:24]));
    block_ram B3(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*3-1:8*2]), .dina(dina[24*3-1:24*2]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*3-1:8*2]), .dinb(), .doutb(bram_data[24*3-1:24*2]));
    block_ram B4(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*4-1:8*3]), .dina(dina[24*4-1:24*3]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*4-1:8*3]), .dinb(), .doutb(bram_data[24*4-1:24*3]));
    block_ram B5(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*5-1:8*4]), .dina(dina[24*5-1:24*4]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*5-1:8*4]), .dinb(), .doutb(bram_data[24*5-1:24*4]));
    block_ram B6(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*6-1:8*5]), .dina(dina[24*6-1:24*5]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*6-1:8*5]), .dinb(), .doutb(bram_data[24*6-1:24*5]));
    block_ram B7(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*7-1:8*6]), .dina(dina[24*7-1:24*6]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*7-1:8*6]), .dinb(), .doutb(bram_data[24*7-1:24*6]));
    block_ram B8(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*8-1:8*7]), .dina(dina[24*8-1:24*7]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*8-1:8*7]), .dinb(), .doutb(bram_data[24*8-1:24*7]));
    block_ram B9(.clk(clk), .ena(ena), .wea(wea), .addra(addra[8*9-1:8*8]), .dina(dina[24*9-1:24*8]), .douta(),
           .enb(ena), .web(1'b0), .addrb(blkram_read_address[8*9-1:8*8]), .dinb(), .doutb(bram_data[24*9-1:24*8]));

    control_unit C1(.clk(clk), .resetn(resetn), .HSYNC_in(HSYNC), .VSYNC_in(VSYNC), .row_in(row_in), .col_in(col_in), .mux_data_in(bram_data),
        .HSYNC_out(HSYNC_out), .VSYNC_out(VSYNC_out), .blkram_read_address(blkram_read_address), .row_out(row_out), .col_out(col_out), .mux_data_out(mux_data_out));

    conv_unit Conv1(.clk(clk), .resetn(resetn), .data(mux_data_out), .pixel_out(pixel_out));
    
    watermark W1(.clk(clk), .resetn(resetn), .data(pixel_out), .row_idx(row_out), .col_idx(col_out), .HSYNC_in(HSYNC_out), .VSYNC_in(VSYNC_out), .start_row(start_row), .start_col(start_col),
            .data_out(output_img), .HSYNC_out(hvalid), .VSYNC_out(vvalid));
// put counter in watermark, valid out after 9 cycles

    //Uncomment this to simply pass the image data to output
    
    
//    always @(posedge clk ) begin
//        if(HSYNC & VSYNC) begin
//            valid <= 1'b1;
//            output_img <= input_img;
//        end
//        else begin
//            valid <= 1'b0;
//            output_img <= 24'dx;
//        end

//    end
endmodule
