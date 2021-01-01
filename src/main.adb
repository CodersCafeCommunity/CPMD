with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;
with cmd; use cmd;

procedure read is 
  Result0: Slice_set;
  Result: Slice_set;
    begin
      Result0 := cmd.execute("stty -F /dev/ttyACM0 115200 -xcase -icanon min 0 time 3");
      DELAY 0.5;
      Result := cmd.execute("cat /dev/ttyACM0");
      for I in 1 .. Slice_Count(Result) loop
      Put_Line (Slice(Result, I));
      end loop;
end read;