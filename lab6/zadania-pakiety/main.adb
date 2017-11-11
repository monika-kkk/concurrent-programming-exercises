with PWiR.lab2;use PWiR.lab2;

procedure main is
I:Integer :=4;
z:Integer;
ZA:zadanie_a_acc;
ZB:zadanie_b_acc;
begin
	za:= new zadanie_a;
	zb:= new zadanie_b(za);
end main;

