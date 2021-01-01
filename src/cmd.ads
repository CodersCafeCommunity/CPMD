with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with GNAT.Expect;            use GNAT.Expect;
with GNAT.OS_Lib;            use GNAT.OS_Lib;
with GNAT.String_Split;      use GNAT.String_Split;

package cmd is
    function execute (CMD : String) return Slice_Set;
end cmd;