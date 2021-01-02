with cmd; use cmd;
with convert; use convert;

package mq2 is
    function getSensorValue return Float;
    function getSensorVolt(SensorValue : Float) return Float;
    function getRs_air(SensorVolt : Float) return Float;
    function getR0(Rs_air : Float) return Float;
    function calibrateMQ2 return Float;
    function getPPM (R0 : Float; Rs: Float; b: Float; m : Float) return Float;
    function getPPM_AL(SensorValue : Float; R0_air: Float) return Float;
end mq2;
