Pragma Queuing_Policy(FIFO_Queuing);
--pragma Assertion_Policy(Check);
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Command_Line;
with Ada.Strings.Unbounded;
with ada.IO_Exceptions;
with Ada.Assertions;
use Ada.Assertions;
procedure recordpers is
 
   package T_IO renames Ada.Text_IO;
   package SU   renames Ada.Strings.Unbounded;
 
   type s_person is
      record
         fname : SU.Unbounded_String;
         sname : SU.Unbounded_String;
         age   : Integer range 0 .. 120;
      end record;
   type Person  is new s_person;
 
   LPers : array (0 .. 10) of Person;
   --SPers : array (0 .. 3) of Person;
   --Family : array (-10 .. 10) of Person;
 
   Init : array (0 .. 3) of Integer := (0 .. 3 => 1);
   --Init : array (0 .. 3) of Integer := (0 => 1, others => 0);
 
   Log : FILE_TYPE;
   One_Char: CHARACTER;
 
begin
   pragma Assert(LPers'Last>10);
   Create(Log,Out_File,"Log.txt");
   for i in LPers'First..LPers'Last loop
      LPers(i):=(fname=>SU.To_Unbounded_String("Adam"), sname=>SU.To_Unbounded_String("Slodowy"),age=>66);
   end loop;
   LPers(0 .. 3) := LPers(5 .. 8);
   Set_Output(Log);
   Put_Line(Standard_Output,"Lecimy");
   for i in LPers'First..LPers'Last loop
      Put(SU.To_String(LPers(i).fname));Put(" ");
      Put(SU.To_String(LPers(i).sname));Put(" ");
      Put(LPers(i).age);New_Line;
   end loop;
   Set_Output(Standard_Output);
   Close(Log);
 
   Open(Log,In_File,"Log.txt");
   --	begin
   loop
      --	exit when End_Of_File(Log);
      --		begin
      Get(Log, One_Char);
      Put(One_Char);
      --		exception
      --			when ADA.IO_EXCEPTIONS.END_ERROR => null;
      --		end;
   end loop;
   --	exception
   --	  when ADA.IO_EXCEPTIONS.END_ERROR => null;
   --	end;
 
   New_Line(3);
   Reset(Log);
 
   loop
      exit when End_Of_File(Log);
      Get(Log, One_Char);
      Put(One_Char);
      if End_Of_Line(Log) then
         Put("<- EOL");
         New_Line;
      end if;
   end loop;
 
   Close(Log);
exception
   when ADA.IO_EXCEPTIONS.END_ERROR => null;
end recordpers;