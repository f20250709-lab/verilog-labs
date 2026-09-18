module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  integer i, j;
  integer errors;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;
        if ((t_gt + t_lt + t_eq) != 1) begin
          $display("ERROR: A=%0d B=%0d GT=%b LT=%b EQ=%b (expected exactly one high)",
                    t_a, t_b, t_gt, t_lt, t_eq);
          errors = errors + 1;
        end
        if (t_gt && (t_a <= t_b)) begin
          $display("ERROR: GT asserted incorrectly for A=%0d B=%0d", t_a, t_b);
          errors = errors + 1;
        end
        if (t_lt && (t_a >= t_b)) begin
          $display("ERROR: LT asserted incorrectly for A=%0d B=%0d", t_a, t_b);
          errors = errors + 1;
        end
        if (t_eq && (t_a != t_b)) begin
          $display("ERROR: EQ asserted incorrectly for A=%0d B=%0d", t_a, t_b);
          errors = errors + 1;
        end
      end
    end
    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("%0d ERROR(S) FOUND", errors);
    $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);

endmodule