-- lab1.adb
-- komentarz do końca linii

-- wykorzystany pakiet
with Ada.Text_IO;
use Ada.Text_IO;

-- procedura główna - dowolna nazwa
-- nazwa zgodna z nazwą pliku czyli lab1.adb
procedure Lab1 is

-- część deklaracyjna procedury

  -- funkcja - forma pełna
  function Max2(A1, A2 : in Float ) return Float is
  begin
    if A1 > A2 then return A1;
    else return A2;
    end if;
  end Max2;

  -- funkcja "wyrażeniowa"
  -- forma uproszczona funkcji
  -- jej treścią jest tylko wyrażenie w nawiasie

  function Add(A1, A2 : Float) return Float is
    (A1 + A2);

  function Max(A1, A2 : in Float ) return Float is
    (if A1 > A2 then A1 else A2);

  -- Fibonacci
  function Fibo(N : Natural) return Natural is
    (if N = 0 then 1 elsif N in 1|2 then  1 else Fibo(N-1) + Fibo(N-2) );

  -- procedura
  -- zparametryzowany ciąg instrukcji
  procedure Print_Fibo(N: Integer) is
  begin
    if N <1 or N>46 then raise Constraint_Error;
    end if;
    Put_Line("Ciąg Fibonacciego dla N= " & N'Img);
    for I in 1..N loop
      Put( Fibo(I)'Img & " " );
    end loop;
    New_Line;
  end Print_Fibo;

  -- Zadania
  -- dodaj funkcję liczącą średnią dwóch liczb i wypisz wynik
  procedure Print_Av(A1, A2 : in Float) is
  AV : Float;
  begin
    AV := (A1+A2)/2.0;
    Put_Line("Srednia wynosi" & AV'Img);
  end;

-- dodaj funkcję liczącą silnię i wypisz wynik.
 function Factorial(N : Natural) return Natural is
    (if N in 0|1 then 1 else Factorial(N-1)*N);


-- poniżej treść procedury głównej
begin
  Put_Line("Suma = " & Add(3.0, 4.0)'Img );
  Put_Line( "Max =" & Max(6.7, 8.9)'Img);
  Put_Line( "Max2 =" & Max2(6.7, 8.9)'Img);
  Print_Fibo(12);
  Print_Av(12.0,7.0);
  Put_Line("Silnia =" & Factorial(5)'Img);
end Lab1;



