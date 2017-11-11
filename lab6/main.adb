with Ada.Text_Io;
use  Ada.Text_Io;
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;
procedure Main is
		package FTIO is new Ada.Text_IO.Float_IO (Float);
	type MyInt is range 1..6; 
	type arrayFloat2d is array (integer range <>,integer range <>) of float;
	type arrayFloat3d is array (integer range <>,integer range <>,integer range <>) of float;
	type arrayFloat2d_ptr is access arrayFloat2d;
	type arrayFloat3d_ptr is access arrayFloat3d;
	G : Generator;

	-- nie wymaga utworzenia oddzielnej zmiennej, wywoływane automatycznie
	task zX is 
			entry xx; -- wejscie
		end;

		task body zx is
		begin
				loop
					put("here");
					accept xx; -- synchronizacja (czeka na wejście)
					put("and here");
				end loop;
		end;

	-- trzeba stworzyć zmienną
	task type B is 
			entry X;
	end;
	task body B is
	begin
		put("B");
			accept X;
			zX.xx;
	end;

	type B_acc is access B;

	task type A(zad:b_acc) is 
			entry B;
		end;
	task body A is 
	begin
		put("C");
			accept B;
	end;


	function readtab return arrayFloat3d_ptr is 
		m1p:arrayFloat3d_ptr;
	begin
		m1p := new arrayFloat3d(1..10,1..10,1..1);
		for x in m1p'range(1) loop -- sprawdzenie wymiaru wielowymiarowej tablicy
				for y in m1p'range(2) loop
						for z in m1p'range(3) loop
								m1p(x,y,z):= random(g); -- gdzie reset?
						end loop;
				end loop;
		end loop;
	
		return m1p;
	end;

	function readtab return arrayFloat2d_ptr is 
		m1p:arrayFloat2d_ptr;
	begin
		m1p := new arrayFloat2d(1..10,1..10);
		return m1p;
	end;

	procedure save (arr: in arrayFloat2d) is
	begin 
		for x in arr'range(1) loop
			for y in arr'range(2) loop
				null;
			end loop;
		end loop;
	end save;

	procedure save (arr: in arrayFloat3d) is
	begin 
		for x in arr'range(1) loop
			for y in arr'range(2) loop
				for z in arr'range(3) loop
					null;
				end loop;
			end loop;
		end loop;
	end save;

	procedure display (arr: in arrayFloat3d) is
	begin 
		for x in arr'range(1) loop
			for y in arr'range(2) loop
				for z in arr'range(3) loop
					ftio.put(arr(x,y,z),exp=> 10); -- odwołanie się do elementu 3-wymiarowej tablicy
					--są domyślne parametry, można specyfikować pojedyncze
				end loop;
				new_line;
			end loop;
			new_line;
		end loop;
		new_line;
	end display;



	m3a: arrayFloat3d_ptr;
begin
	Put_Line("witaj Ada");
	if 4<3 then
		Put_line("4<3");
	end if;
	for I in 1..20 loop
		Put(".");Put(Integer'Image(I));
		delay(0.02);
	end loop;
	m3a := readtab; -- dopasuje funkcje do oczekiwanego typu?
	display(m3a.all); -- 'wartość'
	save(m3a.all);
end Main;
