with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

package  body convert is
    function hex2int(input : String) return Integer is
        begin
            return(Integer'Value(Replace_Slice (input, 1,2 ,"16#") & "#"));
        end hex2int;

    function string2int(input : String) return Integer is
        begin
            return((Integer'Value(input)));
        end string2int;

    function int2string(input : Integer) return String is
        begin
            return((Integer'Image(input)));
        end int2string;
    
    function string2float(input : String) return Float is
        F : Float;
        begin
            F := Float'Value(input);
            return F;
        end string2float;
end convert;