-- użycie "wskaźników" do funkcji
--
with Ada.Text_IO;
use  Ada.Text_IO;

procedure procacc is
  
  type vector is array (Integer range <>) of Integer;

  function add2(X: Integer) return Integer is
  begin
    return X+2;
  end;

  function mul2(X: Integer) return Integer is
  begin
    return X*2;
  end;

  type WorkFunction is access function(X: Integer) return Integer; -- deklaracja typu - wskaźnika do funkcji przyjmującej integer i zwracającej integer

  a2: WorkFunction := add2'Access; -- zmienna wskazująca na funkcję
  m2: WorkFunction := mul2'Access;


  procedure worker(X: in out Vector; p: WorkFunction) is -- funkcja jako parametr
  begin
    for i in x'range loop
      begin
        X(i):= p(x(i)); -- aplikuje funkcje na każdy element wektora
      end;
    end loop;
  end;

  v: vector (1..100):= (1..100 => 1);
begin
  worker (v, a2);
  worker (v, m2);
  for I in v'Range loop
    Put(Integer'Image(v (I))); Put(' ');
  end loop;

end;

-- Ada ignoruje wielkość liter 
