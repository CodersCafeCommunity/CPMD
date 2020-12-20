# BMP085 default address
BMP085_I2CADDR        : String := "0x77";

# Operating Modes
BMP085_ULTRALOWPOWER  : String := "0";
BMP085_STANDARD       : String := "1";
BMP085_HIGHRES        : String := "2";
BMP085_ULTRAHIGHRES   : String := "3";

# BMP085 Registers
BMP085_CAL_AC1        : String := "0xAA";  # R   Calibration data (16 bits)
BMP085_CAL_AC2        : String := "0xAC";  # R   Calibration data (16 bits)
BMP085_CAL_AC3        : String := "0xAE";  # R   Calibration data (16 bits)
BMP085_CAL_AC4        : String := "0xB0";  # R   Calibration data (16 bits)
BMP085_CAL_AC5        : String := "0xB2";  # R   Calibration data (16 bits)
BMP085_CAL_AC6        : String := "0xB4";  # R   Calibration data (16 bits)
BMP085_CAL_B1         : String := "0xB6";  # R   Calibration data (16 bits)
BMP085_CAL_B2         : String := "0xB8";  # R   Calibration data (16 bits)
BMP085_CAL_MB         : String := "0xBA";  # R   Calibration data (16 bits)
BMP085_CAL_MC         : String := "0xBC";  # R   Calibration data (16 bits)
BMP085_CAL_MD         : String := "0xBE";  # R   Calibration data (16 bits)
BMP085_CONTROL        : String := "0xF4";
BMP085_TEMPDATA       : String := "0xF6";
BMP085_PRESSUREDATA   : String := "0xF6";

# Commands
BMP085_READTEMPCMD    : String := "0x2E";
BMP085_READPRESSURECMD: String := "0x34";

function read_raw_temp() return Integer is
    begin
        """Reads the raw (uncompensated) temperature from the sensor."""
        i2c.write(BMP085_I2CADDR,BMP085_CONTROL, BMP085_READTEMPCMD);
        DELAY(0.005);  # Wait 5ms
        raw = i2c.read(BMP085_I2CADDR,BMP085_TEMPDATA);
        Put_Line(Integer'Image(raw));
        return raw;
    end read_raw_temp;

function read_raw_pressure() return Integer is
        """Reads the raw (uncompensated) pressure level from the sensor."""
    begin
        i2c.write(BMP085_I2CADDR,BMP085_CONTROL, BMP085_READPRESSURECMD + (self._mode << 6));
        if mode = BMP085_ULTRALOWPOWER then
            DELAY(0.005);
        elsif mode = BMP085_HIGHRES then
            DELAY(0.014);
        elsif mode = BMP085_ULTRAHIGHRES then
            DELAY(0.026);
        else:
            DELAY(0.008);
        end if;

        msb  = i2c.read(BMP085_I2CADDR,BMP085_PRESSUREDATA);
        lsb  = i2c.read(BMP085_I2CADDR,BMP085_PRESSUREDATA+1);
        xlsb = i2c.read(BMP085_I2CADDRBMP085_PRESSUREDATA+2);
        raw  = ((msb << 16) + (lsb << 8) + xlsb) >> (8 - mode);
        Put_Line(Integer'Image(raw));
        return raw
    end read_raw_pressure;

def read_temperature(self):
        """Gets the compensated temperature in degrees celsius."""
        UT = self.read_raw_temp()
        # Datasheet value for debugging:
        #UT = 27898
        # Calculations below are taken straight from section 3.5 of the datasheet.
        X1 = ((UT - self.cal_AC6) * self.cal_AC5) >> 15
        X2 = (self.cal_MC << 11) // (X1 + self.cal_MD)
        B5 = X1 + X2
        temp = ((B5 + 8) >> 4) / 10.0
        self._logger.debug('Calibrated temperature {0} C'.format(temp))
        return temp

    
