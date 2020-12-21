with Interfaces.C;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

package I2C is
	procedure write(Chip_Address:String; Register_Address: String; Data:String);
	function  read (Chip_Address:String; Register_Address: String) return String ;
end I2C; 