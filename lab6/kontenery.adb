-- przykłady użycia kontenerów w adzie

with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Vectors;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.text_io;
procedure lista is
   package DLI is new Ada.Containers.Doubly_Linked_Lists(Integer);
   package VEI is new Ada.Containers.Vectors(Positive,Integer);
   use DLI;
   use VEI;
   Li:List;
   Vi: Vector;
   procedure Print(Position : DLI.Cursor) is --prototyp funkcji która jest argumentem iterowania
   begin
      Put((Element(Position))); Put(" ");
   end Print;

   procedure PrintV(Position : VEI.Cursor) is
   begin
      Put((Element(Position))); Put(" ");
   end PrintV;

begin
   Li.Append(14);
   Li.Append(24);
   Li.Append(34);
   Li.Append(4);
   Li.Append(54);
   Li.Append(2);
   Li.Append(1);
   Li.Append(42);
   Li.Append(44);
   Li.Insert(Before => Li.Find(42), New_Item => 11 ); -- funkcje biblioteczne
   Li.Iterate(Print'access); -- wskaźnik do podprogramu(funkcji)
   Vi.Append(1);
   Vi.Append(4);
   Vi.Append(44);
   Vi.Append(44);
   Vi.Append(44);
   Vi.Append(42);
   Vi.Append(44);
   Vi.Append(44);
   Vi.Append(44);

   Vi.Iterate(PrintV'access);
end lista;

--todo with/use