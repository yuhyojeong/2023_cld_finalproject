module control_unit (
    input clk, 
    input resetn,

    input HSYNC_in, // valid
    input VSYNC_in,

    input [8:0] row_in, // current pixel coord.
    input [9:0] col_in,
    input [24*9-1:0] mux_data_in, // read from bram

    output reg HSYNC_out, // result valid
    output reg VSYNC_out,

    output [8*9-1:0] blkram_read_address, // index of 9 pixels

    output reg [8:0] row_out, // pixel coord. after conv.
    output reg [9:0] col_out,
    output reg [24*9-1:0] mux_data_out
);
    reg [8*9-1:0] pixel_index1; // blkram_read_address
    reg [8*9-1:0] pixel_index2;
    reg [7:0] target_index;
    reg [3:0] ram;
    reg [3:0] ramcount;
    reg [3:0] delayram1;
    reg [3:0] delayram2;
    reg [8:0] realrow;
    reg [9:0] realcol;

    reg delayh1;
    reg delayv1;
    reg delayh2;
    reg delayv2;
    reg delayh3;
    reg delayv3;
    reg delayh4;
    reg delayv4;
    reg rowdelay;
    reg coldelay;

    initial begin
        if (~resetn) begin
            HSYNC_out <= 0;
            VSYNC_out <= 0;
            row_out <= 0;
            // col_out <= 0; // originial (0, 1)
            col_out <= -1; // modified (0, 0)
            mux_data_out <= 0;
            pixel_index1 <= 0;
            pixel_index2 <= 0;
            target_index <= 0;
            ram <= 0;
            ramcount <= 0;
            delayram1 <= 0;
            delayram2 <= 0;
            realrow <= 0;
//            realcol <= 0; // original (0,1)
            realcol <= -1; // modified (0,0)
            delayh1 <= 0;
            delayv1 <= 0;
            delayh2 <= 0;
            delayv2 <= 0;
            delayh3 <= 0;
            delayv3 <= 0;
            delayh4 <= 0;
            delayv4 <= 0;
            rowdelay <= 0;
            coldelay <= 0;
        end
    end

    always @(negedge resetn) begin
        HSYNC_out <= 0;
        VSYNC_out <= 0;
        row_out <= 0;
        // col_out <= 0; // original (0,1)
        col_out <= -1; // modified (0,0)
        mux_data_out <= 0;
        pixel_index1 <= 0;
        pixel_index2 <= 0;
        target_index <= 0;
        ram <= 0;
        ramcount <= 0;
        delayram1 <= 0;
        delayram2 <= 0;
        realrow <= 0;
//        realcol <= 0; // original (0,1)
        realcol <= -1; // modified (0,0)
        delayh1 <= 0;
        delayv1 <= 0;
        delayh2 <= 0;
        delayv2 <= 0;
        delayh3 <= 0;
        delayv3 <= 0;
        delayh4 <= 0;
        delayv4 <= 0;
    end

    always @(posedge clk && resetn) begin
        coldelay = HSYNC_out;
        rowdelay = VSYNC_out;
        HSYNC_out = delayh4;
        VSYNC_out = delayv4;
        delayh4 = delayh3;
        delayv4 = delayv3;
        delayh3 = delayh2;
        delayv3 = delayv2;
        delayh2 = delayh1;
        delayv2 = delayv1;
        if (rowdelay && coldelay) begin
            col_out = col_out + 1;
