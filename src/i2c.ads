with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;

package I2C is
	procedure write;
	function read(D: String) return Integer ;
end I2C; 