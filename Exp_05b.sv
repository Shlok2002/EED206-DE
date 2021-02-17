module Experiment5a(); // Decryption circuit

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
Decryption Decrypt(P,Q,R,S,A,B,C,D);

//DEFINING INPUTS
 
 initial begin

	P = in[0];
	Q = in[1];
	R = in[2];
	S = in[3];
#5initial begin

//Generating output text file

  #5 outf = $fopen("C:\\Digikitv3.1Win64\\output.txt","w");
  #5 $fwrite(outf,"output1 %0b output2 %0b output3 %0b output4 %0b output5 %0b output6 %0b output7 %0b output8 %0b output9 %0b output10 %0b output11 %0b output12 %0b output13 %0b",out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12]);
  #5 $fclose(outf);

end
endmodule  //End of Testbench

	out[0] = A;
	out[1] = C;
	out[2] = A;
	out[3] = D;

end





