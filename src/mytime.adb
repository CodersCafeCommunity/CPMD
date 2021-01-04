with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;
with Ada.Text_Io; use Ada.Text_Io;
 
package body mytime is

   function getTime return Time is
        Now : Time := Clock;
    begin
        return (Date => Now, Time_Zone => -7*60);
    end getTime;

end mytime;