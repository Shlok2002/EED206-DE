module Experiment5b(); // Decryption circuit

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

logic P,Q,R,S,A,B,C,D;
Decryption_circuit Decrypt(P,Q,R,S,D,C,B,A);

//DEFINING INPUTS
 
 initial begin

	P = in[0];
	Q = in[1];
	R = in[2];
	S = in[3];

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

//DESIGN - DECRYPTION CIRCUIT

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

module Decryption_circuit(P,Q,R,S,D,C,B,A);
	input P,Q,R,S;
	wire w1,w2,w3,w4,w5,w6,w7,PN,QN,RN,SN;
	output D,C,B,A;

	and_4in an1(w1,PN,RN,S,1'b1),
	an2(w3,PN,RN,SN,1'b1);
	
	or_4in or1(C,w3,w4,w5,1'b0),
	or2(B,w3,w6,w7,1'b0);
	and	a1(w2,Q,R),
	a2(w4,PN,QN),
	a3(w5,QN,RN),
	a4(w6,P,R),
	a5(w7,R,S);
	or	o1(D,w1,w2),
	o2(A,SN,1'b0);
	not	n1(PN,P),
		n2(QN,Q),
		n3(RN,R),
		n4(SN,S);

endmodule