//                if (col_out == 10'd641) begin // original (0,1)
//                    col_out = 10'd1;
            if (col_out == 10'd640) begin // modified (0,0)
                col_out = 10'd0;
                row_out = row_out + 1;
            end
        end
//        if (HSYNC_in && VSYNC_in || {row_in, col_in} >= {9'd479, 10'd640}) begin // original code (0,1)
        if (HSYNC_in && VSYNC_in || {row_in, col_in} >= {9'd479, 10'd639}) begin // modified code (0,0)
            // target row, col
//            if ({row_in, col_in} >= {9'b1, 10'd2}) begin // original code (0,1)
            if ({row_in, col_in} >= {9'b1, 10'd1}) begin // modified (0,0)
                delayh1 = 1;
                delayv1 = 1;
                delayram2 = delayram1;
                delayram1 = ram;
                realcol = realcol + 1;
                ram = ram + 1;
                ramcount = ramcount + 1;
//                if (realcol == 10'd641) begin // original (0,1)
//                    realcol = 10'd1;
                if (realcol == 10'd640) begin // modified (0,0)
                    realcol = 10'd0;
                    realrow = realrow + 1;
                end
                if (ram == 4'd10) begin
                    ram = 4'b1;
                end
                if (ramcount == 4'd10) begin
                    ramcount = 4'b1;
                end
//                if (realcol == 10'd640 || realcol == 10'b1 || ramcount == 4'd1) begin // original (0,1)
//                    if (target_index != 0 && realcol == 10'b1) begin
                if (realcol == 10'd639 || realcol == 10'b0 || ramcount == 4'd1) begin // modified (0,0)
                    if (target_index != 0 && realcol == 10'b0) begin
                        ramcount = 4'd1;
                        case(ram)
                        4'd1: ram = 4'd3;
                        4'd2: ram = 4'd4;
                        4'd3: ram = 4'd5;
                        4'd4: ram = 4'd6;
                        4'd5: ram = 4'd7;
                        4'd6: ram = 4'd8;
                        4'd7: ram = 4'd9;
                        4'd8: ram = 4'd1;
                        4'd9: ram = 4'd2;
                        default: ;
                        endcase
                    end
                    target_index = target_index + 1;
                end

                if (target_index == 8'd217) begin
                    target_index = 8'd1;
                end

                pixel_index1 = 0;
                pixel_index2 = 0;
                if (realrow == 0) begin
//                    if (realcol == 1) begin // original (0,1) // upperleft corner 5689
                    if (realcol == 0) begin // modified (0,0)
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*6-1:8*5] = target_index;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index + 8'd72 : target_index-144;
                        pixel_index1[8*9-1:8*8] = (target_index <= 144) ? target_index + 8'd72 : target_index-144;
                    end
//                    else if (realcol == 640) begin // original (0,1) // upperright corner 4578
                    else if (realcol == 639) begin // modified (0,0)
                        pixel_index1[8*4-1:8*3] = target_index-1;
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*7-1:8*6] = (target_index <= 145) ? target_index + 71 : target_index-145;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index + 72 : target_index-144;
                    end
                    else begin // upper edge 456789
                        if (ramcount == 1) begin
                            pixel_index1[8*4-1:8*3] = target_index >= 2 ? target_index - 1 : target_index + 215;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        else if (ramcount == 9) begin
                            pixel_index1[8*4-1:8*3] = target_index;
                            pixel_index1[8*6-1:8*5] = target_index <= 215 ? target_index + 1 : target_index-215;
                        end
                        else begin
                            pixel_index1[8*4-1:8*3] = target_index;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*7-1:8*6] = (pixel_index1[8*4-1:8*3] <= 144) ? pixel_index1[8*4-1:8*3] + 72 : pixel_index1[8*4-1:8*3]-144;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index + 72 : target_index-144;
                        pixel_index1[8*9-1:8*8] = (pixel_index1[8*6-1:8*5] <= 144) ? pixel_index1[8*6-1:8*5] + 72 : pixel_index1[8*6-1:8*5]-144;
                    end
                end
                else if (realrow == 479) begin
//                    if (realcol == 1) begin // original (0,1) // lowerleft corner 2356
                    if (realcol == 0) begin // modified (0,0)
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*3-1:8*2] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*6-1:8*5] = target_index;
                    end
//                    else if (realcol == 640) begin // original (0,1) // lowerright corner 1245
                    else if (realcol == 639) begin // modified (0,0)
                        pixel_index1[8*1-1:0] = (target_index >= 74) ? target_index-73 : target_index +143;
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*4-1:8*3] = target_index-1;
                        pixel_index1[8*5-1:8*4] = target_index;
                    end
                    else begin // lower edge 123456
                        if (ramcount == 1) begin
                            pixel_index1[8*4-1:8*3] = target_index >= 2 ? target_index-1 : target_index + 215;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        else if (ramcount == 9) begin
                            pixel_index1[8*4-1:8*3] = target_index;
                            pixel_index1[8*6-1:8*5] = target_index <= 215 ? target_index + 1 : target_index-215;
                        end
                        else begin
                            pixel_index1[8*4-1:8*3] = target_index;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        pixel_index1[8*1-1:0] = (pixel_index1[8*4-1:8*3] >= 73) ? pixel_index1[8*4-1:8*3]-72 : pixel_index1[8*4-1:8*3] +144;
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*3-1:8*2] = (pixel_index1[8*6-1:8*5] >= 73) ? pixel_index1[8*6-1:8*5]-72 : pixel_index1[8*6-1:8*5]+144;
                        pixel_index1[8*5-1:8*4] = target_index;                    
                        end
                end
                else begin
