module mux_2to1 #(
  parameter WIDTH_DATA = 8
)(
  input  logic [2*WIDTH_DATA:0] i_data_one, i_data_two,
  input  logic                  sel,
  
  output logic [2*WIDTH_DATA:0] o_data
);

  assign o_data = sel ? i_data_two : i_data_one;
  
endmodule