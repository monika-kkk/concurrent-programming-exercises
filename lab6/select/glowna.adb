-- przykłady: pakiet, select w zasdaniu, access do zadania jako parametr wywołania

with Zadania;
with Ada.Text_Io;
use Zadania,Ada.Text_Io;

procedure Glowna is
   Server   : S1_access;
   Client   : C1_access;

begin

   Server := new S1;
   Client := new C1(Server);
   
end Glowna;