//                    if (realcol == 1) begin // original (0,1) // left edge 235689
                    if (realcol == 0) begin // modified (0,0)
                        if (ramcount == 9) begin
                            pixel_index1[8*6-1:8*5] = target_index <= 215 ? target_index + 1 : target_index -215;
                        end
                        else begin
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*3-1:8*2] = (pixel_index1[8*6-1:8*5] >= 73) ? pixel_index1[8*6-1:8*5]-72 : pixel_index1[8*6-1:8*5] +144;                        
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index+72 : target_index -144;
                        pixel_index1[8*9-1:8*8] = (pixel_index1[8*6-1:8*5] <= 144) ? pixel_index1[8*6-1:8*5]+72 : pixel_index1[8*6-1:8*5] -144;
                    end
//                    else if (realcol == 640) begin // original (0,1) // right edge 124578
                    else if (realcol == 639) begin // modified (0,0)
                        if (ramcount == 1) begin
                            pixel_index1[8*4-1:8*3] = target_index >=2 ? target_index-1 : target_index+215;
                        end
                        else begin
                            pixel_index1[8*4-1:8*3] = target_index;
                        end
                        pixel_index1[8*1-1:0] = (pixel_index1[8*4-1:8*3] >= 73) ? pixel_index1[8*4-1:8*3]-72 : pixel_index1[8*4-1:8*3] +144;
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*7-1:8*6] = (pixel_index1[8*4-1:8*3] <= 144) ? pixel_index1[8*4-1:8*3]+72 : pixel_index1[8*4-1:8*3] -144;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index+72 : target_index -144;
                    end
                    else begin // middle 123456789
                        if (ramcount == 1) begin
                            pixel_index1[8*4-1:8*3] = target_index >= 2 ? target_index - 1 : target_index + 215;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        else if (ramcount == 9) begin
                            pixel_index1[8*6-1:8*5] = target_index <= 215 ? target_index+1 : target_index - 215;
                            pixel_index1[8*4-1:8*3] = target_index;
                        end
                        else begin
                            pixel_index1[8*4-1:8*3] = target_index;
                            pixel_index1[8*6-1:8*5] = target_index;
                        end
                        pixel_index1[8*1-1:0] = (pixel_index1[8*4-1:8*3] >= 73) ? pixel_index1[8*4-1:8*3]-72 : pixel_index1[8*4-1:8*3] +144;
                        pixel_index1[8*3-1:8*2] = (pixel_index1[8*6-1:8*5] >= 73) ? pixel_index1[8*6-1:8*5]-72 : pixel_index1[8*6-1:8*5] +144;
                        pixel_index1[8*2-1:8*1] = (target_index >= 73) ? target_index-72 : target_index +144;
                        pixel_index1[8*5-1:8*4] = target_index;
                        pixel_index1[8*7-1:8*6] = (pixel_index1[8*4-1:8*3] <= 144) ? pixel_index1[8*4-1:8*3]+72 : pixel_index1[8*4-1:8*3] -144;
                        pixel_index1[8*8-1:8*7] = (target_index <= 144) ? target_index+72 : target_index -144;
                        pixel_index1[8*9-1:8*8] = (pixel_index1[8*6-1:8*5] <= 144) ? pixel_index1[8*6-1:8*5]+72 : pixel_index1[8*6-1:8*5] -144;
                    end
                end
                case(ram)
                4'd1: begin
                    pixel_index2 = pixel_index1 << 8*5;
                    pixel_index2[8*5-1:0] = pixel_index1 >> 8*4;
                end
                4'd2: begin
                    pixel_index2 = pixel_index1 << 8*6;
                    pixel_index2[8*6-1:0] = pixel_index1 >> 8*3;
                end
                4'd3: begin
                    pixel_index2 = pixel_index1 << 8*7;
                    pixel_index2[8*7-1:0] = pixel_index1 >> 8*2;
                end
                4'd4: begin
                    pixel_index2 = pixel_index1 << 8*8;
                    pixel_index2[8*8-1:0] = pixel_index1 >> 8*1;
                end
                4'd5: begin
                    pixel_index2 = pixel_index1;
                end
                4'd6: begin
                    pixel_index2 = pixel_index1 << 8*1;
                    pixel_index2[8*1-1:0] = pixel_index1 >> 8*8;
                end
                4'd7: begin
                    pixel_index2 = pixel_index1 << 8*2;
                    pixel_index2[8*2-1:0] = pixel_index1 >> 8*7;
                end
                4'd8: begin
                    pixel_index2 = pixel_index1 << 8*3;
                    pixel_index2[8*3-1:0] = pixel_index1 >> 8*6;
                end
                4'd9: begin
                    pixel_index2 = pixel_index1 << 8*4;
                    pixel_index2[8*4-1:0] = pixel_index1 >> 8*5;
                end
                default: ;
                endcase
            end
