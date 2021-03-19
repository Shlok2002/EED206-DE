module Experiment_8d(); //Sequential ALU operations

//Declaring general variables

logic in [0:14];
logic out [0:12];
logic state [0:8];

int outf,statef,i;

initial begin

//Reading input and state text files

  $readmemb("C:\\Digikitv3.1Win64\\input.txt",in);
  $readmemb("C:\\Digikitv3.1Win64\\state.txt",state);
  
//Assigning default values of the output variables

  for(i=0;i<13;i=i+1)
    begin
    	out[i] = 1'bz;
    end
  end

//Instantiating Parallel_Register module

logic [3:0] D1,D2,Q1,Q2,Q1_prev,Q2_prev,A,B,Y;
logic clk,clk_prev,MR,EIbar1,EIbar2,EObar1,EObar2,Carryout;
logic [2:0] sel;

ALU aluop(A,B,sel,Y,Carryout);
Parallel_Register reg1(D1,Q1,Q1_prev,clk,clk_prev,MR);
Parallel_Register reg2(D2,Q2,Q2_prev,clk,clk_prev,MR);

	assign D1 = EIbar1?Q1_prev:Y;
	assign D2 = EIbar2?Q2_prev:Y;
	assign  A = EObar1?(EObar2?4'bzzzz:Q2):(EObar2?Q1:4'bxxxx);

initial begin
// Assignments of Switches and retrieving state variables
	for(i=0;i<4;i++)
      begin
		B[3-i] = in[i];
		Q1_prev[i] = state[i];
		Q2_prev[i] = state[4+i];
	  end
		    MR = in[5];
		EIbar1 = in[6];
		EIbar2 = in[7];
        EObar1 = in[8];
		EObar2 = in[9];
		sel[2] = in[11];
		sel[1] = in[12];
		sel[0] = in[13];
		clk = in[14];
		clk_prev = state[8];
#5
// Assignments of output and state variables
		out[0] = Carryout;
	for(i=0;i<4;i++)
      begin
		out[1+i] = Y[3-i];
		out[5+i] = A[3-i];
		state[i] = Q1[i];
		state[4+i] = Q2[i];
      end
		state[8] = clk;
		
     //$display("clk = %b",clk);
     //$display("clk_prev = %b",clk_prev);
     //$display("Q = %b",Q);
	
//state_string = {state[0],"\n",state[1],"\n",state[2],"\n",state[3],"\n",state[4],"\n",state[5],"\n",state[6],"\n",state[7]}
//Generating output and state text files
  
  #5 outf = $fopen("C:\\Digikitv3.1Win64\\output.txt","w");
     statef = $fopen("C:\\Digikitv3.1Win64\\state.txt","w");
  #5 $fwrite(outf,"output1 %0b output2 %0b output3 %0b output4 %0b output5 %0b output6 %0b output7 %0b output8 %0b output9 %0b output10 %0b output11 %0b output12 %0b output13 %0b",out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12]);
     $fwrite(statef,"%0b\n%0b\n%0b\n%0b\n%0b\n%0b\n%0b\n%0b\n%0b",state[0],state[1],state[2],state[3],state[4],state[5],state[6],state[7],state[8]);
  #5 $fclose(outf);
     $fclose(statef);
end
endmodule

module D_FF (D,Q,Q_prev,clk,clk_prev,Rd,Sd);//positive-logic clock, Set and Reset
	input D,Q_prev,clk_prev,clk,Rd,Sd;
	output Q;
	wire Qsync;
		assign Q = Rd?(Sd?1'bx:1'b0):(Sd?1'b1:Qsync);
		assign Qsync = clk_prev?Q_prev:(clk?D:Q_prev);
endmodule

module Parallel_Register(D,Q,Q_prev,clk,clk_prev,MR);
	input MR,clk,clk_prev;
	input [3:0]Q_prev,D;
	output [3:0]Q;
	wire Sd,Rd;
		assign Rd = MR;
		assign Sd = 1'b0;
D_FF ff0(D[0],Q[0],Q_prev[0],clk,clk_prev,Rd,Sd);
D_FF ff1(D[1],Q[1],Q_prev[1],clk,clk_prev,Rd,Sd);
D_FF ff2(D[2],Q[2],Q_prev[2],clk,clk_prev,Rd,Sd);
D_FF ff3(D[3],Q[3],Q_prev[3],clk,clk_prev,Rd,Sd);
endmodule

module ALU(A,B,sel,Y,CO);

