// test of I2C service
// using a DS1307 Real Time clock
// registers 8 - 255 are actually battery backed RAM
// that can be written and read back
// making the device ideal for testing

import ..src.api show *

address := 104 // 16r68

main:

  ds1307 := i2cDevice address
  
 
  print (ds1307.read_reg  8 1)
  ds1307.write  #[8, 10]
  print (ds1307.read_reg  8 1)
  ds1307.disconnect 
  ds1307.close

