with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;

package body mq2 is
    function getSensorVolt(SensorValue : Float) return Float is
        SensorVolt  :  Float;
        Vin : Float := 3.0;
        begin
            SensorVolt := (SensorValue*Vin)/Float(1023);
            return SensorVolt;
        end getSensorVolt;
    
    function getRs_air(SensorVolt : Float) return Float is
        Rs_air : Float;
        Vin    : Float := 3.0;
        begin
            Rs_air := (Vin-SensorVolt)/SensorVolt;
            return Rs_air;
        end getRs_air;

    function getR0(Rs_air : Float) return Float is
        R0 : Float;
        begin
            R0 := Rs_air/Float(9.8);
            return R0;
        end getR0;

end mq2;


    