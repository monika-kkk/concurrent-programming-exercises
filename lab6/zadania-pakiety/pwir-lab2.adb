with Ada.Text_IO,Ada.Integer_Text_IO;
use  Ada.Text_IO,Ada.Integer_Text_IO;

package body PWiR.Lab2 is

	procedure loop_test ( Ile: in out Integer) is
--	I:Integer;
	begin
		for i in 1..Ile 
		loop
			put(i);
	     		new_line;
	     	end loop;
	end loop_test;
	
	function inv_loop ( Ile  : in Integer)
			return Integer is
--	I:Integer;
	begin
		for i in reverse 1..Ile 
		loop
			put(i);
	     		new_line;
	     	end loop;
		return ile;
	end inv_loop;
		
	procedure while_test (Ile: in Integer) is
	I:Integer:=0;
	begin
		while i < Ile 
		loop
			put(i); 
			new_line;
			i := i +1;
		end loop;
	end while_test;

	task body  Zadanie_a is
--	X:String;
		begin
			loop
				accept Wymiana (S: in String) do
									delay 0.7;
					Put(s);
					New_Line;

				end Wymiana;
			end loop;
	end Zadanie_a;

	task body  Zadanie_B is
--	X:String;
		begin
			loop
				za.Wymiana ("sssssss")	;
						delay 1.7;
			end loop;
	end Zadanie_b;
end  PWiR.Lab2;

