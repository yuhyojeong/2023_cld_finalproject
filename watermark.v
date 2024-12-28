module watermark (
    input clk,
    input resetn,

    input [23:0] data,
    input [8:0] row_idx,
    input [9:0] col_idx,
    input HSYNC_in,
    input VSYNC_in,

    input [8:0] start_row,
    input [9:0] start_col,
    
    output reg [23:0] data_out,
    output reg HSYNC_out,
    output reg VSYNC_out
);   

    initial begin
        if (~resetn) begin
            data_out <= 24'b0;
            HSYNC_out <= 0;
            VSYNC_out <= 0;
        end
    end

    always @(negedge resetn) begin
            data_out <= 24'b0;
            HSYNC_out <= 0;
            VSYNC_out <= 0;
    end

    always @(posedge clk && resetn) begin
        if (HSYNC_in && VSYNC_in) begin
            HSYNC_out <= 1;
            VSYNC_out <= 1;
            if (row_idx==start_row) begin
                case (col_idx) 
                    start_col+2 : data_out <= 24'b0;
                    start_col+3 : data_out <= 24'b0;
                    start_col+4 : data_out <= 24'b0;
                    start_col+5 : data_out <= 24'b0;
                    start_col+12 : data_out <= 24'b0;
                    start_col+13 : data_out <= 24'b0;
                    start_col+20 : data_out <= 24'b0;
                    start_col+21 : data_out <= 24'b0;
                    start_col+22 : data_out <= 24'b0;
                    start_col+23 : data_out <= 24'b0;
                    start_col+30 : data_out <= 24'b0;
                    start_col+31 : data_out <= 24'b0;
                    start_col+39 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+47 : data_out <= 24'b0;
                    start_col+48 : data_out <= 24'b0;
                    start_col+49 : data_out <= 24'b0;
                    start_col+50 : data_out <= 24'b0;
                    start_col+56 : data_out <= 24'b0;
                    start_col+57 : data_out <= 24'b0;
                    start_col+58 : data_out <= 24'b0;
                    start_col+59 : data_out <= 24'b0;
                    start_col+65 : data_out <= 24'b0;
                    start_col+66 : data_out <= 24'b0;
                    start_col+67 : data_out <= 24'b0;
                    start_col+68 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+73 : data_out <= 24'b0;
                    start_col+74 : data_out <= 24'b0;
                    start_col+75 : data_out <= 24'b0;
                    start_col+76 : data_out <= 24'b0;
                    start_col+77 : data_out <= 24'b0;
                    start_col+78 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+2-640 : data_out <= 24'b0;
                    start_col+3-640 : data_out <= 24'b0;
                    start_col+4-640 : data_out <= 24'b0;
                    start_col+5-640 : data_out <= 24'b0;
                    start_col+12-640 : data_out <= 24'b0;
                    start_col+13-640 : data_out <= 24'b0;
                    start_col+20-640 : data_out <= 24'b0;
                    start_col+21-640 : data_out <= 24'b0;
                    start_col+22-640 : data_out <= 24'b0;
                    start_col+23-640 : data_out <= 24'b0;
                    start_col+30-640 : data_out <= 24'b0;
                    start_col+31-640 : data_out <= 24'b0;
                    start_col+39-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+47-640 : data_out <= 24'b0;
                    start_col+48-640 : data_out <= 24'b0;
                    start_col+49-640 : data_out <= 24'b0;
                    start_col+50-640 : data_out <= 24'b0;
                    start_col+56-640 : data_out <= 24'b0;
                    start_col+57-640 : data_out <= 24'b0;
                    start_col+58-640 : data_out <= 24'b0;
                    start_col+59-640 : data_out <= 24'b0;
                    start_col+65-640 : data_out <= 24'b0;
                    start_col+66-640 : data_out <= 24'b0;
                    start_col+67-640 : data_out <= 24'b0;
                    start_col+68-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+73-640 : data_out <= 24'b0;
                    start_col+74-640 : data_out <= 24'b0;
                    start_col+75-640 : data_out <= 24'b0;
                    start_col+76-640 : data_out <= 24'b0;
                    start_col+77-640 : data_out <= 24'b0;
                    start_col+78-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+1)||(row_idx==start_row-479)) begin
                case (col_idx)
                    start_col+1 : data_out <= 24'b0;
                    start_col+6 : data_out <= 24'b0;
                    start_col+11 : data_out <= 24'b0;
                    start_col+14 : data_out <= 24'b0;
                    start_col+19 : data_out <= 24'b0;
                    start_col+24 : data_out <= 24'b0;
                    start_col+29 : data_out <= 24'b0;
                    start_col+32 : data_out <= 24'b0;
                    start_col+38 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+46 : data_out <= 24'b0;
                    start_col+51 : data_out <= 24'b0;
                    start_col+55 : data_out <= 24'b0;
                    start_col+60 : data_out <= 24'b0;
                    start_col+64 : data_out <= 24'b0;
                    start_col+69 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+1-640 : data_out <= 24'b0;
                    start_col+6-640 : data_out <= 24'b0;
                    start_col+11-640 : data_out <= 24'b0;
                    start_col+14-640 : data_out <= 24'b0;
                    start_col+19-640 : data_out <= 24'b0;
                    start_col+24-640 : data_out <= 24'b0;
                    start_col+29-640 : data_out <= 24'b0;
                    start_col+32-640 : data_out <= 24'b0;
                    start_col+38-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+46-640 : data_out <= 24'b0;
                    start_col+51-640 : data_out <= 24'b0;
                    start_col+55-640 : data_out <= 24'b0;
                    start_col+60-640 : data_out <= 24'b0;
                    start_col+64-640 : data_out <= 24'b0;
                    start_col+69-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+2)||(row_idx==start_row-478)) begin
                case (col_idx)
                    start_col : data_out <= 24'b0;
                    start_col+7 : data_out <= 24'b0;
                    start_col+10 : data_out <= 24'b0;
                    start_col+15 : data_out <= 24'b0;
                    start_col+18 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+28 : data_out <= 24'b0;
                    start_col+33 : data_out <= 24'b0;
                    start_col+37 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+10-640 : data_out <= 24'b0;
                    start_col+15-640 : data_out <= 24'b0;
                    start_col+18-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+28-640 : data_out <= 24'b0;
                    start_col+33-640 : data_out <= 24'b0;
                    start_col+37-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+3)||(row_idx==start_row-477)) begin
                case (col_idx)
                    start_col+7 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+36 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+36-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+4)||(row_idx==start_row-476)) begin
                case (col_idx)
                    start_col+7 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+5)||(row_idx==start_row-475)) begin
                case (col_idx)
                    start_col+7 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+72 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+72-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+6)||(row_idx==start_row-474)) begin
                case (col_idx)
                    start_col+7 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+46 : data_out <= 24'b0;
                    start_col+51 : data_out <= 24'b0;
                    start_col+55 : data_out <= 24'b0;
                    start_col+60 : data_out <= 24'b0;
                    start_col+64 : data_out <= 24'b0;
                    start_col+69 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+46-640 : data_out <= 24'b0;
                    start_col+51-640 : data_out <= 24'b0;
                    start_col+55-640 : data_out <= 24'b0;
                    start_col+60-640 : data_out <= 24'b0;
                    start_col+64-640 : data_out <= 24'b0;
                    start_col+69-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+7)||(row_idx==start_row-473)) begin
                case (col_idx)
                    start_col+6 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+24 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+47 : data_out <= 24'b0;
                    start_col+50 : data_out <= 24'b0;
                    start_col+56 : data_out <= 24'b0;
                    start_col+59 : data_out <= 24'b0;
                    start_col+65 : data_out <= 24'b0;
                    start_col+68 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+6-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+24-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+47-640 : data_out <= 24'b0;
                    start_col+50-640 : data_out <= 24'b0;
                    start_col+56-640 : data_out <= 24'b0;
                    start_col+59-640 : data_out <= 24'b0;
                    start_col+65-640 : data_out <= 24'b0;
                    start_col+68-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+8)||(row_idx==start_row-472)) begin
                case (col_idx)
                    start_col+5 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+23 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+48 : data_out <= 24'b0;
                    start_col+49 : data_out <= 24'b0;
                    start_col+57 : data_out <= 24'b0;
                    start_col+58 : data_out <= 24'b0;
                    start_col+66 : data_out <= 24'b0;
                    start_col+67 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+5-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+23-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+48-640 : data_out <= 24'b0;
                    start_col+49-640 : data_out <= 24'b0;
                    start_col+57-640 : data_out <= 24'b0;
                    start_col+58-640 : data_out <= 24'b0;
                    start_col+66-640 : data_out <= 24'b0;
                    start_col+67-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+9)||(row_idx==start_row-471)) begin
                case (col_idx)
                    start_col+4 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+22 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+48 : data_out <= 24'b0;
                    start_col+49 : data_out <= 24'b0;
                    start_col+57 : data_out <= 24'b0;
                    start_col+58 : data_out <= 24'b0;
                    start_col+66 : data_out <= 24'b0;
                    start_col+67 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+4-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+22-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+48-640 : data_out <= 24'b0;
                    start_col+49-640 : data_out <= 24'b0;
                    start_col+57-640 : data_out <= 24'b0;
                    start_col+58-640 : data_out <= 24'b0;
                    start_col+66-640 : data_out <= 24'b0;
                    start_col+67-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+10)||(row_idx==start_row-470)) begin
                case (col_idx)
                    start_col+3 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+21 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+47 : data_out <= 24'b0;
                    start_col+50 : data_out <= 24'b0;
                    start_col+56 : data_out <= 24'b0;
                    start_col+59 : data_out <= 24'b0;
                    start_col+65 : data_out <= 24'b0;
                    start_col+68 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+3-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+21-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+47-640 : data_out <= 24'b0;
                    start_col+50-640 : data_out <= 24'b0;
                    start_col+56-640 : data_out <= 24'b0;
                    start_col+59-640 : data_out <= 24'b0;
                    start_col+65-640 : data_out <= 24'b0;
                    start_col+68-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+11)||(row_idx==start_row-469)) begin
                case (col_idx)
                    start_col+2 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+20 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+46 : data_out <= 24'b0;
                    start_col+51 : data_out <= 24'b0;
                    start_col+55 : data_out <= 24'b0;
                    start_col+60 : data_out <= 24'b0;
                    start_col+64 : data_out <= 24'b0;
                    start_col+69 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+2-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+20-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+46-640 : data_out <= 24'b0;
                    start_col+51-640 : data_out <= 24'b0;
                    start_col+55-640 : data_out <= 24'b0;
                    start_col+60-640 : data_out <= 24'b0;
                    start_col+64-640 : data_out <= 24'b0;
                    start_col+69-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+12)||(row_idx==start_row-468)) begin
                case (col_idx)
                    start_col+1 : data_out <= 24'b0;
                    start_col+9 : data_out <= 24'b0;
                    start_col+16 : data_out <= 24'b0;
                    start_col+19 : data_out <= 24'b0;
                    start_col+27 : data_out <= 24'b0;
                    start_col+34 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+1-640 : data_out <= 24'b0;
                    start_col+9-640 : data_out <= 24'b0;
                    start_col+16-640 : data_out <= 24'b0;
                    start_col+19-640 : data_out <= 24'b0;
                    start_col+27-640 : data_out <= 24'b0;
                    start_col+34-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            // else if ((row_idx==start_row+12)||(row_idx==start_row-468)) begin
            //     case (col_idx)
            //         start_col+1 : data_out <= 24'b0;
            //         start_col+9 : data_out <= 24'b0;
            //         start_col+16 : data_out <= 24'b0;
            //         start_col+19 : data_out <= 24'b0;
            //         start_col+27 : data_out <= 24'b0;
            //         start_col+34 : data_out <= 24'b0;
            //         start_col+40 : data_out <= 24'b0;
            //         start_col+45 : data_out <= 24'b0;
            //         start_col+52 : data_out <= 24'b0;
            //         start_col+54 : data_out <= 24'b0;
            //         start_col+61 : data_out <= 24'b0;
            //         start_col+63 : data_out <= 24'b0;
            //         start_col+70 : data_out <= 24'b0;
            //         start_col+79 : data_out <= 24'b0;
            //         start_col+1-640 : data_out <= 24'b0;
            //         start_col+9-640 : data_out <= 24'b0;
            //         start_col+16-640 : data_out <= 24'b0;
            //         start_col+19-640 : data_out <= 24'b0;
            //         start_col+27-640 : data_out <= 24'b0;
            //         start_col+34-640 : data_out <= 24'b0;
            //         start_col+40-640 : data_out <= 24'b0;
            //         start_col+45-640 : data_out <= 24'b0;
            //         start_col+52-640 : data_out <= 24'b0;
            //         start_col+54-640 : data_out <= 24'b0;
            //         start_col+61-640 : data_out <= 24'b0;
            //         start_col+63-640 : data_out <= 24'b0;
            //         start_col+70-640 : data_out <= 24'b0;
            //         start_col+79-640 : data_out <= 24'b0;
            //         default : data_out <= data;
            //     endcase
            // end
            
            else if ((row_idx==start_row+13)||(row_idx==start_row-467)) begin
                case (col_idx)
                    start_col : data_out <= 24'b0;
                    start_col+10 : data_out <= 24'b0;
                    start_col+15 : data_out <= 24'b0;
                    start_col+18 : data_out <= 24'b0;
                    start_col+28 : data_out <= 24'b0;
                    start_col+33 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+10-640 : data_out <= 24'b0;
                    start_col+15-640 : data_out <= 24'b0;
                    start_col+18-640 : data_out <= 24'b0;
                    start_col+28-640 : data_out <= 24'b0;
                    start_col+33-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+14)||(row_idx==start_row-466)) begin
                case (col_idx)
                    start_col : data_out <= 24'b0;
                    start_col+11 : data_out <= 24'b0;
                    start_col+14 : data_out <= 24'b0;
                    start_col+18 : data_out <= 24'b0;
                    start_col+29 : data_out <= 24'b0;
                    start_col+32 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+11-640 : data_out <= 24'b0;
                    start_col+14-640 : data_out <= 24'b0;
                    start_col+18-640 : data_out <= 24'b0;
                    start_col+29-640 : data_out <= 24'b0;
                    start_col+32-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else if ((row_idx==start_row+15)||(row_idx==start_row-465)) begin
                case (col_idx)
                    start_col : data_out <= 24'b0;
                    start_col+1 : data_out <= 24'b0;
                    start_col+2 : data_out <= 24'b0;
                    start_col+3 : data_out <= 24'b0;
                    start_col+4 : data_out <= 24'b0;
                    start_col+5 : data_out <= 24'b0;
                    start_col+6 : data_out <= 24'b0;
                    start_col+7 : data_out <= 24'b0;
                    start_col+12 : data_out <= 24'b0;
                    start_col+13 : data_out <= 24'b0;
                    start_col+18 : data_out <= 24'b0;
                    start_col+19 : data_out <= 24'b0;
                    start_col+20 : data_out <= 24'b0;
                    start_col+21 : data_out <= 24'b0;
                    start_col+22 : data_out <= 24'b0;
                    start_col+23 : data_out <= 24'b0;
                    start_col+24 : data_out <= 24'b0;
                    start_col+25 : data_out <= 24'b0;
                    start_col+30 : data_out <= 24'b0;
                    start_col+31 : data_out <= 24'b0;
                    start_col+36 : data_out <= 24'b0;
                    start_col+37 : data_out <= 24'b0;
                    start_col+38 : data_out <= 24'b0;
                    start_col+39 : data_out <= 24'b0;
                    start_col+40 : data_out <= 24'b0;
                    start_col+41 : data_out <= 24'b0;
                    start_col+42 : data_out <= 24'b0;
                    start_col+43 : data_out <= 24'b0;
                    start_col+45 : data_out <= 24'b0;
                    start_col+46 : data_out <= 24'b0;
                    start_col+47 : data_out <= 24'b0;
                    start_col+48 : data_out <= 24'b0;
                    start_col+49 : data_out <= 24'b0;
                    start_col+50 : data_out <= 24'b0;
                    start_col+51 : data_out <= 24'b0;
                    start_col+52 : data_out <= 24'b0;
                    start_col+54 : data_out <= 24'b0;
                    start_col+55 : data_out <= 24'b0;
                    start_col+56 : data_out <= 24'b0;
                    start_col+57 : data_out <= 24'b0;
                    start_col+58 : data_out <= 24'b0;
                    start_col+59 : data_out <= 24'b0;
                    start_col+60 : data_out <= 24'b0;
                    start_col+61 : data_out <= 24'b0;
                    start_col+63 : data_out <= 24'b0;
                    start_col+64 : data_out <= 24'b0;
                    start_col+65 : data_out <= 24'b0;
                    start_col+66 : data_out <= 24'b0;
                    start_col+67 : data_out <= 24'b0;
                    start_col+68 : data_out <= 24'b0;
                    start_col+69 : data_out <= 24'b0;
                    start_col+70 : data_out <= 24'b0;
                    start_col+79 : data_out <= 24'b0;
                    start_col+1-640 : data_out <= 24'b0;
                    start_col+2-640 : data_out <= 24'b0;
                    start_col+3-640 : data_out <= 24'b0;
                    start_col+4-640 : data_out <= 24'b0;
                    start_col+5-640 : data_out <= 24'b0;
                    start_col+6-640 : data_out <= 24'b0;
                    start_col+7-640 : data_out <= 24'b0;
                    start_col+12-640 : data_out <= 24'b0;
                    start_col+13-640 : data_out <= 24'b0;
                    start_col+18-640 : data_out <= 24'b0;
                    start_col+19-640 : data_out <= 24'b0;
                    start_col+20-640 : data_out <= 24'b0;
                    start_col+21-640 : data_out <= 24'b0;
                    start_col+22-640 : data_out <= 24'b0;
                    start_col+23-640 : data_out <= 24'b0;
                    start_col+24-640 : data_out <= 24'b0;
                    start_col+25-640 : data_out <= 24'b0;
                    start_col+30-640 : data_out <= 24'b0;
                    start_col+31-640 : data_out <= 24'b0;
                    start_col+36-640 : data_out <= 24'b0;
                    start_col+37-640 : data_out <= 24'b0;
                    start_col+38-640 : data_out <= 24'b0;
                    start_col+39-640 : data_out <= 24'b0;
                    start_col+40-640 : data_out <= 24'b0;
                    start_col+41-640 : data_out <= 24'b0;
                    start_col+42-640 : data_out <= 24'b0;
                    start_col+43-640 : data_out <= 24'b0;
                    start_col+45-640 : data_out <= 24'b0;
                    start_col+46-640 : data_out <= 24'b0;
                    start_col+47-640 : data_out <= 24'b0;
                    start_col+48-640 : data_out <= 24'b0;
                    start_col+49-640 : data_out <= 24'b0;
                    start_col+50-640 : data_out <= 24'b0;
                    start_col+51-640 : data_out <= 24'b0;
                    start_col+52-640 : data_out <= 24'b0;
                    start_col+54-640 : data_out <= 24'b0;
                    start_col+55-640 : data_out <= 24'b0;
                    start_col+56-640 : data_out <= 24'b0;
                    start_col+57-640 : data_out <= 24'b0;
                    start_col+58-640 : data_out <= 24'b0;
                    start_col+59-640 : data_out <= 24'b0;
                    start_col+60-640 : data_out <= 24'b0;
                    start_col+61-640 : data_out <= 24'b0;
                    start_col+63-640 : data_out <= 24'b0;
                    start_col+64-640 : data_out <= 24'b0;
                    start_col+65-640 : data_out <= 24'b0;
                    start_col+66-640 : data_out <= 24'b0;
                    start_col+67-640 : data_out <= 24'b0;
                    start_col+68-640 : data_out <= 24'b0;
                    start_col+69-640 : data_out <= 24'b0;
                    start_col+70-640 : data_out <= 24'b0;
                    start_col+79-640 : data_out <= 24'b0;
                    default : data_out <= data;
                endcase
            end
            
            else begin
                data_out <= data;
            end
        end
        
        else if ((~HSYNC_in) && VSYNC_in) begin
            HSYNC_out <= 0;
            VSYNC_out <= 1;
            data_out <= 24'b0;
        end
        
        else if (HSYNC_in && (~VSYNC_in)) begin
            HSYNC_out <= 1;
            VSYNC_out <= 0;
            data_out <= 24'b0;
        end
        
        else begin
            HSYNC_out <= 0;
            VSYNC_out <= 0;
            data_out <= 24'b0;
        end
    end
endmodule