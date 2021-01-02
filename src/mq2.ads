with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;

package mq2 is
    function getSensorValue return Float;
    function getSensorVolt(SensorValue : Float) return Float;
    function getRs_air(SensorVolt : Float) return Float;
    function getR0(Rs_air : Float) return Float;
    function calibrateMQ2(SensorValue : Float) return Float;
    function getPPM (R0 : Float; Rs: Float; b: Float; m : Float) return Float;
    function getPPM_AL(SensorValue : Float, R0_air: Float) return Float;
end mq2;
