module N_register_tb #(
  parameter WIDTH_REGISTER = 32
);
  logic [WIDTH_REGISTER-1:0]   i_data;
  logic                        n_rst;
  logic                        clk;
  
  logic [2*WIDTH_REGISTER:0] o_data;

  N_register #WIDTH_REGISTER register(.*);
  
  always #5 clk <= ~clk;
  
  initial begin
    clk   = 1'b0;
    n_rst = 1'b1; i_data = {4{8'h02}}; #20;
    n_rst = 1'b0; i_data = {4{8'h1f}}; #20;
    n_rst = 1'b1; i_data = {4{8'h1f}}; #20;
    #10 $finish;
    
  end

endmodule