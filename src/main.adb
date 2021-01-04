with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with mq2;
with sound;
with lm35;
with googlesheet; use googlesheet;
with SystemTime; use SystemTime;

procedure read is
  Result: Slice_set;
  R0_air, SensorValue, dB, dC: Float;
  PPM_CO, PPM_CH4, PPM_SMOKE :Integer;
  cURL, Time : Unbounded_String;
    begin
    ----- Gas Sensor ------
    R0_air := 1.22436;
    Put_Line("R0_air : " & Float'Image(R0_air));
    SensorValue := mq2.getSensorValue;
    Put_Line("SensorValue : " & Float'Image(SensorValue));
    PPM_CO := Integer(mq2.getPPM_CO(SensorValue, R0_air));
    Put_Line("PPM_CO : " & Integer'Image(PPM_CO)); 
    PPM_CH4 := Integer(mq2.getPPM_CH4(SensorValue, R0_air));
    Put_Line("PPM_CH4 : " & Integer'Image(PPM_CH4));
    PPM_SMOKE := Integer(mq2.getPPM_SMOKE(SensorValue, R0_air));
    Put_Line("PPM_SMOKE : " & Integer'Image(PPM_SMOKE));

    ----- Sound Sensor -----
    SensorValue := sound.getSensorValue;
    Put_Line("SensorValue : " & Float'Image(SensorValue));
    dB := sound.getdB(SensorValue);
    Put_Line("Intensity in dB :" & Float'Image(dB));

    ----- Temperature Sensor -----
    SensorValue := lm35.getSensorValue;
    Put_Line("SensorValue : " & Float'Image(SensorValue));
    dC := lm35.getdC(SensorValue);
    Put_Line("Temp in *C :" & Float'Image(dC));

    ------ Time ------
    Time := To_Unbounded_String(getTime);
    ----- cURL-------
    cURL := buildcURL(To_String(Time),Integer(dC),Integer(dB),PPM_CO,PPM_CH4,PPM_SMOKE);
    Result:= log(cURL);
end read;