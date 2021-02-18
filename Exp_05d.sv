module Experiment5d(); // Decoder circuit

//Declaring general variables

logic in [0:14];
logic out [0:12];


int outf,i;

initial begin

//Reading input and state text files

  $readmemb("C:\\Digikitv3.1Win64\\input.txt",in);

//Assigning default values of the output variables

  for(i=0;i<13;i=i+1)
  begin
    out[i] = 1'bz;
  end
end

//TOP MODULE FUNCTIONS

logic G0,G1,G2,G3,A,B,C,D;
Decoder_circuit Decoder(G3,G2,G1,G0,D,C,B,A);

//DEFINING INPUTS
 
 initial begin

	G3 = in[0];
	G2 = in[1];
	G1 = in[2];
	G0 = in[3];

#5
 	out[0] = D;
	out[1] = C;
	out[2] = B;
	out[3] = A;

end

initial begin

//Generating output text file

  #5 outf = $fopen("C:\\Digikitv3.1Win64\\output.txt","w");
  #5 $fwrite(outf,"output1 %0b output2 %0b output3 %0b output4 %0b output5 %0b output6 %0b output7 %0b output8 %0b output9 %0b output10 %0b output11 %0b output12 %0b output13 %0b",out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12]);
  #5 $fclose(outf);

end
endmodule  //End of Testbench

//DESIGN - DECODER CIRCUIT

module and_4in(and4_out,a,b,c,d); //4_input AND gate
   	input a,b,c,d;
  	wire t1,t2;
   	output and4_out;

   	and	and1(t1,a,b),
       		and2(t2,c,d),
      		and3(and4_out,t1,t2);
endmodule // End of 4-input AND gate module

module or_4in(or4_out,a,b,c,d); //4_input OR gate
   	input a,b,c,d;
  	wire t1,t2;
   	output or4_out;

   	or	and1(t1,a,b),
       		and2(t2,c,d),
		and3(or4_out,t1,t2);
endmodule // End of 4-input OR gate module

module Decoder_circuit(G3,G2,G1,G0,D,C,B,A);
	input G3,G2,G1,G0;
	wire w1,w2,w3,w4,w5,w6,w7,w8,G3N,G2N,G1N,G0N;
	output D,C,B,A;

	and_4in an1(D,G3,G1,G0N,1'b1),
		an2(w8,w3,w4,w5,w6);
	or_4in 	or1(w3,G3N,G2N,G1N,G0),
		or2(w4,G3N,G1,G0N,1'b0),
		or3(w5,G3,G1,G0,1'b0),
		or4(w7,G3,G1N,G0N,1'b0);
	and 	a1(C,w1,w2),
		a2(B,G0,1'b1),
		a3(A,w8,w7);
	or	o1(w1,G1N,G0),
		o2(w2,G3,G0N),
		o3(w6,G3,G2);
	not	n1(G3N,G3),
		n2(G2N,G2),
		n3(G1N,G1),
		n4(G0N,G0);
endmodule
		