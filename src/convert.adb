with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

package  body convert is
    function hex2int(input : String) return Integer is
        begin
            return(Integer'Value(Replace_Slice (hex, 1,2 ,"16#") & "#"));
        end hex2int;

    function string2int(input : String) return Integer is
        begin
            return((Integer'Value(input)));
        end string2int;

    function int2string(input : Integer) return String is
        begin
            return((Integer'Image(int)));
        end int2string;
    
    function string2float(input : String) return Float is
        --I : Integer;
        F : Float;
        begin
            --I := Integer'Value(input);
            F := Float'Value(I);
            return F;
        end string2float;
end convert;