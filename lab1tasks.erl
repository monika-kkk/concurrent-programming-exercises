-module(lab1tasks).

-compile([export_all]).

%%-export([pole/1]).

pole({kwadrat, X, Y}) -> X * Y;
pole({kolo, X}) -> 3.14 * X * X;

%Dodaj do poniższego modułu:
%obsługę trójkątów i trapezów (obliczanie pola)

pole({trojkat, A, H}) -> A * H / 2;
pole({trapez, A, B, H}) -> (A + B) * H / 2.


%%Długość listy
%%Napisz program liczący długość listy (len/1).

len([]) -> 0;
len([_ | T]) -> 1 + len(T).

%%Min max
%%Napisz program podający najmniejszy element listy (amin/1).

amin([]) -> io:format("List cannot be empty~n");
amin([H | T]) -> amin(T, H).

amin([], MIN) -> MIN;
amin([H | T], MIN) ->
  case H < MIN of
    true -> amin(T, H);
    false -> amin(T, MIN)
  end.


%%Napisz program podający największy element listy (amax/1).


amax([]) -> io:format("List cannot be empty");
amax([H | T]) -> amax(T, H).

amax([], MAX) -> MAX;
amax([H | T], MAX) ->
  case H > MAX of
    true -> amax(T, H);
    false -> amax(T, MAX)
  end.

%%Napisz program zwracający krotkę 2-elementową z najmniejszym i największym elementem listy (tmin_max/1).

tmin_max([]) -> io:format("List cannot be empty");
tmin_max([H | T]) -> tmin_max(T, H, H).

tmin_max([], MIN, MAX) -> {MIN, MAX};
tmin_max([H | T], MIN, MAX) ->
  if H < MIN -> tmin_max(T, H, MAX);
    H > MAX -> tmin_max(T, MIN, H);
    true -> tmin_max(T, MIN, MAX)
  end.

lmin_max([]) -> io:format("List cannot be empty");
lmin_max([H | T]) -> tmin_max(T, H, H).


%%Pola z listy elementów
%%Napisz program wyliczający pola figur/brył podanych jako lista krotek. Zwracana ma być lista pól.

pole_list([]) -> [];
pole_list([H | T]) -> [pole(H) | pole_list(T)].

%%Lista malejąca
%%Napisz program, który dla danego N zwróci listę formatu [N,N-1,…,2,1]

dec_list(0) -> [];
dec_list(N) -> [N | dec_list(N-1)].

%TODO
%%Konwerter temperatur
%%Napisz konwerter temperatury pomiędzy różnymi skalami (minimum 4).
%% Temperatura podawana jest jako krotka {typ, wartość} np. {c, 22.4}, {f,0.0}.
%% Funkcja konwertująca ma przyjmować 2 parametry: krotkę reprezentującą temperaturę oraz skalę docelową np. temp_conv({c,22.4},k).
%% Wartością zwracaną ma być odpowiednia krotka np. {k,233.47}.


%%Generator listy o zadanej długości
%%Napisz program generujący listę jedynek o zadanej długości.
%% Napisz program generujący listę o podanej długości składającą się z podanego elementu.

%%Napisz program zwracający listę 2-elementową z najmniejszym i największym elementem listy (lmin_max/1).

