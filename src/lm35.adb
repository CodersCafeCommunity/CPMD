with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;

package body lm35 is
    function getSensorValue return Float is 
        Result : Slice_set;
        Value : Float;
        begin
            Result := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
            DELAY 3.0;
            Result:= cmd.execute("cat /dev/ttyACM0");
            Value := string2float(Slice(Result, 3));
            return Value;
        end getSensorValue;
        
    function getSensorVolt(SensorValue : Float) return Float is
        SensorVolt  :  Float;
        Vin : Float := 3000.0;
        begin
            SensorVolt := (SensorValue*Vin)/Float(1023);
            return SensorVolt;
        end getSensorVolt;

    function getdC (SensorValue : Float) return Float is
        dC, SensorValue  : Float;
        begin
            SensorVolt := getSensorVolt(SensorValue);
            dC := SensorVolt/10.0;
            return dC;
        end getdC;

end lm35;

