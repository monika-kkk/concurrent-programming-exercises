-- hi.adb

with Ada.Text_IO;
use Ada.Text_IO;

procedure Hi is
 Imie: String(1..20) := (others => ' '); 
 Dlugosc: Integer := 0;
begin
  Put_Line("Wpisz swoje imię");
  loop
    Get_Line(Imie,Dlugosc);
    if Imie(1) = '*' then 
      Put_Line("Rezygnacja");
      return;
    elsif not (Dlugosc = 0) then 
	  exit; -- /=
    else 
	  Put_Line("Prosze wpisz swoje imie");
    end if;
  end loop;
  Put_Line("Hi " & Imie(1..Dlugosc)); 
  
end Hi; 
 