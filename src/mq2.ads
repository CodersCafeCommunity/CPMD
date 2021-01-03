with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;


package mq2 is
    function getSensorValue return Float;
    function getSensorVolt(SensorValue : Float) return Float;
    function getRs(SensorVolt : Float) return Float;
    function getR0(Rs : Float) return Float;
    function calibrateMQ2 return Float;
    function getPPM (R0_air : Float; Rs: Float; b: Float; m : Float) return Float;
    function getPPM_CO(SensorValue : Float; R0_air: Float) return Float;
    function getPPM_CH4(SensorValue : Float; R0_air: Float) return Float;
    function getPPM_SMOKE(SensorValue : Float; R0_air: Float) return Float;
end mq2;
