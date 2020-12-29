with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with GNAT.Expect;            use GNAT.Expect;
with GNAT.OS_Lib;            use GNAT.OS_Lib;
with GNAT.String_Split;      use GNAT.String_Split;
 
procedure System_Command is
   Command    : String          := "gpio -g read 23";
   Args       : Argument_List_Access;
   Status     : aliased Integer;
   Separators : constant String := LF & CR;
   Reply_List : Slice_Set;
   A : Integer;

 
begin
   Args := Argument_String_To_List (Command);
   
   -- execute the system command and get the output in a single string
   declare
      Response : String :=
        Get_Command_Output
          (Command   => Args (Args'First).all,
           Arguments => Args (Args'First + 1 .. Args'Last),
           Input     => "",
           Status    => Status'Access);
    
   begin
      Free (Args);
      A := Integer'Value(Response)+1;
      Put_Line(Integer'Image(A));
   end;
 
end System_Command;