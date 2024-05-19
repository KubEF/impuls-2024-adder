module add_tb ();
  logic clk, reset, z_ack, rez_is_calculated;
  logic [31:0] a, b, rez, rez_expected;
  logic [31:0] counter, errors;
  logic [95:0] testvectors[4];

  add add(
      .a(a),
      .b(b),
      .reset(reset),
      .clk(clk),
      .rez(rez),
      .z_ack(z_ack),
      .z_stb(rez_is_calculated)
  );

// генерируем такты
always begin
  clk = 0;
  #5;
  clk = 1;
  #5;

end
// иницилизируем счётчик ошибок и счётчик тестовых векторов
// задаём начальные условия для старта вычисления
initial begin
    $readmemb("test_vectors.tv", testvectors);
    reset = 1;
    counter = 0;
    errors = 0;
    #5;
    {a, b, rez_expected} = testvectors[counter];
    #10;
    reset = 0;
end

// сложение происходит по переднему фронту такта, так что проверяем по нему же
always @(posedge clk) begin
    if(~reset) begin // пропускаем проверку, если на этом такте происходит сброс
      // проверяем, вычислился ли результат
      if (rez_is_calculated) begin
        if (rez !== rez_expected) begin
          $display("FAILED: inputs = %f + %f. rez = %f, expected_rez = %f",
                   $bitstoshortreal(a),
                   $bitstoshortreal(b),
                   $bitstoshortreal(rez),
                   $bitstoshortreal(rez_expected));
          errors = errors + 1;
        end else
          $display("PASSED: %f + %f = %f",
                   $bitstoshortreal(a),
                   $bitstoshortreal(b),
                   $bitstoshortreal(rez));
        counter = counter + 1;
        reset   = 1;
      end
      if (testvectors[counter] === 'bx) begin
        $display("\n%d tests completed with %d failed", counter, errors);
        $finish;
      end
    end
  end

// если всё посчиталось, то берём следующий вектор и через одно обновление пытаемся вычислить результат
always @(posedge reset) begin
  {a, b, rez_expected} = testvectors[counter];
  #10; reset = 0;
end

endmodule
