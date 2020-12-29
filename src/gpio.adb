with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package body gpio is
    procedure pinMode(Pin: Integer, Mode: String) is
        function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C(Cmd));        
        end System;
        pragma Inline (System);
        gpio_cmd      : String:="gpio -g mode";
        setMode       : Unbounded_String;
        R             : Integer;
    begin
    setMode:= To_Unbounded_String(gpio_cmd) & " " & To_Unbounded_String(Integer.toString(Pin)) & " " & To_Unbounded_String(Mode);
    R := System (To_String(setMode));
    end pinMode;

    procedure write(Pin:Integer, Value:Integer ) is
        function System (Cmd : String) return Integer is
            function C_System (S : Interfaces.C.char_array) return Integer;
        pragma Import (C, C_System, "system");
        begin
            return C_System (Interfaces.C.To_C(Cmd));        
        end System; 
        pragma Inline (System);
        gpio_cmd     : String:="gpio -g write";
        setValue     : Unbounded_String;
        R            : Integer;
    begin
    setValue:= To_Unbounded_String(gpio_cmd) & " " & To_Unbounded_String(Integer.toString(Pin)) & " " & To_Unbounded_String(Integer. toString(Value));
    R := System (To_String(setValue));
    end write;
end gpio;