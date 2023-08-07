`timescale 1ns / 1ps

module eyeriss_tb ();

  reg clk  ;
  reg rst_n;
  reg CE   ;
  initial
    begin
      clk = 0;
      rst_n = 0;
      forever
        #5  clk = ~clk;
    end
  initial
    begin
      #16 rst_n = 1;
      #5  CE    = 1;
    end

  reg  [  3*3*8-1:0] filter[0:0];
  reg  [64*48*8-1:0] image [0:0];
  wire [       17:0] o_1, o_2, o_3;
  initial
    begin
      $readmemb("../filter.txt", filter);
      $readmemb("../image.txt", image);
    end

  initial begin
    // $dumpfile("wave.fsdb");
    // $dumpvars(0, eyeriss_tb );
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0, eyeriss_tb);
    #10000 $finish;
  end
  wire [62*46*8-1:0] result;

  eyeriss u_eyeriss (
    //ports
    .clk   (clk      ),
    .rst_n (rst_n    ),
    .CE    (CE       ),
    .filter(filter[0]),
    .image (image[0] ),
    .o_1   (o_1      ),
    .o_2   (o_2      ),
    .o_3   (o_3      )
  );
endmodule

