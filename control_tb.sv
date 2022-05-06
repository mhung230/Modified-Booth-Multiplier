module control_tb #(
  parameter WIDTH_CONTROL = 8
);
  logic clk;
  //logic n_rst;
  
  logic sel;
  
  control #WIDTH_CONTROL a(.*);
  
  always #5 clk <= ~clk;
  
  initial begin
    clk = 1'b0; #50;
    #20 $finish;
  end
  
endmodule