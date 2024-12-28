module interface(
    input clk,
    input resetn,
    input [23:0] input_img,
    input HSYNC,
    input VSYNC,    

    output ena,
    output wea,
    output [9*8-1:0] addra,
    output [9*24-1:0] dina,

    output enb,
    output web,
    output [9*8-1:0] addrb,
    output [9*24-1:0] dinb
);
    reg output_ena;
    reg output_wea;
    reg [9*8-1:0] output_addra;
    reg [9*24-1:0] output_dina;

    reg [7:0] addrindex;
    reg [3:0] bram;
    reg [9:0] count;
    reg [3:0] bramcount;

    initial begin
        if (~resetn) begin
            addrindex <= 0;
            output_ena <= 0;
            output_wea <= 0;
            output_addra <= 0;
            output_dina <= 0;
            bram <= 0;
            count <= 0;
            bramcount <= 0;
        end
    end

    always @(negedge resetn) begin
            addrindex <= 0;
            output_ena <= 0;
            output_wea <= 0;
            output_addra <= 0;
            output_dina <= 0;
            bram <= 0;
            count <= 0;
            bramcount <= 0;
    end

    always @(posedge clk && resetn) begin
        if (HSYNC && VSYNC) begin
            output_addra = 0;
            count = count + 1;
            output_ena = 1;
            output_wea = 1;
            bram = bram + 1;
            bramcount = bramcount + 1;
            output_dina = input_img;
            if (count == 10'd640 || count == 10'b1 || bramcount == 4'd1) begin
                if (addrindex != 0 && count == 10'b1) begin
                    bramcount = 4'b1;
                    case(bram)
                    4'd1: bram = 4'd3;
                    4'd2: bram = 4'd4;
                    4'd3: bram = 4'd5;
                    4'd4: bram = 4'd6;
                    4'd5: bram = 4'd7;
                    4'd6: bram = 4'd8;
                    4'd7: bram = 4'd9;
                    4'd8: bram = 4'd1;
                    4'd9: bram = 4'd2;
                    default: ;
                    endcase
                end
                if (count == 10'd640) begin
                    count = 10'b0;
                end
                addrindex = addrindex + 1;
            end

            case(bram)
            4'd2: output_dina = output_dina << 24;
            4'd3: output_dina = output_dina << 24*2;
            4'd4: output_dina = output_dina << 24*3;
            4'd5: output_dina = output_dina << 24*4;
            4'd6: output_dina = output_dina << 24*5;
            4'd7: output_dina = output_dina << 24*6;
            4'd8: output_dina = output_dina << 24*7;
            4'd9: output_dina = output_dina << 24*8;
            default: ;
            endcase

            if (bram == 4'd9) begin
                bram = 4'b0;
            end
            
            if (bramcount == 4'd9) begin
                bramcount = 4'b0;
            end

            if (addrindex == 8'd217) begin
                addrindex = 8'd1;
            end

            output_addra = addrindex;
            case(bram)
            4'd2: output_addra = output_addra << 8;
            4'd3: output_addra = output_addra << 8*2;
            4'd4: output_addra = output_addra << 8*3;
            4'd5: output_addra = output_addra << 8*4;
            4'd6: output_addra = output_addra << 8*5;
            4'd7: output_addra = output_addra << 8*6;
            4'd8: output_addra = output_addra << 8*7;
            4'd0: output_addra = output_addra << 8*8;
            default: ;
            endcase
        end
    end

    assign ena = output_ena;
    assign wea = output_wea;
    assign addra = output_addra;
    assign dina = output_dina;
endmodule