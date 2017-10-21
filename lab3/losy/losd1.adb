-- losd1

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Losd1 is
  -- konkretyzacja pakietu rodzajowego
  package Los_Boolean is new Ada.Numerics.Discrete_Random(Boolean);
  use Los_Boolean;
  
  Wart : Boolean;
  Gen: Generator; -- z pakietu Los_Boolean 
begin
  Reset(Gen);
  for I in 1..10 loop
    Wart := Random(Gen);
    Put_Line("Wylosowalem: " & Wart'Img);
  end loop;
end Losd1;    