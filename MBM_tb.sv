module MBM_tb #(
  parameter WIDTH_DATA = 32
);
  logic [WIDTH_DATA-1:0] mcand;
  logic [WIDTH_DATA-1:0] mplier;
  logic                  clk;
  logic                  n_rst;
  
  logic [2*WIDTH_DATA-1:0] product;
  
  MBM #WIDTH_DATA mbm(.*);
  
  always #5 clk <= ~clk;
  
  initial begin
    clk   = 0;
    // positive.positive 
      //(3x1000 = 3000d (00000000_00000bb8h)ss)
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'h00000003; mplier = 32'h000003e8; #350;
      //(3x5 = 15d (00000000_0000000fh) )
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'h00000003; mplier = 32'h00000005; #350;
    // positive.negative 
      //(27000x-200 = -5400000d (ffffffff_ffad9a40h))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'h00006978; mplier = 32'hffffff38; #350; 
      //(20x-5 = -100d (ffffffff_ffffff9ch) )
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'h00000014; mplier = 32'hfffffffb; #350;
    // negative.positive 
      //(-3572x215026 = -768072872d (ffffffff_d2382358h))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'hfffff20c; mplier = 32'h000347f2; #350; 
      //(-4x25 = -100d (ffffffff_ffffff9ch) )
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'hfffffffc; mplier = 32'h00000019; #350;
    // negative.negative 
      //(-1205x-378950 = 456634750d (00000000_1b37b17eh))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'hfffffb4b; mplier = 32'hfffa37ba; #350; 
      //(-1x-21 = 21d (00000000_00000015h))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'hffffffff; mplier = 32'hffffffeb; #350;
    // (0x0 = 0d (00000000_00000000h))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'h00000000; mplier = 32'h00000000; #350;
    
    // (-1x-1 = 1d (00000000_00000001h))
    n_rst = 0; mcand = 32'hffffffff; mplier = 32'h00000000; #10;
    n_rst = 1; mcand = 32'hffffffff; mplier = 32'hffffffff; #350;
    #10 $finish;
  end
  
endmodule