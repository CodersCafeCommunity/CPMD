with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with gpio;

procedure Read is 
begin
  gpio.pinMode(23,"Output");
  gpio.write(23,1);
end Read;