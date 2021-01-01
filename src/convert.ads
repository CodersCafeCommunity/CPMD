with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

package convert is
    function hex2int(input : String) return Integer;
    function string2int(input : String) return Integer;
    function int2string(input : Integer) return String;
    function string2float(input : String) return Float;
end convert;