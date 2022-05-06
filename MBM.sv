module MBM #(
  parameter WIDTH_DATA = 32
)(
  input logic [WIDTH_DATA-1:0] mcand,
  input logic [WIDTH_DATA-1:0] mplier,
  input logic                  clk,
  input logic                  n_rst,
  
  output logic [2*WIDTH_DATA-1:0] product
);

  logic [2*WIDTH_DATA:0] ex_mplier_out;
  logic [2*WIDTH_DATA:0] shift_befor_add_in;
  logic [2*WIDTH_DATA:0] encode_out;
  logic [2*WIDTH_DATA:0] add_one;
  logic [2*WIDTH_DATA:0] add_two;
  logic [2*WIDTH_DATA:0] sum;
  logic [2*WIDTH_DATA:0] tmp_prod;
  logic [2:0]            encoder;
  logic                  sel;
  logic                  sel_delay;
  logic                  en;

  /* DATA PATH */
  // Mo rong AQE voi A ban dau bang 32bits 0; Q ban dau bang mplier; E = 0 
  N_register #WIDTH_DATA ex_mplier(
    .i_data (mplier),
    .n_rst  (n_rst),
    .o_data (ex_mplier_out)
  );
  
  // Lua chon tin hieu can dich
  mux_2to1  #WIDTH_DATA shift_sel(
    .i_data_one (ex_mplier_out),
    .i_data_two (tmp_prod),
    .sel        (sel_delay),
    .o_data     (shift_befor_add_in)
  );
  
  
  // Dich sang trai va mo rong dau truoc khi cong voi mcand da duoc ma hoa 
  shift_right #WIDTH_DATA shift_befor_add(
    .i_data (shift_befor_add_in),
    .clk    (clk),
    .n_rst  (n_rst),  
    .o_data (add_one)
  );
  
  // Tin hieu dung de lua chon cach ma hoa cho mcand 
  mux_2to1 #1 encode_sel(
    .i_data_one (ex_mplier_out[2:0]),
    .i_data_two (tmp_prod[2:0]),
    .sel        (sel_delay),
    .o_data     (encoder)
  );
  
  // Ma hoa mcand 
  encoder_radix4 #WIDTH_DATA encoder_mcant(
    .i_data (mcand),
    .sel    (encoder),
    .o_data (encode_out)
  );
  
  // Lam tre ngo vao thu hai cho bo cong
  register #WIDTH_DATA add_two_delay_one(
    .i_data (encode_out),
    .clk    (clk),
    .o_data (add_two)
  );
  
  // Thuc hien cong mcand sau khi ma hoa va ket qua dich truoc do 
  CLA_adder #WIDTH_DATA adder(
    .i_data_one (add_one),
    .i_data_two (add_two),  
    .o_data     (sum),
    .o_carry    () 
  );
  
  // Dich phai lan thu nhat sau khi coong 
  shift_right #WIDTH_DATA sum_shift(
    .i_data (sum),
    .clk    (clk),
    .n_rst  (n_rst), 
    .o_data (tmp_prod)
  );
 
 // Ngo ra 
  assign product = en  ? tmp_prod[2*WIDTH_DATA:1] : {(2*WIDTH_DATA){1'bx}};   
  
  /* CONTROL UNIT */
  control #WIDTH_DATA control_unit(
    .clk    (clk),
    .n_rst  (n_rst),
    .sel    (sel),
    .o_en   (en)
  );
  
  register #0 delay_sel(
    .i_data (sel),
    .clk    (clk),
    .o_data (sel_delay)
  );
  
endmodule