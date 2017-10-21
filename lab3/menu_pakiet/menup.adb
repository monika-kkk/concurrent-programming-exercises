-- menup.adb

with Ada.Text_IO, Opcje;
use Ada.Text_IO, Opcje;

procedure MenuP is
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
	  when 's' => Opcja_S;
	  when 'c' => Opcja_C;
	  when 'p' => Opcja_P;
      when others => Put_Line("Blad!!");
	end case;
  end loop;
  Put_Line("Koniec");
end MenuP;
  	 
  