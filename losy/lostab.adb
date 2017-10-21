-- lostab

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure LosTab is
  Wart, Suma : Float := 0.0;
  R   : constant Positive := 20;
  Tab : array(1..R) of Float := (others => 0.0);
  Gen : Generator; -- z pakietu Ada.Numerics.Float_Random 
begin
  Reset(Gen);
  -- losowanie elementow z zapisem do tablicy
  for E of Tab loop 
    E := Random(Gen);
  end loop;
  -- wypisanie tablicy
  for  I in Tab'Range loop
    Put_Line("Tab(" & I'Img & ")=" & Tab(I)'Img);
  end loop;

end LosTab;    