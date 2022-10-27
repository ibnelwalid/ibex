module ibex_zkn_xtime(
    input logic [7:0] x,
    output logic [7:0] x2
);
  assign x2 = (x << 1) ^ ((x[7] && 1'b1) ? 8'h1B : 8'h00);
endmodule