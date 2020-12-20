with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with GNAT.Expect;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package body i2c is
    R1,R2,V1: Integer;
    R3: String :="sudo";
    W1: String:="i2cset -y -a 1 0x77 0xF4 0x2E";

   
    procedure write is
        function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
    begin
    R1 := System (W1);
    --DELAY 0.5;
    --R := System (W2);
    --R := System (W3);
    end write;
    
    function read(D: String)  return Integer is
          function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
	R2: String:="i2cget -y -a 1 0x77";
    begin
    R3 := R2 & D & "b";
    V1 := System (R3);
    return V1;
    end read;

end i2c;