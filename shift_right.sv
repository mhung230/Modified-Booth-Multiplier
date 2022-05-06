module shift_right #(
  parameter WIDTH_SHIFT = 8
)(
  input  logic [2*WIDTH_SHIFT:0] i_data,
  input  logic                   clk,
  input  logic                   n_rst,
  
  output logic [2*WIDTH_SHIFT:0] o_data
);
  
  always @(posedge clk) begin
    if (n_rst)  o_data <= {i_data[2*WIDTH_SHIFT],i_data[2*WIDTH_SHIFT:1]};
    else  o_data <= {2*WIDTH_SHIFT{1'bx}};    
  end
  
endmodule