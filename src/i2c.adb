with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with GNAT.Expect;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package body i2c is
    Result: Integer;
    procedure write(Chip_Address:String; Register_Address: String; Data:String ) is
        function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
        W0: String:="i2cset -y -a 1 ";
    begin
    W := To_Unbounded_String(W0) & " " & To_Unbounded_String(Chip_Address) & " " & To_Unbounded_String(Register_Address) & " " & To_Unbounded_String(Data);
    Result := System (To_String(W));
    end write;
    
    function read(Chip_Address:String; Data: String)  return Integer is
          function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
	    R2: String:= "i2cget -y -a 1 ";
    begin
    R3 := To_Unbounded_String(R2) & To_Unbounded_String(D) & To_Unbounded_String(" b");
    V1 := System (To_String(R4));
    return V1;
    end read;

end i2c;