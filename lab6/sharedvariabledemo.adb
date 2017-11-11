with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Integer_Text_IO;

procedure SharedVariableDemo is

-- typ chroniony - konstrukcja, operacje z wzajemnym wykluczaniem, asynchroniczna komunikacja
-- zadanie - obiekt aktywny, obiekt chroniony - pasywny
   protected type SharedVariable is 
      procedure Reset;
      entry Read; --wejscie, punkt spotkania, SharedVariable to serwer
      entry Write;
   private
      V : integer := 0; -- dane, prywatna specyfikacja; licznik
   end;

   protected body SharedVariable is -- treść obiektu chronionego, definicja poszczególnych części
      procedure Reset is
      begin
         V := 0;
      end;

      entry Read when V < 10 is --nie wywoła wejścia jeśli nie jest spełniony warunek
      begin
         V := V + 1;
         Put("R" & " " & V'img & " ");
      end;

      entry Write when V > -10 is
      begin
         V := V - 1;
         Put(V'img & " ");
      end;
   end;

   s : SharedVariable;
   g : Generator;
   n : float;
begin
   reset(g);
   loop -- nieskończona pętla
      n := random(g) * 15.0;
      delay 0.05; -- wstrzymanie wykonania
	  Put(" " & n'Img);
	  
	  --Jezeli oba wejscia zostały wywołane, to wybór instrukcji accept do wykonania jest niedeterministyczny.
      if n > 100.0 then
         select
            s.Read; -- klient wywołuje wejście, tutaj tylko synchronizacja bez parametrów
         or
            delay 2.0;
            Put_Line("Reset ***");
            s.Reset;
         end select;
      else
         select
            s.Write;
         or
            delay 2.0; -- jeśli nie wywołano żadnego wejścia wykonywane są te instrukcje
            Put_Line("Reset ***");
            s.Reset;
         end select;
      end if;
   end loop;
end;
-- reset generatora
-- task/obiekt chroniony <- kiedy używać?