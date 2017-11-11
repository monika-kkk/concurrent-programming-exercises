package PWiR.Lab2 is

	procedure loop_test ( Ile: in out Integer);

	function inv_loop ( Ile  : in Integer)
		      return Integer;
		
	procedure while_test (Ile: in Integer);

	task type Zadanie_A is
		entry Wymiana (S: in String);
	end Zadanie_A;

	type Zadanie_A_acc is Access Zadanie_A;
	
	task type zadanie_b(za:zadanie_a_acc) is
	end zadanie_b;
	
	type zadanie_b_acc is access zadanie_B;
end  PWiR.Lab2;

