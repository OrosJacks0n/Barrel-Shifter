module barrelShifter(outputNum, num, shiftByDelta); // **** GREATER THAN 4
    input [9:0] num; // input floating num1/num2
    input [5:0] shiftByDelta; // delta
    output reg [9:0] barrelShiftedNum, outputNum; // output
    reg [0:0] zero;
    reg [10:0] tempNum;
    always@(*)
        begin

            // while(shiftByDelta > 10 && shiftByDelta > 0) begin
            //   shiftByDelta = shiftByDelta - 1;
            // end
            zero [0] = 1'b0;
            tempNum[10:0] = {1'b1, num[9:0]}; // msb of num is 9, lsb is 0
            if(shiftByDelta >= 10) begin
              shiftedNum = 9'b1;
              outputNum = shiftedNum;
            end

            else begin
              case (shiftByDelta)
              6'b000_000: barrelShiftedNum[9:0] = tempNum[10:1];
              6'b1: barrelShiftedNum[9:0] = {tempNum[1],tempNum[10:2]};
              6'b000010: barrelShiftedNum[9:0] = {tempNum[2:1], tempNum[10:3]};
              //{tempNum[2], tempNum[1], tempNum[10], tempNum[9], tempNum[8], tempNum[7], tempNum[6], tempNum[5], tempNum[4], tempNum[3]};//tempNum[10:3]};
              6'd3: barrelShiftedNum[9:0] = {tempNum[3:1],tempNum[10:4]};
              6'd4: barrelShiftedNum[9:0] = {tempNum[4:1],tempNum[10:5]};
              6'd5: barrelShiftedNum[9:0] = {tempNum[5:1],tempNum[10:6]};
              6'd6: barrelShiftedNum[9:0] = {tempNum[6:1],tempNum[10:7]};
              6'd7: barrelShiftedNum[9:0] = {tempNum[7:1],tempNum[10:8]};
              6'd8: barrelShiftedNum[9:0] = {tempNum[8:1],tempNum[10:9]};
              6'd9: barrelShiftedNum[9:0] = {tempNum[9:1],tempNum[10]};
              default: barrelShiftedNum[0:9] = tempNum[0:9];
              endcase

              case (shiftByDelta)
              6'd0: outputNum[0:9] = barrelShiftedNum[0:9];
              6'd1: outputNum[0:9] = {zero[0],barrelShiftedNum[0:8]};
              6'd2: outputNum[0:9] = {{2{zero[0]}},barrelShiftedNum[0:7]};
              6'd3: outputNum[0:9] = {{3{zero[0]}},barrelShiftedNum[0:6]};
              6'd4: outputNum[0:9] = {{4{zero[0]}},barrelShiftedNum[0:5]};
              6'd5: outputNum[0:9] = {{5{zero[0]}},barrelShiftedNum[0:4]};
              6'd6: outputNum[0:9] = {{6{zero[0]}},barrelShiftedNum[0:3]};
              6'd7: outputNum[0:9] = {{7{zero[0]}},barrelShiftedNum[0:2]};
              6'd8: outputNum[0:9] = {{8{zero[0]}},barrelShiftedNum[0:1]};
              6'd9: outputNum[0:9] = {{9{zero[0]}},barrelShiftedNum[0]};
              default: outputNum[0:9] = barrelShiftedNum;
             endcase
            end

            //***********ADD GAURD BIT AND ROUND BIT ******


            // tempNum = {1'b1, num[9:0]}; // can be 0...0 -> 100...00
            // tempNum = tempNum >> shiftByDelta; // shift by delta 0010...00
            // shiftedNum = tempNum[10:1]; // 001000000, only the first 10 are taken -> take 12 for G and R bits 
        end

endmodule

   // if(exp1 > exp2)
            //     begin                     
            //         barrelShifter shiftNum2(num2_tempMant, num2_mant, delta);
            //         num2_newMant[11:0]  = {2'b00, num2_tempMant[9:0]};
            //         num1_newMant[11:0]  = {2'b01, num1_mant[9:0]};
            //     end

            // else if(exp1 < exp2)
            //     begin 
            //          barrelShifter shiftNum1(num1_tempMant, num1_mant, delta);
            //          num1_newMant  = {2'b00, num1_tempMant[9:0]};
            //          num2_newMant  = {2'b01, num2_mant[9:0]};
            //     end

            // else // ******equal exponents , check case *********
            //     begin
            //         num2_newMant  = {2'b01, num2_newMant[9:0]};
            //         num1_newMant  = {2'b01, num1_newMant[9:0]}; 
            //     end


//  // case 3: 00.xxxx
//             else 
//                 begin
//                     // Finding the position of the first 1 after decimal
//                     for(i = 9; j>=0 && i >= 0; i=i+0) 
//                         begin

//                             if(int_mantissa[i]==1) 
//                                 begin
//                                     j = -1; //break statement
//                                 end 

//                             else 
//                                 begin
//                                 i=i-1; // to resolve latch
//                                 end
//                         end   

//                     // shifting for case 3 
//                     if(i>=0 && j == -1) 
//                         begin
//                             // shiftItbyThis = 10 - i;
//                             int_mantissa[11:0] << 10-i;
//                             // int_mantissa = {int_mantissa[(10-i-1):0], (i+1)'b0};

//                             y[9:0] = int_mantissa[9:0];
//                             exp1 = exp1 - 10 + i;

//                             if(exp1 < 0) 
//                                 begin
//                                     UnderFlowFlag = 1;
//                                 end 
//                             else 
//                                 begin
//                                     UnderFlowFlag = 0;
//                                 end
//                         end
                           
//                     else 
//                         begin
//                             y[14:0] = 0; // exp covered
//                             NotZero = 0;
//                         end    
