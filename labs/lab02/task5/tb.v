module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    t_a = 4'd3; t_b = 4'd2; t_op = 0;
    #5;
    if (t_result !== (t_a + t_b))
      $display("ERROR: ADD a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a + t_b, t_result);

    t_op = 1;
    #5;
    if (t_result !== (t_a - t_b))
      $display("ERROR: SUB a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a - t_b, t_result);

    t_a = 4'd7; t_b = 4'd5; t_op = 0;
    #5;
    if (t_result !== (t_a + t_b))
      $display("ERROR: ADD a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a + t_b, t_result);

    t_op = 1;
    #5;
    if (t_result !== (t_a - t_b))
      $display("ERROR: SUB a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a - t_b, t_result);

    
    t_a = 4'd9; t_b = 4'd4; t_op = 0;
    #5;
    if (t_result !== (t_a + t_b))
      $display("ERROR: ADD a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a + t_b, t_result);

    t_op = 1;  
    #5;
    if (t_result !== (t_a - t_b))
      $display("ERROR: SUB (op-only toggle) a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a - t_b, t_result);

    t_op = 0;  
    #5;
    if (t_result !== (t_a + t_b))
      $display("ERROR: ADD (op-only toggle) a=%0d b=%0d expected=%0d got=%0d", t_a, t_b, t_a + t_b, t_result);

    $display("TEST COMPLETE");
    $finish;
  end

  initial
    $monitor($time, " a=%0d b=%0d op=%b | result=%0d", t_a, t_b, t_op, t_result);

endmodule