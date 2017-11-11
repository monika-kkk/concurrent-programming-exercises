with System;
use  System;

package Zadania is
--*********************************************--
task type S1 is
      entry E1;
      entry E2;
      entry E3;
      entry Y1;
end S1;
type S1_access is access all S1;
--*********************************************--
task type C1(Server: S1_access) is
end C1;
type C1_access is access all C1;
--*********************************************--

end Zadania;
