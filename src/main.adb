with Text_IO; use Text_IO;
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Integer_Text_IO;use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with GNAT.String_Split;      use GNAT.String_Split;

with mq2;
with sound;
with lm35;
with googlesheet;
with mytime;

procedure main is 

    type PPM_Array is array(Integer) of Integer;
    PPM_Avg_CO_Array    : PPM_Array ;
    PPM_Avg_CH4_Array   : PPM_Array ;
    PPM_Avg_SMOKE_Array : PPM_Array ;
    PPM_Mean_CO_Array   : PPM_Array ;

    Res : Slice_set;
    R0_air, SensorValue, dB, dC: Float;
    PPM_CO, PPM_CH4, PPM_SMOKE :Integer;
    PPM_Sum_CO,PPM_Sum_CH4,PPM_Sum_SMOKE :Integer:= 0;
    PPM_Avg_CO,PPM_Avg_CH4,PPM_Avg_SMOKE :Integer:= 0;
    PPM_Tot : Integer;
    i,I,J : Integer;
    Count_Time :Integer :=0;
    cURL,Time: Unbounded_String;
 
    begin
    -- loop forever
    loop 
        ----- Gas Sensor ------
        R0_air := 1.22436;
        SensorValue := mq2.getSensorValue;
        PPM_CO   := Integer(mq2.getPPM_CO(SensorValue, R0_air));
        Put_Line("PPM_CO : " & Integer'Image(PPM_CO)); 
        PPM_CH4  := Integer(mq2.getPPM_CH4(SensorValue, R0_air));
        Put_Line("PPM_CH4 : " & Integer'Image(PPM_CH4));
        PPM_SMOKE:= Integer(mq2.getPPM_SMOKE(SensorValue, R0_air));
        Put_Line("PPM_SMOKE : " & Integer'Image(PPM_SMOKE));

        PPM_Sum_CO := PPM_Sum_CO + PPM_CO;
        PPM_Sum_CH4 := PPM_Sum_CH4 + PPM_CH4;
        PPM_Sum_SMOKE := PPM_Sum_SMOKE + PPM_SMOKE;
        
        ----- Sound Sensor -----
        SensorValue := sound.getSensorValue;
        dB := sound.getdB(SensorValue);
        Put_Line("Intensity in dB :" & Float'Image(dB));

        ----- Temperature Sensor -----
        SensorValue := lm35.getSensorValue;
        dC := lm35.getdC(SensorValue);
        Put_Line("Temp in *C :" & Float'Image(dC));

        ------ Time ------
        Time := To_Unbounded_String(mytime.getTime);

        ----- cURL-------
        cURL := googlesheet.buildcURL(To_String(Time),Integer(dC),Integer(dB),PPM_CO,PPM_CH4,PPM_SMOKE);
        Res  := googlesheet.log(cURL);
        
        
        
        Delay 1.0;
        Count_Time:= Count_Time + 1;
    
        if Count_Time = 60 then
            PPM_Avg_CO := PPM_Sum_CO / 60;
            PPM_Avg_CO_Array(i) := PPM_Avg_CO;
        
            -- PPM_Avg_CH4 := PPM_Sum_CH4 /3600;
            -- PPM_Avg_CH4_Array(i) := PPM_Avg_CH4;

            --PPM_Avg_SMOKE := PPM_Avg_SMOKE / 3600;
            --PPM_Avg_SMOKE_Array(i) := PPM_Avg_SMOKE;
            i := i + 1;
            if i = 24 then
                for I in 1..17 loop 
                    for J in I..I+7 loop 
                        PPM_Mean_CO_Array(I):= PPM_Mean_CO_Array(I) + PPM_Avg_CO_Array(J);
                    end loop;
                end loop;
            Count_Time:= 0;
            end if;
        end if;
    end loop;
end main;