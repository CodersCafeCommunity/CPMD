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

    function buildcURL(Temperature:Integer) return Unbounded_String is
        cURL    : Unbounded_String;
        begin
            cURL:= To_Unbounded_String("curl -X POST https://hooks.zapier.com/hooks/catch/9219341/oc7y2ae -d ") & """first_name"& Integer'Image(Temperature)&"""";
            Put_Line(cURL);
            return cURL;
        end buildcURL;

end googlesheet;
        