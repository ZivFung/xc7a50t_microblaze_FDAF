module iir_2nd
  #(
      parameter DW = 32,
      parameter FW = 16,
      parameter real N0 = 1,
      parameter real N1 = 1,
      parameter real N2 = 1,
      parameter real D1 = 1,
      parameter real D2 = 1
    )(
      input wire clk,
	  input wire rst,
      input wire en,
      input wire signed [DW-1:0] in,
      output logic signed [DW-1:0] out
    );
    logic signed [DW-1:0] d[0:1];
    
    wire signed [DW-1:0] n0 = (N0 * (2.0 **FW));
    wire signed [DW-1:0] n1 = (N1 * (2.0 **FW));
    wire signed [DW-1:0] n2 = (N2 * (2.0 **FW));
    wire signed [DW-1:0] d1 = (D1 * (2.0 **FW));
    wire signed [DW-1:0] d2 = (D2 * (2.0 **FW)); 
    wire signed [2*DW-1:0] pn0l = n0 * in;
    wire signed [2*DW-1:0] pn1l = n1 * in;
    wire signed [2*DW-1:0] pn2l = n2 * in;
    wire signed [2*DW-1:0] pd1l = d1 * out;
    wire signed [2*DW-1:0] pd2l = d2 * out;
    wire signed [DW-1:0] pn0 = pn0l >>> FW;
    wire signed [DW-1:0] pn1 = pn1l >>> FW;
    wire signed [DW-1:0] pn2 = pn2l >>> FW;
    wire signed [DW-1:0] pd1 = pd1l >>> FW;
    wire signed [DW-1:0] pd2 = pd2l >>> FW;
   
    assign out = (pn0 +d[0]);
    
    always_ff@(posedge clk)begin
	  if(rst)begin
		d <= '{2{'0}};
	  end
      else if(en)begin
        d[0] <= pn1 - pd1 + d[1];
        d[1] <= pn2 - pd2; 
      end
    end
    
  endmodule
    
