// test of I2C service
// using a DS1307 Real Time clock
// registers 8 - 255 are actually battery backed RAM
// that can be written and read back
// making the device ideal for testing

import ..src.api show *

address := 104 // 16r68

main:

  ds1307 := i2cDevice address
  
 
  print (ds1307.read_reg  9 1)
  ds1307.write  #[9, 10]
  print (ds1307.read_reg  9 1)
  print "disconnecting"
  ds1307.disconnect 
  print "closing"
  ds1307.close

