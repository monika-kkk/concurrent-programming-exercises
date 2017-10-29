with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random, Ada.Unchecked_Deallocation;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Drzewo is
	
    package Los_Liczby is new Ada.Numerics.Discrete_Random(Integer);
    use Los_Liczby;
    
type Node is
  record 
    Data : Integer := 0;
    Left : access Node := Null;
    Right : access Node := Null;
  end record;    
  
type NodePtr is access all Node;

--„a(b(d,e),c(,f(g,)))”
procedure Print(Tree : NodePtr) is
begin
	if Tree = Null then
		return;
	elsif Tree.Left = Null and Tree.Right = Null then
		Put(Tree.Data,0);
	else
		Put(Tree.Data,0);
		Put(Character'Val(40));
		Print(Tree.Left);
		Put(',');
		Print(Tree.Right);
		Put(Character'Val(41));
	end if;
end Print; 

-- without duplicates
procedure InsertIntoBST(Tree : in out NodePtr; Number : Integer) is
begin
	if Tree = Null then
		 Tree := new Node'(Number, Null, Null);
	elsif Number < Tree.Data then
		
		if Tree.Left = Null then
			Tree.Left := new Node'(Number, Null, Null);
		else
			InsertIntoBST(Tree.Left, Number);
		end if;
	elsif Number > Tree.Data then
		if Tree.Right = Null then
			Tree.Right := new Node'(Number, Null, Null);
		else
			InsertIntoBST(Tree.Right, Number);
		end if;
	end if;	
end;

procedure GenerateAndInsert(Tree: in out NodePtr; N : in Integer; M : in Integer) is
	Gen: Generator;
	Number : Integer;
begin
 	Reset(Gen);
	for I in 1..N loop
		Number := Random(Gen) mod M;
		InsertIntoBST(Tree, Number);
	end loop;
end;


procedure saveAsDot(Tree: in out NodePtr; File : in out File_Type) is
begin
	if Tree = Null then 
		return; 
	end if;
	
	if Tree.Left /= Null then
		put(File, Tree.Data,0);
		put(File, "->");
		saveAsDot(Tree.Left, File);
	end if;
	if Tree.Right /= Null then
		put(File, Tree.Data,0);
		put(File, "->");
		saveAsDot(Tree.Right, File);
	end if;
	if Tree.Left = Null and Tree.Right = Null then
		put(File, Tree.Data,0);
		put(File, ';');
		put_Line(File, "");
	end if;
end;

Tree : NodePtr := Null;
File : File_Type;
begin
	GenerateAndInsert(Tree, 8, 23);
	Print(Tree);

	Create(File, Out_File, "tree.dot");
  	saveAsDot(Tree, File);
  	Close(File);
end Drzewo;

--xml/json; prettyPrint