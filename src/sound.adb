with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;

package body sound is
    function getSensorValue return Float is 
        Result : Slice_set;
        Value : Float;
        begin
            Result := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
            DELAY 3.0;
            Result:= cmd.execute("cat /dev/ttyACM0");
            Value := string2float(Slice(Result, 2));
            return Value;
        end getSensorValue;

    function getdB (SensorValue : Float) is


        begin
