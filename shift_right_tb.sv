module shift_right_tb #(
  parameter WIDTH_SHIFT = 32
);
  logic [2*WIDTH_SHIFT:0] i_data;
  logic                   clk;
  logic                   n_rst;
  
  logic [2*WIDTH_SHIFT:0] o_data;
  
  shift_right #WIDTH_SHIFT PIPO(.*);
  
  always #5 clk <= ~clk;
  
  initial begin
    clk = 0;
    n_rst = 1'b0; i_data = {2{16'h0110}}; # 20;
    n_rst = 1'b1; i_data = {2{16'hffff}}; # 20;
    n_rst = 1'b1; i_data = {2{16'h0f12}}; # 20;
    n_rst = 1'b0; i_data = {2{16'h0110}}; # 20;
    $finish;
  end
  
endmodule