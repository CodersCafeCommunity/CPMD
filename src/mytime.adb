with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;
with Ada.Text_Io; use Ada.Text_Io;
 
package body SystemTime is

   function getTime return String is
        Now : Time := Clock;
    begin
        return (Image(Date => Now, Time_Zone => -7*60));
    end getTime;

end SystemTime;