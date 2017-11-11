with Ada.Text_IO, Ada.Integer_Text_IO,ada.float_text_io; 
use Ada.Text_IO, Ada.Integer_Text_IO,ada.float_text_io;

procedure Licz is

   procedure razy_dWa(Item : in out Integer) is
   begin 
     Item := Item * 2;
   end RAZY_DwA;

  X : Integer := 1;

  begin
    loop
       get(X);
       New_Line;
       RaZy_DwA(X);
       Put(X);
       New_Line;
       exit when x=0;
    end loop;                                        
end lICZ;

procedure dwa is
i1, i2: integer:= 0;
f1, f2: float:= 0.0;

begin
   i1 := (i2+1)*5;
   f2 := 1.0*8.0;
   f1 := float(i1)+f2;
   put_line("Output result f1 = ");
   put(f1); new_line;
end dwa;


