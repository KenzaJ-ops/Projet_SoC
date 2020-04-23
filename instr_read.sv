`ifndef instr_read
`define instr_read

module instr_read (
  input valid,
  output reg [31:0] mem [8000]
  );


integer file;
reg [31:0] inst_mem [8000:0];


initial begin
     file = $fopen("C:/Users/bound/Desktop/ETUDE/Projet/Projet_Riscy/Projet_SoC/instr.txt", "r");
     if (file == 0) begin
       $display("instr_file handle was NULL");
      // $finish;
     end
     if (valid) begin
	   $readmemb("C:/Users/bound/Desktop/ETUDE/Projet/Projet_Riscy/Projet_SoC/instr.txt" ,inst_mem);
     $fclose(file); // Close file before finish
     end
end
endmodule
`endif
