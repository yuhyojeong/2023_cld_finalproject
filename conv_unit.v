module full_adder(
    input A,
    input B,
    input Cin,
    output OUT,
    output Cout);
    
    wire nA, nB, nC, N1, N2, N3, N4, N5, N6, N7, M1, M2, M3, M4, M5, M6;

    /*Implement the full adder using gates*/
    not K1(nA, A);
    not K2(nB, B);
    not K3(nC, Cin);
    and U1(N1, Cin, A);
    and U2(N2, Cin, B);
    and U3(N3, B, A);
    or U4(Cout, N1, N2, N3);
    and U5(M1, nA, nB);
    and U6(N4, Cin, M1);
    and U7(M2, A, B);
    and U8(N5, Cin, M2);
    and U9(M3, nA, B);
    and U10(N6, nC, M3);
    and U11(M4, A, nB);
    and U12(N7, nC, M4);
    or U13(M5, N4, N5);
    or U14(M6, N6, N7);
    or U15(OUT, M5, M6);

endmodule

module ripple_carry_adder_12bit(
    input [11:0] A,
    input [11:0] B,
    output [11:0] OUT);
    wire C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,Cout;

    /*Implement 4-bit ripple-carry-adder using full adder that you implemented above*/
    full_adder U1(A[0], B[0], 1'b0, OUT[0], C0);
    full_adder U2(A[1], B[1], C0, OUT[1], C1);
    full_adder U3(A[2], B[2], C1, OUT[2], C2);
    full_adder U4(A[3], B[3], C2, OUT[3], C3);
    full_adder U5(A[4], B[4], C3, OUT[4], C4);
    full_adder U6(A[5], B[5], C4, OUT[5], C5);
    full_adder U7(A[6], B[6], C5, OUT[6], C6);
    full_adder U8(A[7], B[7], C6, OUT[7], C7);
    full_adder U9(A[8], B[8], C7, OUT[8], C8);
    full_adder U10(A[9], B[9], C8, OUT[9], C9);
    full_adder U11(A[10], B[10], C9, OUT[10], C10);
    full_adder U12(A[11], B[11], C10, OUT[11], Cout);

endmodule

module ripple_carry_adder_12bit9(
    input [11:0] A,
    input [11:0] B,
    input [11:0] C,
    input [11:0] D,
    input [11:0] E,
    input [11:0] F,
    input [11:0] G,
    input [11:0] H,
    input [11:0] I,
    output [11:0] OUT);
    wire [11:0] K0,K1,K2,K3,K4,K5,K6;

    /*Implement 4-bit ripple-carry-adder using full adder that you implemented above*/
    ripple_carry_adder_12bit U1(A, B, K0);
    ripple_carry_adder_12bit U2(K0, C, K1);
    ripple_carry_adder_12bit U3(K1, D, K2);
    ripple_carry_adder_12bit U4(K2, E, K3);
    ripple_carry_adder_12bit U5(K3, F, K4);
    ripple_carry_adder_12bit U6(K4, G, K5);
    ripple_carry_adder_12bit U7(K5, H, K6);
    ripple_carry_adder_12bit U8(K6, I, OUT);

endmodule



module conv_unit (
    input clk,
    input resetn,

    input [24*9-1:0] data,
    
    output [23:0] pixel_out
    );
    reg [11:0] P000, P010, P020, P100, P110, P120, P200, P210, P220,
        P001, P011, P021, P101, P111, P121, P201, P211, P221,
        P002, P012, P022, P102, P112, P122, P202, P212, P222; //Pixel row, col, RGB(0~2)
    reg [11:0] tP [26:0];
    wire [11:0] Pxx0, Pxx1, Pxx2;//All pixels' sum of RGB(0~2)
    
    initial begin
        if (~resetn) begin
            P000 <= 12'b0;
            P010 <= 12'b0;
            P020 <= 12'b0;
            P100 <= 12'b0;
            P110 <= 12'b0;
            P120 <= 12'b0;
            P200 <= 12'b0;
            P210 <= 12'b0;
            P220 <= 12'b0;
            P001 <= 12'b0;
            P011 <= 12'b0;
            P021 <= 12'b0;
            P101 <= 12'b0;
            P111 <= 12'b0;
            P121 <= 12'b0;
            P201 <= 12'b0;
            P211 <= 12'b0;
            P221 <= 12'b0;
            P002 <= 12'b0;
            P012 <= 12'b0;
            P022 <= 12'b0;
            P102 <= 12'b0;
            P112 <= 12'b0;
            P122 <= 12'b0;
            P202 <= 12'b0;
            P212 <= 12'b0;
            P222 <= 12'b0;
            tP[0] <= 12'b0;
            tP[1] <= 12'b0;
            tP[2] <= 12'b0;
            tP[3] <= 12'b0;
            tP[4] <= 12'b0;
            tP[5] <= 12'b0;
            tP[6] <= 12'b0;
            tP[7] <= 12'b0;
            tP[8] <= 12'b0;
            tP[9] <= 12'b0;
            tP[10] <= 12'b0;
            tP[11] <= 12'b0;
            tP[12] <= 12'b0;
            tP[13] <= 12'b0;
            tP[14] <= 12'b0;
            tP[15] <= 12'b0;
            tP[16] <= 12'b0;
            tP[17] <= 12'b0;
            tP[18] <= 12'b0;
            tP[19] <= 12'b0;
            tP[20] <= 12'b0;
            tP[21] <= 12'b0;
            tP[22] <= 12'b0;
            tP[23] <= 12'b0;
            tP[24] <= 12'b0;
            tP[25] <= 12'b0;
            tP[26] <= 12'b0;
        end
    end
    
    always @(negedge resetn) begin
            P000 <= 12'b0;
            P010 <= 12'b0;
            P020 <= 12'b0;
            P100 <= 12'b0;
            P110 <= 12'b0;
            P120 <= 12'b0;
            P200 <= 12'b0;
            P210 <= 12'b0;
            P220 <= 12'b0;
            P001 <= 12'b0;
            P011 <= 12'b0;
            P021 <= 12'b0;
            P101 <= 12'b0;
            P111 <= 12'b0;
            P121 <= 12'b0;
            P201 <= 12'b0;
            P211 <= 12'b0;
            P221 <= 12'b0;
            P002 <= 12'b0;
            P012 <= 12'b0;
            P022 <= 12'b0;
            P102 <= 12'b0;
            P112 <= 12'b0;
            P122 <= 12'b0;
            P202 <= 12'b0;
            P212 <= 12'b0;
            P222 <= 12'b0;
            tP[0] <= 12'b0;
            tP[1] <= 12'b0;
            tP[2] <= 12'b0;
            tP[3] <= 12'b0;
            tP[4] <= 12'b0;
            tP[5] <= 12'b0;
            tP[6] <= 12'b0;
            tP[7] <= 12'b0;
            tP[8] <= 12'b0;
            tP[9] <= 12'b0;
            tP[10] <= 12'b0;
            tP[11] <= 12'b0;
            tP[12] <= 12'b0;
            tP[13] <= 12'b0;
            tP[14] <= 12'b0;
            tP[15] <= 12'b0;
            tP[16] <= 12'b0;
            tP[17] <= 12'b0;
            tP[18] <= 12'b0;
            tP[19] <= 12'b0;
            tP[20] <= 12'b0;
            tP[21] <= 12'b0;
            tP[22] <= 12'b0;
            tP[23] <= 12'b0;
            tP[24] <= 12'b0;
            tP[25] <= 12'b0;
            tP[26] <= 12'b0;
    end
    
    always @(posedge clk && resetn) begin
        
        P000 <= data[215:208];
        P001 <= data[207:200];
        P002 <= data[199:192];
        P010 <= data[191:184];
        P011 <= data[183:176];
        P012 <= data[175:168];
        P020 <= data[167:160];
        P021 <= data[159:152];
        P022 <= data[151:144];
        P100 <= data[143:136];
        P101 <= data[135:128];
        P102 <= data[127:120];
        P110 <= data[119:112];
        P111 <= data[111:104];
        P112 <= data[103:96];
        P120 <= data[95:88];
        P121 <= data[87:80];
        P122 <= data[79:72];
        P200 <= data[71:64];
        P201 <= data[63:56];
        P202 <= data[55:48];
        P210 <= data[47:40];
        P211 <= data[39:32];
        P212 <= data[31:24];
        P220 <= data[23:16];
        P221 <= data[15:8];
        P222 <= data[7:0];
        
        tP[0] <= P000;
        tP[1] <= P001;
        tP[2] <= P002;
        tP[3] <= P010<<1;
        tP[4] <= P011<<1;
        tP[5] <= P012<<1;
        tP[6] <= P020;
        tP[7] <= P021;
        tP[8] <= P022;
        tP[9] <= P100<<1;
        tP[10] <= P101<<1;
        tP[11] <= P102<<1;
        tP[12] <= P110<<2;
        tP[13] <= P111<<2;
        tP[14] <= P112<<2;
        tP[15] <= P120<<1;
        tP[16] <= P121<<1;
        tP[17] <= P122<<1;
        tP[18] <= P200;
        tP[19] <= P201;
        tP[20] <= P202;
        tP[21] <= P210<<1;
        tP[22] <= P211<<1;
        tP[23] <= P212<<1;
        tP[24] <= P220;
        tP[25] <= P221;
        tP[26] <= P222;
        
    end
    ripple_carry_adder_12bit9 U1(.A(tP[0]), .B(tP[3]), .C(tP[6]), .D(tP[9]), .E(tP[12]), .F(tP[15]), .G(tP[18]), .H(tP[21]), .I(tP[24]), .OUT(Pxx0));
    ripple_carry_adder_12bit9 U2(.A(tP[1]), .B(tP[4]), .C(tP[7]), .D(tP[10]), .E(tP[13]), .F(tP[16]), .G(tP[19]), .H(tP[22]), .I(tP[25]), .OUT(Pxx1));
    ripple_carry_adder_12bit9 U3(.A(tP[2]), .B(tP[5]), .C(tP[8]), .D(tP[11]), .E(tP[14]), .F(tP[17]), .G(tP[20]), .H(tP[23]), .I(tP[26]), .OUT(Pxx2));
    assign pixel_out = {Pxx0[11:4], Pxx1[11:4], Pxx2[11:4]};
    
endmodule