
package Vector_packages is

type Vector is array (Integer range <>) of Float;

procedure printVector(V : Vector);
procedure fillVectorWithRandomValues(V : in out Vector);
function isSorted(V : Vector) return Boolean;
procedure selectionSort(V : in out Vector);
procedure saveVector(V: Vector; Filename : String);

end Vector_packages;