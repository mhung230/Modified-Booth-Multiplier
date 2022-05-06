module encoder_radix4 #(
  parameter WIDTH_DATA = 8
)(
  input  logic [WIDTH_DATA-1:0] i_data,
  input  logic [2:0]            sel,
  
  output logic [2*WIDTH_DATA:0] o_data
);
  
  logic [WIDTH_DATA:0] tmp;
  
  always @(i_data, sel) begin
    case (sel)
      // i_data
      3'b001 : tmp = {i_data[WIDTH_DATA-1],i_data};
      3'b010 : tmp = {i_data[WIDTH_DATA-1],i_data};
      // 2*i_data
      3'b011 : tmp = {i_data[WIDTH_DATA-1],i_data} << 1;
      // -2*i_data
      3'b100 : tmp = (~{i_data[WIDTH_DATA-1],i_data} + 1'b1) << 1;
      // -i_data
      3'b101 : tmp = ~{i_data[WIDTH_DATA-1],i_data} + 1'b1;
      3'b110 : tmp = ~{i_data[WIDTH_DATA-1],i_data} + 1'b1;
      default: tmp = {(WIDTH_DATA+1){1'b0}};
    endcase
    
    o_data = {tmp, {WIDTH_DATA{1'b0}}};
  end
  
endmodule