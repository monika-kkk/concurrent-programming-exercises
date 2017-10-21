-- czaso.adb

with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure Czaso is
  T1, T2: Time; -- czasy bezwzgledne
  D: Duration;  -- czas względny, 
  Bu : Boolean := True; 
  Su: Integer := 0;
begin
  T1 := Clock; -- odczytanie aktualnego czasu
  -- obliczenia
  for I in 1..10_000_000 loop
    -- dowolna tresc petli np.
    Su := (if Su > 1_000 then 0 else Su + 1); -- wyrazenie warunkowe
    Bu := not Bu;
  end loop; 
  T2 := Clock;
  D := T2 - T1;
  Put_Line("Czas obliczen = " & D'Img & "[s]"); -- atrybut 'Img
end Czaso; 