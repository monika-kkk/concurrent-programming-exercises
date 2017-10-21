with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Sequential_IO;
with Ada.Direct_IO;
procedure atest is
   type Byte is mod 256;
   for  Byte'size use 8; 
   x,y: Integer := -4;
   package  ISIO is new Ada.Sequential_IO (Integer);
   package  BSIO is new Ada.Sequential_IO (Byte);
   package  FSIO is new Ada.Sequential_IO (Float);
   package  BDIO is new Ada.Direct_IO (Byte);
 
   package BTIO is new Ada.Text_IO.Modular_IO (Byte);
   package ITIO is new Ada.Text_IO.Integer_IO (Integer);
   package FTIO is new Ada.Text_IO.Float_IO (Float);
 
   C : character := '5';
   FSLog : FSIO.FILE_TYPE;
   BSLog : BSIO.FILE_TYPE;
   ISLog : ISIO.FILE_TYPE;
   ITLog : FILE_TYPE;
   FTLog : FILE_TYPE;
 
begin
   y:= abs(x);
   Create (ITLog, Out_File, "LOG_text_integer");
   for X in 0 .. 256 loop
      ITIO.Put (ITLog, X);
   end loop;
   Close (ITLog);
 
   Create (FTLog, Out_File, "LOG_text_float");
   for X in 0 .. 255 loop
      FTIO.Put (FTLog, Float (X));
   end loop;
   Close (FTLog);
 
   BSIO.Create (BSLog, BSIO.Out_File, "LOG_seq_byte");
   for X in 0 .. 255 loop
      BSIO.Write (BSLog, Byte (X));
   end loop;
   BSIO.Close (BSLog);
 
   FSIO.Create (FSLog, FSIO.Out_File, "LOG_seq_float");
   for X in 0 .. 255 loop
      FSIO.Write (FSLog, Float (X));
   end loop;
   FSIO.Close (FSLog);
 
   ISIO.Create (ISLog, ISIO.Out_File, "LOG_seq_integer");
   for X in 0 .. 260 loop
      ISIO.Write (ISLog, X);
   end loop;
   ISIO.Close (ISLog);
end atest;