-- losd2

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Losd2 is

  type Kolory is (Czerwony, Zielony, Niebieski);
  package Los_Kolor is new Ada.Numerics.Discrete_Random(Kolory);
  use Los_Kolor;
  
  Wart : Kolory;
  Gen: Generator; -- z pakietu Los_Kolor 
begin
  Reset(Gen);
  for I in 1..20 loop
    Wart := Random(Gen);
    Put_Line("Wylosowalem: " & Wart'Img);
  end loop;
end Losd2;
