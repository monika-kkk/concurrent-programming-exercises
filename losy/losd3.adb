-- losd3

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Losd3 is

  package Los_Znak is new Ada.Numerics.Discrete_Random(Character);
  use Los_Znak;
  
  Wart : Character := 'a';
  Gen: Generator; -- z pakietu Los_Znak 
begin
  Reset(Gen);
  for I in 1..20 loop
    Wart := Random(Gen);
    Put_Line("Wylosowalem: >" & Wart & "<");
  end loop;
end Losd3;    