with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;
with mq2; use mq2;

procedure read is
  Result: Slice_set;
  Value,Volt, Rs, R0 : Float;
    begin
      loop
      Result := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
      DELAY 3.0;
      Result:= cmd.execute("cat /dev/ttyACM0");
      Value := string2float(Slice(Result, 1));
      Volt  := getSensorVolt(Value);
      Rs    := getRs_air(Volt);
      R0    := getR0(Rs);
      Put_Line(Float'Image(R0));
      end loop;

end read;