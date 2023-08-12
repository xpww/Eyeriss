`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/07/28 15:31:44
// Design Name:
// Module Name: eyeriss
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module eyeriss (
  input                    clk   ,
  input                    rst_n ,
  input                    CE    ,
  input      [  3*3*8-1:0] filter,
  input      [64*48*8-1:0] image , //row1: [64*48*8-1 -: 48*8]     row2:[63*48*8-1 -: 48*8]
  output reg [       17:0] o_1, o_2, o_3
);
  //*******************************************按行存储image与filter**********************************************
  // reg [48*8-1:0] image_row [63:0];
  reg [48*8-1:0] image_row [63:0];
  reg [    23:0] filter_row[ 2:0];
  // reg [ 23:0] filter_row[ 0:2];


  generate
    genvar i_0;
    for (i_0 = 0; i_0 < 64; i_0 = i_0 + 1'b1)
      begin : g_row_reg

        always @(posedge clk or negedge rst_n)
          begin
            if (!rst_n)
              begin
                image_row[i_0] <= 0;
              end
            else
              begin
                image_row[i_0] <= image[(64-i_0)*48*8-1-:48*8];
              end
          end
        end
    endgenerate

    generate
      genvar i_1;
      for (i_1 = 0; i_1 < 3; i_1 = i_1 + 1'b1)
        begin : filter_row_reg

          always @(posedge clk or negedge rst_n)
          begin
            if (!rst_n)
              begin
                filter_row[i_1] <= 0;
              end
            else
              begin
                filter_row[i_1] <= filter[(3-i_1)*3*8-1-:3*8];
              end
          end
        end
    endgenerate
    //*******************************************计算结果**********************************************

    //*******************************************无状态机的计数控制逻辑**********************************************
    reg [6:0] cnt;
  reg [ 6:0] flag, flag_d1;
  reg [23:0] row_0_data,      row_1_data,      row_2_data,      row_3_data,      row_3_data_d1,      row_4_data,      row_4_data_d1,      row_4_data_d2;

  always @(posedge clk or negedge rst_n)
    begin
      if (!rst_n || cnt == 0)
        begin
          row_0_data <= 24'b0000_000;
          row_1_data <= 24'b0000_000;
          row_2_data <= 24'b0000_000;
          row_3_data <= 24'b0000_000;
          row_4_data <= 24'b0000_000;
        end
      else if (cnt <= 46)
        begin
          case (flag)
            0 :
              begin
                row_0_data <= image_row[0][(49-cnt)*8-1-:24];
                row_1_data <= image_row[1][(49-cnt)*8-1-:24];
                row_2_data <= image_row[2][(49-cnt)*8-1-:24];
                row_3_data <= image_row[3][(49-cnt)*8-1-:24];
                row_4_data <= image_row[4][(49-cnt)*8-1-:24];
              end
            1 :
              begin
                row_0_data <= image_row[3][(49-cnt)*8-1-:24];
                row_1_data <= image_row[4][(49-cnt)*8-1-:24];
                row_2_data <= image_row[5][(49-cnt)*8-1-:24];
                row_3_data <= image_row[6][(49-cnt)*8-1-:24];
                row_4_data <= image_row[7][(49-cnt)*8-1-:24];
              end
            2 :
              begin
                row_0_data <= image_row[6][(49-cnt)*8-1-:24];
                row_1_data <= image_row[7][(49-cnt)*8-1-:24];
                row_2_data <= image_row[8][(49-cnt)*8-1-:24];
                row_3_data <= image_row[9][(49-cnt)*8-1-:24];
                row_4_data <= image_row[10][(49-cnt)*8-1-:24];
              end


            3 :
              begin
                row_0_data <= image_row[9][(49-cnt)*8-1-:24];
                row_1_data <= image_row[10][(49-cnt)*8-1-:24];
                row_2_data <= image_row[11][(49-cnt)*8-1-:24];
                row_3_data <= image_row[12][(49-cnt)*8-1-:24];
                row_4_data <= image_row[13][(49-cnt)*8-1-:24];
              end


            4 :
              begin
                row_0_data <= image_row[12][(49-cnt)*8-1-:24];
                row_1_data <= image_row[13][(49-cnt)*8-1-:24];
                row_2_data <= image_row[14][(49-cnt)*8-1-:24];
                row_3_data <= image_row[15][(49-cnt)*8-1-:24];
                row_4_data <= image_row[16][(49-cnt)*8-1-:24];
              end


            5 :
              begin
                row_0_data <= image_row[15][(49-cnt)*8-1-:24];
                row_1_data <= image_row[16][(49-cnt)*8-1-:24];
                row_2_data <= image_row[17][(49-cnt)*8-1-:24];
                row_3_data <= image_row[18][(49-cnt)*8-1-:24];
                row_4_data <= image_row[19][(49-cnt)*8-1-:24];
              end


            6 :
              begin
                row_0_data <= image_row[18][(49-cnt)*8-1-:24];
                row_1_data <= image_row[19][(49-cnt)*8-1-:24];
                row_2_data <= image_row[20][(49-cnt)*8-1-:24];
                row_3_data <= image_row[21][(49-cnt)*8-1-:24];
                row_4_data <= image_row[22][(49-cnt)*8-1-:24];
              end


            7 :
              begin
                row_0_data <= image_row[21][(49-cnt)*8-1-:24];
                row_1_data <= image_row[22][(49-cnt)*8-1-:24];
                row_2_data <= image_row[23][(49-cnt)*8-1-:24];
                row_3_data <= image_row[24][(49-cnt)*8-1-:24];
                row_4_data <= image_row[25][(49-cnt)*8-1-:24];
              end


            8 :
              begin
                row_0_data <= image_row[24][(49-cnt)*8-1-:24];
                row_1_data <= image_row[25][(49-cnt)*8-1-:24];
                row_2_data <= image_row[26][(49-cnt)*8-1-:24];
                row_3_data <= image_row[27][(49-cnt)*8-1-:24];
                row_4_data <= image_row[28][(49-cnt)*8-1-:24];
              end


            9 :
              begin
                row_0_data <= image_row[27][(49-cnt)*8-1-:24];
                row_1_data <= image_row[28][(49-cnt)*8-1-:24];
                row_2_data <= image_row[29][(49-cnt)*8-1-:24];
                row_3_data <= image_row[30][(49-cnt)*8-1-:24];
                row_4_data <= image_row[31][(49-cnt)*8-1-:24];
              end


            10 :
              begin
                row_0_data <= image_row[30][(49-cnt)*8-1-:24];
                row_1_data <= image_row[31][(49-cnt)*8-1-:24];
                row_2_data <= image_row[32][(49-cnt)*8-1-:24];
                row_3_data <= image_row[33][(49-cnt)*8-1-:24];
                row_4_data <= image_row[34][(49-cnt)*8-1-:24];
              end


            11 :
              begin
                row_0_data <= image_row[33][(49-cnt)*8-1-:24];
                row_1_data <= image_row[34][(49-cnt)*8-1-:24];
                row_2_data <= image_row[35][(49-cnt)*8-1-:24];
                row_3_data <= image_row[36][(49-cnt)*8-1-:24];
                row_4_data <= image_row[37][(49-cnt)*8-1-:24];
              end


            12 :
              begin
                row_0_data <= image_row[36][(49-cnt)*8-1-:24];
                row_1_data <= image_row[37][(49-cnt)*8-1-:24];
                row_2_data <= image_row[38][(49-cnt)*8-1-:24];
                row_3_data <= image_row[39][(49-cnt)*8-1-:24];
                row_4_data <= image_row[40][(49-cnt)*8-1-:24];
              end


            13 :
              begin
                row_0_data <= image_row[39][(49-cnt)*8-1-:24];
                row_1_data <= image_row[40][(49-cnt)*8-1-:24];
                row_2_data <= image_row[41][(49-cnt)*8-1-:24];
                row_3_data <= image_row[42][(49-cnt)*8-1-:24];
                row_4_data <= image_row[43][(49-cnt)*8-1-:24];
              end


            14 :
              begin
                row_0_data <= image_row[42][(49-cnt)*8-1-:24];
                row_1_data <= image_row[43][(49-cnt)*8-1-:24];
                row_2_data <= image_row[44][(49-cnt)*8-1-:24];
                row_3_data <= image_row[45][(49-cnt)*8-1-:24];
                row_4_data <= image_row[46][(49-cnt)*8-1-:24];
              end


            15 :
              begin
                row_0_data <= image_row[45][(49-cnt)*8-1-:24];
                row_1_data <= image_row[46][(49-cnt)*8-1-:24];
                row_2_data <= image_row[47][(49-cnt)*8-1-:24];
                row_3_data <= image_row[48][(49-cnt)*8-1-:24];
                row_4_data <= image_row[49][(49-cnt)*8-1-:24];
              end


            16 :
              begin
                row_0_data <= image_row[48][(49-cnt)*8-1-:24];
                row_1_data <= image_row[49][(49-cnt)*8-1-:24];
                row_2_data <= image_row[50][(49-cnt)*8-1-:24];
                row_3_data <= image_row[51][(49-cnt)*8-1-:24];
                row_4_data <= image_row[52][(49-cnt)*8-1-:24];
              end


            17 :
              begin
                row_0_data <= image_row[51][(49-cnt)*8-1-:24];
                row_1_data <= image_row[52][(49-cnt)*8-1-:24];
                row_2_data <= image_row[53][(49-cnt)*8-1-:24];
                row_3_data <= image_row[54][(49-cnt)*8-1-:24];
                row_4_data <= image_row[55][(49-cnt)*8-1-:24];
              end


            18 :
              begin
                row_0_data <= image_row[54][(49-cnt)*8-1-:24];
                row_1_data <= image_row[55][(49-cnt)*8-1-:24];
                row_2_data <= image_row[56][(49-cnt)*8-1-:24];
                row_3_data <= image_row[57][(49-cnt)*8-1-:24];
                row_4_data <= image_row[58][(49-cnt)*8-1-:24];
              end


            19 :
              begin
                row_0_data <= image_row[57][(49-cnt)*8-1-:24];
                row_1_data <= image_row[58][(49-cnt)*8-1-:24];
                row_2_data <= image_row[59][(49-cnt)*8-1-:24];
                row_3_data <= image_row[60][(49-cnt)*8-1-:24];
                row_4_data <= image_row[61][(49-cnt)*8-1-:24];
              end

            20 :
              begin
                row_0_data <= image_row[60][(49-cnt)*8-1-:24];
                row_1_data <= image_row[61][(49-cnt)*8-1-:24];
                row_2_data <= image_row[62][(49-cnt)*8-1-:24];
                row_3_data <= image_row[63][(49-cnt)*8-1-:24];
                row_4_data <= 0;
              end

          endcase
        end
    end

  always @(posedge clk)
    begin
      row_3_data_d1 <= row_3_data;
      row_4_data_d1 <= row_4_data;
      row_4_data_d2 <= row_4_data_d1;
    end
  always @(posedge clk or negedge rst_n)
    begin
      if (!rst_n)
        begin
          cnt  <= 0;
          flag <= 0;
        end
      else if (cnt == 46)
        begin
          cnt  <= 1;
          flag <= flag + 1;
        end
      else
        cnt <= cnt + 1;
    end

  //*******************************************PE阵列**********************************************
  wire [17:0] OUT_1_1, OUT_1_2, OUT_1_3, OUT_2_1, OUT_2_2, OUT_2_3, OUT_3_1, OUT_3_2, OUT_3_3;
  wire [23:0] IN1_1_1, IN1_1_2, IN1_1_3, IN1_2_1, IN1_2_2, IN1_2_3, IN1_3_1, IN1_3_2, IN1_3_3;
  wire [23:0] IN2_1_1, IN2_1_2, IN2_1_3, IN2_2_1, IN2_2_2, IN2_2_3, IN2_3_1, IN2_3_2, IN2_3_3;
  wire        WEIGHT_EN_1_2, WEIGHT_EN_1_3, WEIGHT_EN_2_2, WEIGHT_EN_2_3, WEIGHT_EN_3_2, WEIGHT_EN_3_3;
  reg         WEIGHT_IN_EN ;
  assign IN1_1_1 = CE ? row_0_data : 0;
  assign IN1_2_1 = CE ? row_1_data : 0;
  assign IN1_3_1 = CE ? row_2_data : 0;
  assign IN1_3_2 = CE ? row_3_data_d1 : 0;
  assign IN1_3_3 = CE ? row_4_data_d2 : 0;

  always @(posedge clk)
    begin
      if (CE)
        begin
          WEIGHT_IN_EN <= 1;
        end
    end
  ConvPE3x3 ConvPE3x3_1_1 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_1_1      ),
    .IN2          (IN2_1_1      ),
    .WEIGHT_IN_EN (WEIGHT_IN_EN ),
    .WEIGHT_OUT_EN(WEIGHT_EN_1_2),
    .NEXT_PE_IN1  (             ),
    .NEXT_PE_IN2  (IN2_1_2      ),
    .OUT          (OUT_1_1      )
  );

  ConvPE3x3 ConvPE3x3_1_2 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_1_2      ),
    .IN2          (IN2_1_2      ),
    .WEIGHT_IN_EN (WEIGHT_EN_1_2),
    .WEIGHT_OUT_EN(WEIGHT_EN_1_3),
    .NEXT_PE_IN1  (             ),
    .NEXT_PE_IN2  (IN2_1_3      ),
    .OUT          (OUT_1_2      )
  );

  ConvPE3x3 ConvPE3x3_1_3 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (WEIGHT_IN_EN ),
    .IN1          (IN1_1_3      ),
    .IN2          (IN2_1_3      ),
    .WEIGHT_IN_EN (WEIGHT_EN_1_3),
    .WEIGHT_OUT_EN(             ),
    .NEXT_PE_IN1  (             ),
    .NEXT_PE_IN2  (             ),
    .OUT          (OUT_1_3      )
  );

  ConvPE3x3 ConvPE3x3_2_1 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_2_1      ),
    .IN2          (IN2_2_1      ),
    .WEIGHT_IN_EN (CE           ),
    .WEIGHT_OUT_EN(WEIGHT_EN_2_2),
    .NEXT_PE_IN1  (IN1_1_2      ),
    .NEXT_PE_IN2  (IN2_2_2      ),
    .OUT          (OUT_2_1      )
  );

  ConvPE3x3 ConvPE3x3_2_2 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (WEIGHT_IN_EN ),
    .IN1          (IN1_2_2      ),
    .IN2          (IN2_2_2      ),
    .WEIGHT_IN_EN (WEIGHT_EN_2_2),
    .WEIGHT_OUT_EN(WEIGHT_EN_2_3),
    .NEXT_PE_IN1  (IN1_1_3      ),
    .NEXT_PE_IN2  (IN2_2_3      ),
    .OUT          (OUT_2_2      )
  );

  ConvPE3x3 ConvPE3x3_2_3 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_2_3      ),
    .IN2          (IN2_2_3      ),
    .WEIGHT_IN_EN (WEIGHT_EN_2_3),
    .WEIGHT_OUT_EN(             ),
    .NEXT_PE_IN1  (             ),
    .NEXT_PE_IN2  (             ),
    .OUT          (OUT_2_3      )
  );

  ConvPE3x3 ConvPE3x3_3_1 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_3_1      ),
    .IN2          (IN2_3_1      ),
    .WEIGHT_IN_EN (CE           ),
    .WEIGHT_OUT_EN(WEIGHT_EN_3_2),
    .NEXT_PE_IN1  (IN1_2_2      ),
    .NEXT_PE_IN2  (IN2_3_2      ),
    .OUT          (OUT_3_1      )
  );

  ConvPE3x3 ConvPE3x3_3_2 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_3_2      ),
    .IN2          (IN2_3_2      ),
    .WEIGHT_IN_EN (WEIGHT_EN_3_2),
    .WEIGHT_OUT_EN(WEIGHT_EN_3_3),
    .NEXT_PE_IN1  (IN1_2_3      ),
    .NEXT_PE_IN2  (IN2_3_3      ),
    .OUT          (OUT_3_2      )
  );

  ConvPE3x3 ConvPE3x3_3_3 (
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .CE           (CE           ),
    .IN1          (IN1_3_3      ),
    .IN2          (IN2_3_3      ),
    .WEIGHT_IN_EN (WEIGHT_EN_3_3),
    .WEIGHT_OUT_EN(             ),
    .NEXT_PE_IN1  (             ),
    .NEXT_PE_IN2  (             ),
    .OUT          (OUT_3_3      )
  );

  //*******************************************filter row1 ~ filter row3**********************************************
  assign IN2_1_1 = CE ? filter[3*3*8-1 : 2*3*8] : 0;
  assign IN2_2_1 = CE ? filter[2*3*8-1 : 1*3*8] : 0;
  assign IN2_3_1 = CE ? filter[1*3*8-1 : 0*3*8] : 0;
  //******************************************Ofmap****************************************

  // reg  [19:0]  o_1, o_2, o_3;
  always @(posedge clk or negedge rst_n)
    begin
      if (!rst_n)
        begin
          o_1 <= 0;
          o_2 <= 0;
          o_3 <= 0;
        end
      else
        begin
          if (CE)
            begin
              o_1 <= OUT_1_1 + OUT_2_1 + OUT_3_1;
              o_2 <= OUT_1_2 + OUT_2_2 + OUT_3_2;
              o_3 <= OUT_1_3 + OUT_2_3 + OUT_3_3;
            end
          else
            begin
              o_1 <= 0;
              o_2 <= 0;
              o_3 <= 0;
            end
        end
    end

endmodule
