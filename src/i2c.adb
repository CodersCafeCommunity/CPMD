with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with GNAT.Expect;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;

package body i2c is
    Result: Unbounded_String;
    R : Integer;
    procedure write(Chip_Address:String; Register_Address: String; Data:String ) is
        function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
        W0: String:="i2cset -y -a 1 ";
        W : Unbounded_String;
    begin
    W := To_Unbounded_String(W0) & " " & To_Unbounded_String(Chip_Address) & " " & To_Unbounded_String(Register_Address) & " " & To_Unbounded_String(Data);
    R := System (To_String(W));
    end write;
    
    function read(Chip_Address:String; Register_Address: String)  return Unbounded_String is
          function System (Cmd : String) return String is
            function C_System (S : Interfaces.C.char_array) return String;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C (Cmd));        
        end System;
        pragma Inline (System);
	    R0: String:= "i2cget -y -a 1 ";
        R : Unbounded_String;
        R1: String:=" ";
    begin
    R := To_Unbounded_String(R0) & To_Unbounded_String(" ") & To_Unbounded_String(Chip_Address) & To_Unbounded_String(" ") & To_Unbounded_String(Register_Address) & To_Unbounded_String(" ") & To_Unbounded_String(" b");
    R1:= R1 & To_String(R);
    Result := System(R1);
    Put_Line(Result);
    return Result;
    end read;

end i2c;