//
//
import bme280
import ..src.I2CServer show *
import ..src.api show *




main:
  xbus := I2CServiceClient
  xdevice := xbus.