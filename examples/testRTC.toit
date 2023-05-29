// test of I2C service
// using a DS1307 Real Time clock
// registers 8 - 255 are actually battery backed RAM
// that can be written and read back
// making the device ideal for testing

import ..src.api show *

address := 104 // 16r68

main:

  bus := I2CServiceClient
  bus.open
  bus.connect address
  print (bus.read_reg address 8 1)
  bus.write address #[8, 10]
  print (bus.read_reg address 8 1)
  bus.disconnect address
  bus.close