//            if ({realrow, realcol} >= {9'b0, 10'd2}) begin // original (0,1)
            if (realcol <= 10'd639 && {realrow, realcol} >= {9'b0, 10'd1}) begin // modified (0,0)
                case(delayram2)
                4'd1: begin
                    mux_data_out[24-1:0] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24-1:0];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*5-1:24*4];
                end
                4'd2: begin
                    mux_data_out[24-1:0] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*4-1:24*3] = mux_data_in[23:0];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*6-1:24*5];
                end
                4'd3: begin
                    mux_data_out[24-1:0] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*3-1:24*2] = mux_data_in[23:0];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*7-1:24*6];
                end
                4'd4: begin
                    mux_data_out[24-1:0] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*2-1:24*1] = mux_data_in[23:0];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*8-1:24*7];
                end
                4'd5: begin
                    mux_data_out = mux_data_in;
                end
                4'd6: begin
                    mux_data_out[24-1:0] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*9-1:24*8] = mux_data_in[23:0];
                end
                4'd7: begin
                    mux_data_out[24-1:0] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*8-1:24*7] = mux_data_in[23:0];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*2-1:24*1];
                end
                4'd8: begin
                    mux_data_out[24-1:0] = mux_data_in[24*4-1:24*3];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*6-1:24*5] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*7-1:24*6] = mux_data_in[23:0];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*3-1:24*2];
                end
                4'd9: begin
                    mux_data_out[24-1:0] = mux_data_in[24*5-1:24*4];
                    mux_data_out[24*2-1:24*1] = mux_data_in[24*6-1:24*5];
                    mux_data_out[24*3-1:24*2] = mux_data_in[24*7-1:24*6];
                    mux_data_out[24*4-1:24*3] = mux_data_in[24*8-1:24*7];
                    mux_data_out[24*5-1:24*4] = mux_data_in[24*9-1:24*8];
                    mux_data_out[24*6-1:24*5] = mux_data_in[23:0];
                    mux_data_out[24*7-1:24*6] = mux_data_in[24*2-1:24*1];
                    mux_data_out[24*8-1:24*7] = mux_data_in[24*3-1:24*2];
                    mux_data_out[24*9-1:24*8] = mux_data_in[24*4-1:24*3];
                end
                default: ;
                endcase
            end
//            if ({realrow, realcol} >= {9'b0, 10'd5}) begin // original (0,1)
//             if (realcol <= 10'd639 && {realrow, realcol} >= {9'b0, 10'd4}) begin // modified (0,0)
// //                if (realcol >= 5) begin // original (0,1)
//                 if (realcol >= 4) begin // modified (0,0)
//                     row_out = realrow;
//                     col_out = realcol - 4;
//                 end
//                 else begin
//                     row_out = realrow - 1;
//                     col_out = realcol + 636;
//                 end
//             end
        end
        else if (~HSYNC_in && VSYNC_in) begin
            delayh1 = 0;
            delayv1 = 1;
        end
        else if (HSYNC_in && ~VSYNC_in) begin
            delayh1 = 1;
            delayv1 = 0;
        end
        else begin
            delayh1 = 0;
            delayv1 = 0;
        end
    end
    assign blkram_read_address = pixel_index2;

endmodule