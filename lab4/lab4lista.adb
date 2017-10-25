-- lab4.adb
-- Materiały dydaktyczne
-- J.P. 2017

-- pragma Debug(Put_Line("Debug message")); gnatmake -gnata

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random, Ada.Unchecked_Deallocation;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is
	
    package Los_Liczby is new Ada.Numerics.Discrete_Random(Integer);
    use Los_Liczby;

type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null; -- wskaznikowy typ anonimowy
  end record;    
  
type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:");  
  end if;  
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;  

procedure Insert(List : in out Elem_Ptr; D : in Integer) is -- bardziej uniwersalne, można z out
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List); podstawienie na raz wszystkich wartosci
  List := E;
end Insert; 

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) );  
  
  
   
procedure InsertSort(List : in out Elem_Ptr; D : in Integer) is 
L : access Element := List;
NewEl : access Element;
begin
  L := List;
  if List = Null then
		L := new Element'(D, Null);
  elsif L.Data > D then
	  List := new Element'(D, L);  
  else
	  while  L.Next /= Null and then L.Next.Data < D loop
		  L := L.Next;
	  end loop;
	  NewEl := new Element'(D,L.Next);
	  L.Next := NewEl;  
  end if;
end InsertSort;      

procedure GenerateAndInsert(List: in out Elem_Ptr; N : in Integer; M : in Integer) is
	Gen: Generator;
	Number : Integer;
begin
	for I in 1..N loop
		Number := Random(Gen) mod M;
		InsertSort(List, Number);
	end loop;
end;

function search(List : in Elem_Ptr; El : in Integer) return Boolean is
	L : access Element := List;
begin
    while L /= Null loop
      if L.Data = El then
      	return True;
	  end if;
	  L := L.Next;
    end loop; 
	return False;
end;

procedure Free is new Ada.Unchecked_Deallocation(Element, Elem_Ptr);

procedure remove(List: in Elem_Ptr; El : in Integer) is
	L : access Element := List;
	Temp : access Element;
begin	
	if (L /= Null) then
		while L.Next /= Null loop
			if L.Next.Data = El then
				Temp := L.Next.Next;
				Free(L.Next);
				L.Next := Temp;
			end if;
			L := L.Next;
		end loop;	
	end if;
end;

Lista : Elem_Ptr := Null;

begin
  Print(Lista);
  
  Lista := Insert(Lista, 21);
  Insert(Lista, 20);  
  Print(Lista);
  
  for I in reverse 1..12 loop
    Insert(Lista, I);
  end loop;
  
  InsertSort(Lista, 5);
  InsertSort(Lista, 17);
  InsertSort(Lista, 0);
  InsertSort(Lista, 30);
  Print(Lista);
  
  GenerateAndInsert(Lista,4,12);
  Print(Lista);
  
  Put(search(Lista, 40)'Img);
  New_Line;
  Put(search(Lista, 4)'Img);
  New_Line;
  
  remove(Lista, 2);
  remove(Lista, 3);
  Print(Lista);
  
  
end Lab4Lista;


