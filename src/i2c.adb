with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with GNAT.Expect;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package body i2c is
    R1,V1: Integer;
    R3: Unbounded_String;
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
    end write;
    
    function read(D: String)  return Integer is
          function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
	R2: String:= "i2cget -y -a 1 0x77 ";
    begin
    R3 := To_Unbounded_String(R2) & To_Unbounded_String(D) & To_Unbounded_String(" b");
    V1 := System (To_String(R3));
    return V1;
    end read;

end i2c;