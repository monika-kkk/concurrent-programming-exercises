-module(tree).
-compile([export_all]).
-import(lists, [foldl/3]).
-import(random, [uniform/1]).

-record(node, {v, l, r}).

createTree(V) -> #node{v=V, l=nil, r=nil}.

insert(nil , E) 
	-> createTree(E);
insert(T, E) when E == T#node.v
	-> T;
insert(T, E) when E < T#node.v, T#node.l == nil
	->  T#node{ l = createTree(E)};
insert(T, E) when E < T#node.v, T#node.l /= nil
	->  T#node{ l = insert(T#node.l, E)};
insert(T, E) when E > T#node.v, T#node.r  == nil
	->  T#node{ r = createTree(E)};
insert(T, E) when E > T#node.v, T#node.r /= nil
	->  T#node{ r = insert(T#node.r, E)}.
	
buildRandomTree(0, _, T) -> T;
buildRandomTree(N, Range, T) -> buildRandomTree(N-1, Range, insert(T, random:uniform(Range))).
	
randomTree(N, Range) -> buildRandomTree(N, Range, nil).


treeFromList(L) -> foldl(fun(E, T) -> insert(T, E) end, nil, L).

search(nil, _) -> false;
search(T, E) when E == T#node.v -> true;
search(T, E) when E < T#node.v -> search(T#node.l, E);
search(T, E) -> search(T#node.r, E).

checkWholeTree(nil, _) -> false;
checkWholeTree(T, E) when E == T#node.v -> throw(true);
checkWholeTree(T, E) -> checkWholeTree(T#node.r, E), checkWholeTree(T#node.l, E).

% not useful for BST 
betterSearch(T, V) ->
	try checkAllTree(T, V) of
		false -> false
	catch
		true -> true
	end.
	
	
tree2list(_, nil) -> [];
tree2list(Type, #node{v = V, l = L, r = R}) -> 
	case Type of
		lvr -> tree2list(Type, L) ++ [V] ++ tree2list(Type, R);
		vlr -> [V] ++ tree2list(Type, L) ++ tree2list(Type, R);
		_Else -> tree2list(Type, L) ++ tree2list(Type, R) ++ [V]
	end.
	