with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;use GNAT.String_Split;

with mq2;
with sound;
with tmp36;
with googlesheet;
with mytime;
with cmd;

procedure main is 

    type PPM_Array is array(1..24) of Float;
    PPM_Avg_CO_Array    : PPM_Array := (1..24 => 0.0);
    PPM_Avg_CH4_Array   : PPM_Array := (1..24 => 0.0);
    PPM_Avg_SMOKE_Array : PPM_Array := (1..24 => 0.0);
    PPM_Mean_CO_Array   : PPM_Array := (1..24 => 0.0);
    PPM_Mean_CH4_Array  : PPM_Array := (1..24 => 0.0);
    PPM_Mean_SMOKE_Array  : PPM_Array := (1..24 => 0.0);

    Res : Slice_set;
    R0_air, SensorValue, dB, dC: Float;
    PPM_CO, PPM_CH4, PPM_SMOKE :Integer;
    PPM_Sum_CO,PPM_Sum_CH4,PPM_Sum_SMOKE :Float:= 0.0;
    PPM_Avg_CO,PPM_Avg_CH4,PPM_Avg_SMOKE :Float:= 0.0;
    PPM_CH4_Final,PPM_SMOKE_Final,PPM_CO_Final,PPM_Final : Float;
    Count_Time,i :Integer := 0;
    cURL,Time: Unbounded_String;
 
    begin
    Res := cmd.execute("gpio -g mode 14 out");-- Green
    Res := cmd.execute("gpio -g mode 15 out");--Blue
    Res := cmd.execute("gpio -g mode 2 out");--Red
    Res := cmd.execute("gpio -g mode 23 out");--Buzzer

    -- loop forever
    loop 
        ----- Gas Sensor ------
        R0_air := 1.22436; -- Or use mq2.calibrateMQ2 function to get the value of R0_air
        SensorValue := mq2.getSensorValue;
        PPM_CO   := Integer(mq2.getPPM_CO(SensorValue, R0_air));
        Put_Line("PPM_CO : " & Integer'Image(PPM_CO)); 
        PPM_CH4  := Integer(mq2.getPPM_CH4(SensorValue, R0_air));
        Put_Line("PPM_CH4 : " & Integer'Image(PPM_CH4));
        PPM_SMOKE:= Integer(mq2.getPPM_SMOKE(SensorValue, R0_air));
        Put_Line("PPM_SMOKE : " & Integer'Image(PPM_SMOKE));

        PPM_Sum_CO := PPM_Sum_CO + Float(PPM_CO);
        Put_Line(Float'Image(PPM_Sum_CO));
        PPM_Sum_CH4 := PPM_Sum_CH4 + FLoat(PPM_CH4);
        PPM_Sum_SMOKE := PPM_Sum_SMOKE + Float(PPM_SMOKE);
        
        ----- Sound Sensor -----
        SensorValue := sound.getSensorValue;
        dB := sound.getdB(SensorValue);
       -- Put_Line("Intensity in dB :" & Float'Image(dB));

        ----- Temperature Sensor -----
        SensorValue := tmp36.getSensorValue;
        dC := tmp36.getdC(SensorValue);
        --Put_Line("Temp in *C :" & Float'Image(dC));

        ------ Time ------
        Time := To_Unbounded_String(mytime.getTime);

        ----- cURL-------
        cURL := googlesheet.buildcURL(To_String(Time),Integer(dC),Integer(dB),PPM_CO,PPM_CH4,PPM_SMOKE);
        Res  := googlesheet.log(cURL);
        
        Count_Time := Count_Time + 1;
    
        if Count_Time = 180 then
            i := i + 1;
            PPM_Avg_CO := PPM_Sum_CO/180.0;
            PPM_Avg_CO_Array(i) := PPM_Avg_CO;
            PPM_Sum_CO := 0.0;
   
            PPM_Avg_CH4 := PPM_Sum_CH4 /180.0;
            PPM_Avg_CH4_Array(i) := PPM_Avg_CH4;
            PPM_Sum_CH4  := 0.0;

            PPM_Avg_SMOKE := PPM_Sum_SMOKE /180.0;
            PPM_Avg_SMOKE_Array(i) := PPM_Avg_SMOKE;
            PPM_Sum_SMOKE := 0.0;

            if i = 24 then
                -- Carbon Monoxide
                for I in 1..17 loop 
                    for J in I..I+7 loop 
                        PPM_Mean_CO_Array(I):= PPM_Mean_CO_Array(I) + PPM_Avg_CO_Array(J);
                        
                    end loop;
                end loop;
                for I in 1..17 loop
	                    if PPM_Mean_CO_Array(1) < PPM_Mean_CO_Array(I+1) then
                         PPM_Mean_CO_Array(1) := PPM_Mean_CO_Array(I+1);
                         end if;
                    PPM_CO_Final := PPM_Mean_CO_Array(1);
                    Put_Line("Max CO Value :" & Float'Image(PPM_CO_Final));
                end loop;
                for I in 1..17 loop
	                PPM_Mean_CO_Array(I):= 0.0;
                end loop;
                
                -- Methane
                for I in 1..17 loop 
                    for J in I..I+7 loop 
                        PPM_Mean_CH4_Array(I):= PPM_Mean_CH4_Array(I) + PPM_Avg_CH4_Array(J);
                    end loop;
                end loop;
                for I in 1..17 loop
	                  if PPM_Mean_CH4_Array(1) < PPM_Mean_CH4_Array(I+1) then
                       PPM_Mean_CH4_Array(1) := PPM_Mean_CH4_Array(I+1);
                    end if;
                    PPM_CH4_Final := PPM_Mean_CH4_Array(1);
                    Put_Line("Max CH4 Value :" & Float'Image(PPM_CH4_Final));
                end loop;
                for I in 1..17 loop
	                PPM_Mean_CH4_Array(I):= 0.0;
                end loop;
                
                -- Smoke
                for I in 1..17 loop 
                    for J in I..I+7 loop 
                        PPM_Mean_SMOKE_Array(I):= PPM_Mean_SMOKE_Array(I) + PPM_Avg_SMOKE_Array(J);
                    end loop;
                end loop;
                for I in 1..17 loop
	                  if PPM_Mean_SMOKE_Array(1) < PPM_Mean_SMOKE_Array(I+1) then
                       PPM_Mean_SMOKE_Array(1) := PPM_Mean_SMOKE_Array(I+1);
                    end if;
                    PPM_SMOKE_Final := PPM_Mean_SMOKE_Array(1);
                    Put_Line("Max SMOKE Value :" & Float'Image(PPM_SMOKE_Final));
                end loop;
                for I in 1..17 loop
	                PPM_Mean_SMOKE_Array(I):= 0.0;
                end loop;
                PPM_Final := (PPM_CH4_Final + PPM_SMOKE_Final + PPM_CO_Final)/3.0;

                case Integer(PPM_Final) is
                  when 0 .. 200 =>
                    Put_Line ("Excellent Air quality");
                    Res := cmd.execute("gpio -g write 15 0");
                    Res := cmd.execute("gpio -g write 2 0");
                    Res := cmd.execute("gpio -g write 14 1");
                    
                  when 201 .. 800 =>
                    Put_Line ("Moderate Air quality"); 
                    Res := cmd.execute("gpio -g write 14 0");
                    Res := cmd.execute("gpio -g write 2 0"); 
                    Res := cmd.execute("gpio -g write 15 1");
                    
                  when others =>
                    Put_Line ("Severe Air quality");
                    Res := cmd.execute("gpio -g write 14 0");
                    Res := cmd.execute("gpio -g write 15 0");
                    Res := cmd.execute("gpio -g write 2 1"); 
                    
                    for I in 1..5 loop
                        Res := cmd.execute("gpio -g write 23 1"); 
                        Delay 1.0;
                        Res := cmd.execute("gpio -g write 23 0");
                        Delay 1.0;
                    end loop;
                PPM_CH4_Final := 0.0;
                Put_Line (Float'Image(PPM_CH4_Final));
                PPM_SMOKE_Final := 0.0;
                Put_Line (Float'Image(PPM_SMOKE_Final));
                PPM_CO_Final := 0.0;
                Put_Line (Float'Image(PPM_CO_Final));
                PPM_Final := 0.0;
                Put_Line (Float'Image(PPM_Final));
                end case;
                i := 0;
            end if;
            Count_Time:= 0;
        end if;
        Delay 8.0;
    end loop;
end main;
