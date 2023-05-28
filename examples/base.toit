// base container hosting the i2c service provider

import ..src.I2CServer show *

main:

  i2cServer := I2CServiceProvider
  i2cServer.install
  print "I2C server installed"