// test of I2C service

import ..src.api show *

address := 104 // 16r68

main:

  bus := I2CServiceClient
  bus.open
  bus.open address
  print (bus.read_reg address 8 1)
  bus.write address #[8, 10]
  print (bus.read_reg address 8 1)
  bus.close

