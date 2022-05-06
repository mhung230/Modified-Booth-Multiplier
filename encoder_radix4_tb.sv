module encoder_radix4_tb #(
  parameter WIDTH_DATA = 8
);
  logic [WIDTH_DATA-1:0] i_data;
  logic [2:0]            sel;
  
  logic [2*WIDTH_DATA:0] o_data;
  
  encoder_radix4 #WIDTH_DATA radix4(.*);
  
  initial begin
    i_data = 8'b0000_1111; sel = 000; #5;
    i_data = 8'b0000_1111; sel = 111; #5;
    i_data = 8'b0000_1111; sel = 001; #5;
    i_data = 8'b0000_1111; sel = 010; #5;
    i_data = 8'b0000_1111; sel = 011; #5;
    i_data = 8'b0000_1111; sel = 100; #5;
    i_data = 8'b0000_1111; sel = 101; #5;
    i_data = 8'b0000_1111; sel = 110; #5;
    i_data = 8'b1111_0010; sel = 000; #5;
    i_data = 8'b1111_0010; sel = 111; #5;
    i_data = 8'b1111_0010; sel = 001; #5;
    i_data = 8'b1111_0010; sel = 010; #5;
    i_data = 8'b1111_0010; sel = 011; #5;
    i_data = 8'b1111_0010; sel = 100; #5;
    i_data = 8'b1111_0010; sel = 101; #5;
    i_data = 8'b1111_0010; sel = 110; #5
    $finish;
  end
  
endmodule