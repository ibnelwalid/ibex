module ibex_zkn_aes_ex(
    input logic [1:0] bs,
    input logic mr,
    input logic enc_dec,
    input logic [3:0][7:0] pt,
    input logic [31:0] kr,
    output logic [31:0] ct
);

  logic [7:0] x, sx, sx2, sx4, sx8;
  logic [31:0] fit, dit, it;

  // Byte select
  assign x = pt[bs];

  // Sbox
  ibex_zkn_sbox sbox_8 (x, enc_dec, sx);

  // xtime
  ibex_zkn_xtime xtime (sx, sx2);
  ibex_zkn_xtime xtime2 (sx2, sx4);
  ibex_zkn_xtime xtime4 (sx4, sx8);

  always_comb
    case(bs)
      // Forward Mix Column only in case of middle round
      0 : fit <= (mr == 1'b1) ? {(sx ^ sx2), sx, sx, sx2} : {24'b0, sx};
      1 : fit <= (mr == 1'b1) ? {sx, sx, sx2, (sx ^ sx2)} : {16'b0, sx, 8'b0};
      2 : fit <= (mr == 1'b1) ? {sx, sx2, (sx ^ sx2), sx} : {8'b0, sx, 16'b0};
      3 : fit <= (mr == 1'b1) ? {sx2, (sx ^ sx2), sx, sx} : {sx, 24'b0};
      default: fit <= 0;
    endcase
  
  always_comb
    case(bs)
      // Inverse Mix Column only in case of middle round
      0 : dit <= (mr == 1'b1) ? {(sx ^ sx2 ^ sx8), (sx ^ sx4 ^ sx8), (sx ^ sx8), (sx2 ^ sx4 ^ sx8)} : {24'b0, sx};
      1 : dit <= (mr == 1'b1) ? {(sx ^ sx4 ^ sx8), (sx ^ sx8), (sx2 ^ sx4 ^ sx8), (sx ^ sx2 ^ sx8)} : {16'b0, sx, 8'b0};
      2 : dit <= (mr == 1'b1) ? {(sx ^ sx8), (sx2 ^ sx4 ^ sx8), (sx ^ sx2 ^ sx8), (sx ^ sx4 ^ sx8)} : {8'b0, sx, 16'b0};
      3 : dit <= (mr == 1'b1) ? {(sx2 ^ sx4 ^ sx8), (sx ^ sx2 ^ sx8), (sx ^ sx4 ^ sx8),(sx ^ sx8)} : {sx, 24'b0};
      default: dit <= 0;
    endcase
  
  always_comb
    case(enc_dec)
      0 : it <= dit;
      1 : it <= fit;
    endcase
  // XOR with Key
  assign ct = it ^ kr;

  always @(pt, x, bs, kr, mr)
    $display("t=%h, x=%h, sx=%h, sx2=%h, it=%h, pt=%h, ct=%h, bs=%h, kr=%h, enc_dec=%h", $time, x, sx, sx2, it, pt, ct, bs, kr, enc_dec);

endmodule