with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with GNAT.String_Split;use GNAT.String_Split;
with cmd; use cmd;
with convert; use convert;

--curl -d "first_name=c&last_name=2&age=30" -X POST https://hooks.zapier.com/hooks/catch/9219341/oc7y2ae

package body googlesheet is

    function log (cURL : Unbounded_String) return Slice_Set is
        Status : Slice_Set;
        begin
            Status := cmd.execute(To_String(cURL));
            return Status;
        end log;

    function buildcURL(Time:String;Temperature:Integer; Sound:Integer; PPM_CO:Integer; PPM_CH4:Integer; PPM_SMOKE:Integer ) return Unbounded_String is
        cURL    : Unbounded_String;
        begin
            cURL:= To_Unbounded_String("curl -X POST https://hooks.zapier.com/hooks/catch/9219341/oc7y2ae -d ") & """Temperature="&Integer'Image(Temperature)&"""&Sound="&Integer'Image(Sound)&"""&PPM_CO="&Integer'Image(PPM_CO)&"""&PPM_CH4="&Integer'Image(PPM_CH4)&"""&PPM_SMOKE="&Integer'Image(PPM_SMOKE)&"""";
            Put_Line(To_String(cURL));
            return cURL;
        end buildcURL;

end googlesheet;
        