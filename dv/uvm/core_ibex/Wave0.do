onerror resume
wave tags F0
wave update off
wave zoom range 14804280 15488545
wave add core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.clk_i -tag F0 -radix hexadecimal
wave add {core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.alu_operator_o[6:0]} -tag F0 -radix mnemonic
wave add core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.alu_multicycle_o -tag F0 -radix hexadecimal
wave add core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.illegal_insn -tag F0 -radix hexadecimal -select
wave add {core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.instr[31:0]} -tag F0 -radix hexadecimal
wave add {core_ibex_tb_top.dut.u_ibex_top.u_ibex_core.id_stage_i.decoder_i.instr_alu[31:0]} -tag F0 -radix hexadecimal
wave update on
wave top 0
