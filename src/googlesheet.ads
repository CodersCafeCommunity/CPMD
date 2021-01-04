with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;

package googlesheet is

    function log (cURL: Unbounded_String) return Slice_Set;
    function buildcURL(Time:Sting;Temperature:Integer; Sound:Integer; PPM_CO:Integer; PPM_CH4:Integer; PPM_SMOKE:Integer ) return Unbounded_String;

end googlesheet;