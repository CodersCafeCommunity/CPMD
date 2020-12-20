with Text_IO;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with i2c;

procedure Read is 
begin
  i2c.write;
  Result := i2c.read("0xF6");
  Put (Result);
end Read;