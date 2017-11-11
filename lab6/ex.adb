-- przykłady wykorzystania wyjątków w Adzie
--
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Ex is

   procedure Divide_Loop(Index : in     INTEGER) is
   Divide_Result : INTEGER;
   begin
      Put("Nr ");
      Put(Index, 3);
      Put(" i wynik");
      Divide_Result := 25 / (4 - Index); -- samo wyrzuci wyjątek
      Put(Divide_Result, 4);
      New_Line;
   exception -- catch -- składnia: when Wyjątek => instrukcje
      when Constraint_Error => Put(" Pamietaj cholero nie dziel przez zero");
                               Put_Line(" petla 1");
   end Divide_Loop;

   procedure New_Divide_Loop(Index : in     INTEGER) is
      My_Own_Exception : Exception; -- własny wyjątek
      Divide_Result : INTEGER;
   begin
      Put("Nr");
      Put(Index, 3);
      Put(" wynik");
      if Index = 4 then
         raise My_Own_Exception; -- rzucenie wyjątku
      end if;
      Divide_Result := 25 / (4 - Index);
      Put(Divide_Result, 4);
      New_Line;
   exception
      when My_Own_Exception => Put(" Dzielnie przez zero !");
                               Put_Line(" petla 3");
      when Constraint_Error => Put_Line("Blad ograniczen");
                               Put_Line("Nie powinien wystapic");
      when others => Put_Line("Inne problemy w koalicji");
   end New_Divide_Loop;

begin
   Put_Line("Jedziemy.");
   for Count in 1..6 loop
      Divide_Loop(Count);
   end loop;
   Put_Line("Koniec petli 1.");

   for Count in 1..6 loop
      declare
         Divide_Result : INTEGER; -- deklaracja zmiennej blokowej
      begin
         Put("Licznik ");
         Put(Count, 3);
         Put(" i wynik");
         Divide_Result := 25 / (4 - Count);
         Put(Divide_Result, 4);
         New_Line;
      exception
         when Constraint_Error => Put(" Dzielenie przez zero");
                                  Put_Line(" w petli 2.");
      end;
   end loop;
   Put_Line("Koniec drugiej petli");

   for Count in 1..6 loop
      New_Divide_Loop(Count);
   end loop;
   Put_Line("Koniec koncow.");

end Ex;

