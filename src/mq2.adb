with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions; use Ada.Numerics.Generic_Elementary_Functions;
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
            for I in 1..200 loop
                Value := getSensorValue;
                Put_Line(Integer'Image(I));
                Put_Line(Float'Image(Value));
                Put_Line("----------");
                R := R + Value;
            end loop;

            Value := R/Float(200);
            Volt  := getSensorVolt(Value);
            Put_Line(Float'Image(Volt));
            Rs_air:= getRs(Volt);
            Put_Line(Float'Image(Rs_air));
            R0_air:= getR0(Rs_air);
            Put_Line(Float'Image(R0_air));
            return R0_air;
        end calibrateMQ2;
    

    function getPPM (R0_air : Float; Rs: Float; b: Float ; m : Float ) return Float is
        PPM : Float;
        begin
            PPM := ((Ada.Numerics.log(Rs/R0_air),10.0)-b)/m;
            PPM := 10**PPM;
            return PPM;
        end getPPM;

    function getPPM_AL(SensorValue : Float; R0_air: Float) return Float is
        SensorVolt, Rs, PPM_AL : Float;
        b : Float := 1.310;
        m : Float := -0.373;
        begin
            SensorVolt := getSensorVolt(SensorValue);
            Rs := getRs(SensorVolt);
            PPM_AL := getPPM(R0_air, Rs, b, m);
            return PPM_AL;
        end getPPM_AL;       
end mq2;


    