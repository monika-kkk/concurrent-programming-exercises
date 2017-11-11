with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Numerics.Float_Random;
use  Ada.Numerics.Float_Random;

package body Zadania is

  task body C1 is
    Gen  : Generator;
  begin
    delay(5.0);
    loop
      select
        Server.E1;
      or
      --	delay(1.5);
      --	delay(1.0);
      delay(Standard.duration(Random(Gen)));
      Put_Line("C1: S1 czyms zajety. Brak kontaktu");
    end select;
    Server.E2;
    Server.E3;
    Server.Y1;
  end loop;
end C1;
--***************************************--
task body S1 is
  Gen : Generator;
begin
  loop
    select 
    accept E1 do
      Put_Line("S1: zostalo wywolane wejscie E1");
    end E1;
    or
    accept E2 do
      Put_Line("S1: zostalo wywolane wejscie E2");
    end E2;
    or
    accept E3 do
      Put_Line("S1: zostalo wywolane wejscie E3");
    end E3;
    or
    accept Y1 do
      Put_Line("S1: zostalo wywolane wejscie Y1 i 2 sek tu czekamy"); --?????
    end Y1;
	--delay(Standard.duration(Random(Gen)));
    delay(2.0); --pomiędzy  'or' można wprowadzać instrukcje wykonywane przez serwer
    or
    delay(1.0);
    Put_Line("S1: Czeka");
  end select;      
end loop;

   exception
     when Blad: CONSTRAINT_ERROR => --kiedy taki błąd?
       Put_Line("Bald dzialania programu serwera S1 !!!");
     when others =>
       Put_Line("Wystapil nierozpoznany blad serwera S1 !!!");
   end S1;
  end zadania;

