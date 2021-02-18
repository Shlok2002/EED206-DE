module Experiment5c(); // Division Circuit - Testbench

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

logic N1,N0,D1,D0,Q1,Q0,R1,R0;
Division_circuit Division(N1,N0,D1,D0,Q1,Q0,R1,R0);

initial begin

  N1=in[0];
  N0=in[1];
  D1=in[2];
  D0=in[3];

#5
  out[0] = Q1;
  out[1] = Q0;
  out[3] = R1;
  out[4] = R0;

end

initial begin
//Generating output text file

  #5 outf = $fopen("C:\\Digikitv3.1Win64\\output.txt","w");
  #5 $fwrite(outf,"output1 %0b output2 %0b output3 %0b output4 %0b output5 %0b output6 %0b output7 %0b output8 %0b output9 %0b output10 %0b output11 %0b output12 %0b output13 %0b",out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12]);
  #5 $fclose(outf);

end
endmodule  //End of Testbench

//DESIGN - DIVISION CIRCUIT

module and_4in(and4_out,a,b,c,d); //4_input AND gate
   	input a,b,c,d;
  	wire t1,t2;
   	output and4_out;

   	and	and1(t1,a,b),
       		and2(t2,c,d),
      		and3(and4_out,t1,t2);
endmodule // End of 4-input AND gate module

module Division_circuit (N1,N0,D1,D0,Q1,Q0,R1,R0);
	input N1,N0,D1,D0;
	wire w1,w2,w3,N1N,N0N,D1N,D0N;
	output Q1,Q0,R1,R0;

	and_4in an1(R1,N1,N0N,D1,D0),
		an2(R0,w3,N0,D1,1'b1);
	and 	a1(Q1,N1,D1N),
		a2(Q0,w1,w2);
	or	o1(w1,N0,D0N),
		o2(w2,N1,D1N),
		o3(w3,N1N,D0N);
	not	n1(N1N,N1),
		n2(N0N,N0),
		n3(D1N,D1),
		n4(D0N,D0);
endmodule
		
	

