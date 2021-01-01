with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with cmd; use cmd;

procedure read is 
  Result0, Result1 : Slice_set;
    begin
      Result0 := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
      Result1 := cmd.execute("cat < /dev/ttyACM0");
      Put_Line (Result1(1));
end read;