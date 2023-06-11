//
import ..src.api show *
import serial
class XI2CBus:
  i2cClient/I2CServiceClient ::= ?
  devices := {:}
  constructor:
    i2cClient = I2CServiceClient
    i2cClient.open

  device i2c_address/int -> XI2CDevice:
    if devices.contains i2c_address: throw "Device already connected"
    device := XI2CDevice this i2c_address
    devices[i2c_address] = device
    return device

  connect addr/int:
    i2cClient.connect addr
  

class XI2CDevice implements serial.Device:
  i2c_address/int :=?
  registers/XRegisters? :=null
  i2cTransport/XI2CBus :=?
  i2c_/I2CServiceClient := ?

  constructor  .i2cTransport .i2c_address:
    i2cTransport.connect i2c_address
    i2c_ = i2cTransport.i2cClient

// 
// i2c methods for dXI2CDevice
//
  write bytes/ByteArray:
    i2c_.write i2c_address bytes

  read count/int:
    return i2c_.read i2c_address count

  read_reg register/int count/int:
    return i2c_.read_reg i2c_address register count

  

//
// XRegisters is copied for i2c.toit
//
class XRegisters extends serial.Registers:
  device_/XI2CDevice ::= ?
  constructor .device_:
    /** See $super. */

  read_bytes reg count:
    return device_.read_reg reg count

  /** See $super. */
  /* skip for now !! cannot because defined in abstract class
  simply left out the failure part in the device_- call
  */
  read_bytes reg count [failure]:
    return device_.read_reg reg count 

  /** See $super. */
  write_bytes reg bytes:
    data := ByteArray bytes.size + 1
    data[0] = reg
    data.replace 1 bytes
    device_.write data

