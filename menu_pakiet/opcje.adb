-- opcje.adb

with Ada.Text_IO;
use Ada.Text_IO;

package body Opcje is

procedure NDK is
  Znak: Character := '0';
begin
  Put_Line("Nacisnij dowolny klwaisz");	
  Get_Immediate(Znak);	
end NDK;
		
procedure Opcja_S is
begin
  Put_Line("Jestes w opcji S");
  NDK;
end Opcja_S;
  
procedure Opcja_C is
begin
  Put_Line("Jestes w opcji C");
  NDK;
end Opcja_C;

procedure Opcja_P is
begin
  Put_Line("Jestes w opcji P");
  NDK;
end Opcja_P;

end Opcje;