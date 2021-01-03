with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;


package body mq2 is
   function getSensorValue return Float is 
        Result : Slice_set;
        Value : Float;
        begin
            Result := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
            DELAY 3.0;
            Result:= cmd.execute("cat /dev/ttyACM0");
            Value := string2float(Slice(Result, 1));
            return Value;
        end getSensorValue;

    function getSensorVolt(SensorValue : Float) return Float is
        SensorVolt  :  Float;
        Vin : Float := 3.0;
        begin
            SensorVolt := (SensorValue*Vin)/Float(1023);
            return SensorVolt;
        end getSensorVolt;
    
    function getRs(SensorVolt : Float) return Float is
        Rs : Float;
        Vin: Float := 3.0;
        begin
            Rs := (Vin-SensorVolt)/SensorVolt;
            return Rs;
        end getRs;

    function getR0(Rs: Float) return Float is
        R0 : Float;
        begin
            R0 := Rs/Float(9.8);
            return R0;
        end getR0;

    function calibrateMQ2 return Float is
        Result: Slice_set;
        Value,Volt, Rs_air, R0_air : Float;
        R : Float := 0.0;
        begin
            Put_Line("Calibrating...");
            for I in 1..20 loop
                Value := getSensorValue;
                R := R + Value;
            end loop;

            Value := R/Float(20);
            Volt  := getSensorVolt(Value);
            Rs_air:= getRs(Volt);
            R0_air:= getR0(Rs_air);
            Put_Line("Calibrated Successfully");
            return R0_air;
        end calibrateMQ2;
    

    function getPPM (R0_air : Float; Rs: Float; b: Float ; m : Float ) return Float is
        PPM : Float;
        Rs_R0: Float;
        begin
            Rs_R0 := Rs/R0_air;
            PPM := Float(Log(Rs_R0,10.0));
            PPM := (PPM-b)/m;
            PPM := 10.0 ** PPM;
            return PPM;
        end getPPM;

    function getPPM_CO(SensorValue : Float; R0_air: Float) return Float is
        SensorVolt, Rs, PPM_CO : Float;
        b : Float := 1.512;
        m : Float := -0.339;
        begin
            SensorVolt := getSensorVolt(SensorValue);
            Rs := getRs(SensorVolt);
            PPM_AL := getPPM(R0_air, Rs, b, m);
            return PPM_CO;
        end getPPM_CO;

    function getPPM_CH4(SensorValue : Float; R0_air: Float) return Float is
        SensorVolt, Rs, PPM_CH4 : Float;
        b : Float := 1.349;
        m : Float := -0.372;
        begin
            SensorVolt := getSensorVolt(SensorValue);
            Rs := getRs(SensorVolt);
            PPM_AL := getPPM(R0_air, Rs, b, m);
            return PPM_CH4;
        end getPPM_CH4;

    function getPPM_SMOKE(SensorValue : Float; R0_air: Float) return Float is
        SensorVolt, Rs, PPM_SMOKE : Float;
        b : Float := 1.617;
        m : Float := -0.443;
        begin
            SensorVolt := getSensorVolt(SensorValue);
            Rs := getRs(SensorVolt);
            PPM_AL := getPPM(R0_air, Rs, b, m);
            return PPM_SMOKE;
        end getPPM_SMOKE;       
end mq2;


    