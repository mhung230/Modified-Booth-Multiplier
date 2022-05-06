module control #(
  parameter WIDTH_CONTROL = 8
)(
  input  logic clk,
  input  logic n_rst,
  
  output logic sel,
  output logic o_en
);

  logic [5:0] count;

  always @(posedge clk) begin
    count = count + 1;
    if (n_rst) begin    
      if ((count > 0) & (count <= (WIDTH_CONTROL + 2)))
        if (count == 1) sel = 0;
        else sel = 1;
      else sel = 0;
      
      if (count == (WIDTH_CONTROL + 2)) o_en <= 1;
      else o_en = 0;
    end else begin
      count = 0;
      sel   = 0;
      o_en  = 0;
    end
  end
  
endmodule