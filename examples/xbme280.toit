// example using bme280 with i2cServiceProvider
import bme280
import ..src.api show *
import ..src.xi2cbus show *


main:
  
  bus := XI2CBus

  device := bus.device bme280.I2C_ADDRESS_ALT

  driver := bme280.Driver device

  print "$driver.read_temperature C"
  print "$driver.read_pressure Pa"
  print "$driver.read_humidity %"