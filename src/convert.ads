with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

package convert is
    function hex2int(hex : String) return Integer;
    function string2int(string : String) return Integer;
    function int2string(int : Integer) return String;
    function string2float(string : String) return Float;
end convert;