`timescale 1ns / 1ps
module ConvPE3x3 (
  input             clk          ,
  input             rst_n        ,
  input             CE           ,
  input      [23:0] IN1          , //imap
  input             WEIGHT_IN_EN ,
  output reg        WEIGHT_OUT_EN,
  input      [23:0] IN2          , //weight
  output reg [23:0] NEXT_PE_IN1  ,
  output reg [23:0] NEXT_PE_IN2  ,
  output reg [17:0] OUT
);

  reg [23:0] weight;


  //    always @(posedge WEIGHT_IN_EN ) begin
  //        weight  <= IN2;
  //        NEXT_PE_IN2 <= weight;
  //        WEIGHT_OUT_EN <= 1;
  //    end
  always @(posedge clk) begin
    if (WEIGHT_IN_EN) begin
      weight <= IN2;
      //            NEXT_PE_IN2 <= weight;
      //            WEIGHT_OUT_EN <= 1;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      OUT           <= 0;
      WEIGHT_OUT_EN <= 0;
    end else begin
      if (CE) begin
        OUT           <= IN1[23:16] * weight[23:16] + IN1[15:8] * weight[15:8] + IN1[7:0] * weight[7:0];
        NEXT_PE_IN1   <= IN1[23:0];
        NEXT_PE_IN2   <= IN2;
        WEIGHT_OUT_EN <= 1;
      end else begin
        OUT <= 0;
      end
    end
  end


endmodule
