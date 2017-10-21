with Ada.Text_IO, Ada.Calendar, Vector_packages;
use Ada.Text_IO, Ada.Calendar, Vector_packages;

procedure Vector_Main is
	V1 : Vector(1..10);
	T1, T2: Time;  
  	D: Duration; 
begin
	T1 := Clock;

	V1 := (1.222, 2.0, others => 5.55);
	printVector(V1);
	new_Line;
	
	fillVectorWithRandomValues(V1);
	printVector(V1);
	new_Line;
	
	put_Line(isSorted(V1)'Img);
	new_Line;
	
	selectionSort(V1);
	printVector(V1);
	new_Line;
	put_Line(isSorted(V1)'Img);
	
	saveVector(V1, "vector.txt");
	
	T2 := Clock;
	D := T2 - T1;
	Put_Line("Execution time = " & D'Img & "[s]");
end;