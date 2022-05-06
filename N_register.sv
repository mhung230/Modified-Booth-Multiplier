module N_register #(
  parameter WIDTH_REGISTER = 8
)(
  input  logic [WIDTH_REGISTER-1:0] i_data,
  input  logic                      n_rst,
  
  output logic [2*WIDTH_REGISTER:0] o_data
);

  always @(i_data, n_rst) begin
    if (n_rst)  o_data <= {{WIDTH_REGISTER{1'b0}},i_data,1'b0};
    else  o_data <= {WIDTH_REGISTER{1'bx}};
  end

endmodule