/*
 * Simple 8-bit ALU for Tiny Tapeout
 * Operations selected by ui_in[2:0]
 *
 * ui_in[7:0]  = input A
 * uio_in[7:0]= input B
 *
 * Operations:
 * 000 : ADD
 * 001 : SUB
 * 010 : AND
 * 011 : OR
 * 100 : XOR
 * 101 : NOT A
 * 110 : Shift Left A
 * 111 : Shift Right A
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Input A
    output reg  [7:0] uo_out,   // ALU result
    input  wire [7:0] uio_in,   // Input B
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // ALU operation selector
    wire [2:0] alu_op;

    assign alu_op = ui_in[2:0];

    // Unused bidirectional IOs
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Combinational ALU
    always @(*) begin
        case (alu_op)

            3'b000: uo_out = ui_in + uio_in;   // ADD
            3'b001: uo_out = ui_in - uio_in;   // SUB
            3'b010: uo_out = ui_in & uio_in;   // AND
            3'b011: uo_out = ui_in | uio_in;   // OR
            3'b100: uo_out = ui_in ^ uio_in;   // XOR
            3'b101: uo_out = ~ui_in;           // NOT
            3'b110: uo_out = ui_in << 1;       // Shift Left
            3'b111: uo_out = ui_in >> 1;       // Shift Right

            default: uo_out = 8'b00000000;

        endcase
    end

    // Prevent unused signal warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

`default_nettype wire
