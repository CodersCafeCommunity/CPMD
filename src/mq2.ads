with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;

package body mq2 is
    function getSensorVolt(SensorValue : Float) return Float;
    function getRs_air(SensorVolt : Float) return Float;
    function getR0(Rs_air : Float) return Float;
