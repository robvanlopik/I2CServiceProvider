// author: Rob van Lopik
// license MIT
// may 2023

import system.services show *
import .api show *
import i2c
import gpio

class I2CServiceProvider extends ServiceProvider
    implements ServiceHandler:
  i2cBus/any := null
  i2cDevices := {:}
  constructor:
    super "i2cprovider" --major=7 --minor=3
    provides I2CService.SELECTOR --handler=this

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == I2CService.OPEN_INDEX: return open arguments[0]
    if index == I2CService.CLOSE_INDEX: return close arguments[0]
    if index == I2CService.READ_INDEX: return read arguments[0] arguments[1]
    if index == I2CService.WRITE_INDEX: return write arguments[0] arguments[1]
    if index == I2CService.READ_REG_INDEX: return read_reg arguments[0] arguments[1] arguments[2]    
    unreachable



  open address/int:
    if i2cDevices.is_empty:
      i2cBus = i2c.Bus
         --sda=gpio.Pin 21
         --scl=gpio.Pin 22
    if i2cDevices.contains address: return // probably from a previous run of the client container
    i2cDevices[address] = i2cBus.device address

  close address/int:
    i2cDevices[address].remove
    if i2cDevices.is_empty: i2cBus.close

  read address/int count/int -> ByteArray:
    return i2cDevices[address].read count

  write address/int data/ByteArray:
    return i2cDevices[address].write data

  read_reg address/int register/int count/int -> ByteArray:
    return i2cDevices[address].read_reg register count 