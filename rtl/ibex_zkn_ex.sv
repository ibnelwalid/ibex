module ibex_zkn_ex(
    input logic [1:0] bs,
    input logic mr,
    input logic [3:0][7:0] pt,
    input logic [31:0] kr,
    output logic [31:0] ct
);

  logic [7:0] x, sx, sx2;
  logic [31:0] it;

  // Byte select
  assign x = pt[bs];

  // Sbox
  ibex_zkn_sbox sbox_8 (x, sx);

  // xtime
  ibex_zkn_xtime xtime (sx, sx2);

  // Forward Mix Column only in case of middle round
  always_comb
    case(bs)
      0 : it <= (mr == 1'b1) ? {(sx ^ sx2), sx, sx, sx2} : {24'b0, sx};
      1 : it <= (mr == 1'b1) ? {sx, sx, sx2, (sx ^ sx2)} : {16'b0, sx, 8'b0};
      2 : it <= (mr == 1'b1) ? {sx, sx2, (sx ^ sx2), sx} : {8'b0, sx, 16'b0};
      3 : it <= (mr == 1'b1) ? {sx2, (sx ^ sx2), sx, sx} : {sx, 24'b0};
      default: it <= 0;
    endcase
  // XOR with Key
  assign ct = it ^ kr;

  always @(pt, x, bs, kr, mr)
    $display("t=%h, x=%h, sx=%h, sx2=%h, it=%h, pt=%h, ct=%h, bs=%h, kr=%h", $time, x, sx, sx2, it, pt, ct, bs, kr);

endmodule