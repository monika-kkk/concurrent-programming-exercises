-- menu.adb

with Ada.Text_IO;
use Ada.Text_IO;

procedure Menu is
  Zn: Character := ' '; 
  
  procedure Pisz_Menu is
  begin
	New_Line;  
	Put_Line("Menu:");  
        Put_Line(" s - opcja s");
	Put_Line(" c - opcja c");
	Put_Line(" p - opcja p");
	Put_Line("ESC -Wyjscie");
	Put_Line("Wybierz (s,c,p, ESC-koniec):");
  end Pisz_Menu;
  
begin
  loop
    Pisz_Menu;
	Get_Immediate(Zn);
	exit when Zn = ASCII.ESC;
	case Zn is
	  when 's'|'c'|'p' => 
	    Put_Line("Wybrano opcje " & Zn); 
		delay 0.5; -- czeka 0.5 sek
      when others => Put_Line("Blad!!");
	end case;
  end loop;
  Put_Line("Koniec");
end Menu;
  	 
  