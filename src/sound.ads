with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;

package sound is
    function getSensorValue return Float;
    --function getSensorVolt(SensorValue : Float) return Float;
    function getdB (SensorValue : Float) return Float;
end sound;