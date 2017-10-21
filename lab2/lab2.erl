-module(lab2).
-compile([export_all]).
-import(io, [format/2]).
-import(file, [open/2, read/2]).
-import(filelib, [wildcard/1]).
-import(maps, [fold/3, find/2, put/3]).


% Napisz funkcje map_append(Key, Value, Map) oraz map_update(Key, Value, Map) z wykorzystaniem "map syntax"
map_append(Key, Value, Map) -> Map#{Key => Value}.
map_update(Key, Value, Map) -> Map#{Key := Value}.


% Napisz funkcję map_display(Map) do ładnego wypisywania map.
map_display(Map) -> Fun = fun(K, V, ok) -> io:format("~p: ~p~n", [K, V]) end, %term - anything; format returns ok
                                           maps:fold(Fun, ok, Map).


% Napisz funkcję, która wczyta plik, podzieli go na tokeny i zwróci mapę zawierającą token jako klucz
% oraz ilość wystąpień danego tokenu jako wartość z nim skojarzoną. W tym zadaniu może być wygodniej zastosować funkcje z modułu maps.
% Przykładowo dla pliku zawierającego: "Ala ma kota. Ala ma psa." funkcja powinna zwrócić
%#{ "Ala" => 2, "ma" => 2, "kota" => 1, "psa" => 1}

getFileData(Filename) -> case file:open(Filename, [read]) of
                           {ok, File} -> case file:read(File, 100) of
                                           {ok, Data} -> Data;
                                           {error, _} -> []
                                         end;
                           {error, _} -> []
                         end.

tokenizeFileData(Data) -> string:lexemes(Data, ". \s\n").


buildTokenMap(Map, []) -> Map;
buildTokenMap(Map, [H | T]) -> case maps:find(H, Map) of
                                 {ok, Val} -> buildTokenMap(maps:put(H, Val + 1, Map), T);
                                 error -> buildTokenMap(maps:put(H, 1, Map), T)
                               end.


getFileMap(Filename) -> buildTokenMap(#{}, tokenizeFileData(getFileData(Filename))).


% Napisz funkcje zwracającą mapę jak w zad.3 tylko dla wielu plików podawanych jako "wildcard".

getFilesMap(FilenameWildcard) -> Filenames = filelib:wildcard(FilenameWildcard),
                                 WordLists = lists:map(fun(Filename) -> tokenizeFileData(getFileData(Filename)) end, Filenames),
                                 buildTokenMap(#{}, lists:merge(WordLists)).
