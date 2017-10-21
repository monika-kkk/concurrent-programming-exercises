with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body Vector_Packages is
	procedure printVector(V : Vector) is
	begin
		for El of V loop
			put_Line(Float'Image(El)); 
		end loop; 
	end printVector;
	
	procedure fillVectorWithRandomValues(V : in out Vector) is
	Gen : Generator;
	begin
		Reset(Gen);
		for I in V'Range loop
			V(I) := Random(Gen);
		end loop;	
	end fillVectorWithRandomValues;
	
	function isSorted(V : Vector) return Boolean is
		(for all I in V'First..(V'Last-1) => V(I)<=V(I+1) );
		
	procedure selectionSort(V : in out Vector) is
	minIndex : Integer;
	temp : Float;
	begin
		for i in V'First..V'Last-1 loop
			minIndex := i;
			
			for j in i..V'Last loop
				if V(j) < V(minIndex) then
					minIndex := j;
				end if;
			end loop;
				
			temp := V(minIndex);
			V(minIndex) := V(i);
			V(i) := temp;
			
		end loop;
	end selectionSort;
	
	procedure saveVector(V: Vector; Filename : String) is
	File : File_Type;
	begin
		Create(File, Out_File, Filename);
		
		for El of V loop
			Put_Line(File, El'Img);
		end loop; 
		
		Close(File);
	end saveVector;

end Vector_Packages;