module dff #(
  parameter WIDH_DATA = 8
)(
  input  logic [2*WIDH_DATA:0] i_data,
  input  logic                 clk,
  
  output logic [2*WIDH_DATA:0] o_data
);

  always @(posedge clk) begin
    o_data <= i_data;
  end
  
endmodule