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


procedure recursivelySaveTreeAsDot(Tree: in out NodePtr; File : in out File_Type) is
begin
	if Tree = Null then 
		return; 
	end if;
	
	if Tree.Left /= Null then
		put(File, Tree.Data,0);
		put(File, "->");
		recursivelySaveTreeAsDot(Tree.Left, File);
	end if;
	if Tree.Right /= Null then
		put(File, Tree.Data,0);
		put(File, "->");
		recursivelySaveTreeAsDot(Tree.Right, File);
	end if;
	if Tree.Left = Null and Tree.Right = Null then
		put(File, Tree.Data,0);
		put(File, ';');
		put_Line(File, "");
	end if;
end;

procedure saveAsDot(Tree : in out NodePtr; Filename : String) is
File : File_Type;
begin
	Create(File, Out_File, Filename);
	put_Line(File, "digraph t" & '{');
  	recursivelySaveTreeAsDot(Tree, File);
  	put(File, '}');
  	Close(File);

end;


function search(Tree : in NodePtr; V : Integer) return Boolean is
begin
	if Tree = Null then
		return false;
	elsif Tree.Data = V then
		return true;
	elsif V < Tree.Data then
		return search(Tree.Left, V);
	else
		return search(Tree.Right, V);
	end if; 
end;

function findParent(Tree : in NodePtr; V : Integer) return NodePtr is
begin
	if Tree = Null or else Tree.Data = V then
		return Null;
	elsif Tree.Left /= Null and then Tree.Left.Data = V then
		return Tree;
	elsif Tree.Right /= Null and then Tree.Right.Data = V then		
		return Tree;
	elsif V < Tree.Data then		
		return findParent(Tree.Left, V);
	else
		return findParent(Tree.Right, V);
	end if; 
end;

procedure Free is new Ada.Unchecked_Deallocation(Node, NodePtr);

function findAndDeleteMin(Tree : in out NodePtr) return Integer is
	El : NodePtr := Null;
	Data : Integer;
begin
	if Tree.Left = Null then
		Data := Tree.Data;
		Free(Tree);
		return Data;
	elsif Tree.Left.Left = Null then
		Data := Tree.Left.Data;
		Free(Tree.Left);
		return Data;
	else
		return findAndDeleteMin(Tree.Left);
	end if;
end;

-- Probably the ugliest procedure I've ever written 
procedure delete(Tree : in out NodePtr; V : Integer) is
	Ptr : NodePtr := Null;
	El : NodePtr := Null;
begin

	Ptr := findParent(Tree, V);
	
	-- root
	if Ptr = Null then
		El := Tree;
		if (El.Left = Null) then
			Tree := El.Right;
			Free(El);
		elsif (El.Right = Null) then
			Tree := El.Left;
			Free(El);
		else
			El.Data := findAndDeleteMin(El.Right);
		end if;	
	
	-- left child
	elsif Ptr.Left /= Null and then Ptr.Left.Data = V then
		El := Ptr.Left;
		if (El.Left = Null) then
			Ptr.Left := El.Right;
			Free(El);
		elsif (El.Right = Null) then
			Ptr.Left := El.Left;
			Free(El);
		else
			El.Data := findAndDeleteMin(El.Right);
		end if;	
	
	-- right child		
	else
		El := Ptr.Right;
		if (El.Left = Null) then
			Ptr.Right := El.Right;
			Free(El);
		elsif (El.Right = Null) then
			Ptr.Right := El.Left;
			Free(El);
		else
			El.Data := findAndDeleteMin(Tree);
		end if;	
	end if;
			
end;
-- I can't stand to look at if-else loops anymore


Tree : NodePtr := Null;
begin
	GenerateAndInsert(Tree, 8, 23);
	InsertIntoBST(Tree,5);
	InsertIntoBST(Tree,15);
	
  	saveAsDot(Tree, "tree.dot");
	
	Print(Tree);
	New_Line;
	New_Line;
	
	Put_Line(search(Tree, 5)'Img);
	Put_Line(search(Tree, 30)'Img);
	Put_Line(search(Tree, 40)'Img);
	New_Line;

	delete(Tree, 5);
	delete(Tree, 15);
	
	saveAsDot(Tree, "tree2.dot");
	
	Print(Tree);
	
end Drzewo;

--xml/json; prettyPrint
--in/out
--BST balancing