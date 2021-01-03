with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with mq2;
with sound;

procedure read is
  Result: Slice_set;
  R0_air, SensorValue, dB: Float;
  PPM_CO, PPM_CH4, PPM_SMOKE :Integer;
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
    dB := sound.getdB(SensorValue);
    Put_Line("Intensity in dB :" & Float'Image(dB));
end read;