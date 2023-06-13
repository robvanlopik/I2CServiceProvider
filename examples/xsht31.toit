import ..src.api show *
import ..src.xi2cbus show *
import sht31_d_driver.sht31
import i2c

main:
  
  bus := XI2CBus

  device := bus.device sht31.I2C_ADDRESS

  driver := sht31.Driver (device as i2c.Device)

  print "$driver.read_temperature C"
  print "$driver.read_humidity %"