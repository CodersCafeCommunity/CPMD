with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package GPIO is
	procedure pinMode(Pin: Integer; Mode: String);
	procedure write  (Pin: Integer; Value: Integer);
    function read(Pin:Integer) return Integer;
end GPIO; 