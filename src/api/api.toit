// Author: Rob van Lopik
// license: MIT
// may 2023

import system.services

interface I2CService:
  static SELECTOR ::= services.ServiceSelector
      --uuid="i2ci2ci2c"
      --major=1
      --minor=0

  connect_ address/int -> none
  static CONNECT_INDEX ::= 0

  disconnect  -> none
  static DISCONNECT_INDEX ::= 1

  read  count/int -> ByteArray
  static READ_INDEX ::= 2

  read_reg register/int count/int -> ByteArray
  static READ_REG_INDEX ::= 3

  write  bytes/ByteArray
  static WRITE_INDEX ::= 4

  read_address addr/ByteArray count/int -> ByteArray
  static READ_ADDRESS_INDEX ::= 5

  // ------------------------------------------------------
  // The Client class
  //
class i2cDevice extends services.ServiceClient 
    implements I2CService :
  static SELECTOR ::= I2CService.SELECTOR
  address /int

  constructor  .address selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector
    connect_ address

  connect_ address/int -> none:
    invoke_ I2CService.CONNECT_INDEX [address]

  disconnect  -> none:
    invoke_ I2CService.DISCONNECT_INDEX [address]
    
  read count/int -> ByteArray:
    return invoke_ I2CService.READ_INDEX [address, count]

  read_reg register/int count/int -> ByteArray:
    return invoke_ I2CService.READ_REG_INDEX [address, register, count]

  write data/ByteArray -> none:
    invoke_ I2CService.WRITE_INDEX [address, data]

  read_address address1/ByteArray count/int -> ByteArray:
    return invoke_ I2CService.READ_ADDRESS_INDEX [address, address1, count]