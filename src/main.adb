with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with mq2; use mq2;

procedure read is
  Result: Slice_set;
  R0_air, SensorValue, PPM_AL : Float;
    begin
    R0_air := 1.22436;
    Put_Line("R0_air : " & Float'Image(R0_air));
    SensorValue := getSensorValue;
    Put_Line("SensorValue : " & Float'Image(SensorValue));
    PPM_AL := getPPM_AL(SensorValue, R0_air);
    Put_Line("PPM_AL : " & Float'Image(PPM_AL)); 
end read;