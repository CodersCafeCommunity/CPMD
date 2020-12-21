with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with i2c;

procedure Read is 
Result: Integer;
begin
  i2c.write("0x77","0xF4","0x2E");
  Result := i2c.read("0x77","0xF6");
  Put(Result, Base => 10);
end Read;