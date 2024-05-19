module add(
    input logic [31:0] a, b,   // входные числа
    input logic reset, clk,    // флаг сброса и такт
    output logic[31:0] rez,    // результат
    output logic z_ack, z_stb  // флаги, принялось ли число и досчиталось ли оно (после сброса)
);

  logic a_stb, b_stb, a_ack, b_ack;

  adder adder (
      .input_a(a),
      .input_b(b),
      .input_a_stb(a_stb),
      .input_b_stb(b_stb),
      .output_z_ack(z_ack),
      .clk(clk),
      .rst(reset),
      .output_z(rez),
      .output_z_stb(z_stb),
      .input_a_ack(a_ack),
      .input_b_ack(b_ack)
  );

  assign a_stb = 1;
  assign b_stb = 1;
  assign z_ack = 1;

endmodule
