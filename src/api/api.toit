// Author: Rob van Lopik
// license: MIT
// may 2023

import system.services

interface I2CService:
  static SELECTOR ::= services.ServiceSelector
      --uuid="i2ci2ci2c"
      --major=1
      --minor=0

  connect address/int -> none
  static CONNECT_INDEX ::= 0

  disconnect address/int -> none
  static DISCONNECT_INDEX ::= 1

  read address/int count/int -> ByteArray
  static READ_INDEX ::= 2

  read_reg address/int register/int count/int -> ByteArray
  static READ_REG_INDEX ::= 3

  write address nytes/ByteArray
  static WRITE_INDEX ::= 4

  // ------------------------------------------------------
  // The Client class
  //
class I2CServiceClient extends services.ServiceClient 
    implements I2CService:
  static SELECTOR ::= I2CService.SELECTOR
 
  constructor  selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  connect address/int -> none:
    invoke_ I2CService.CONNECT_INDEX [address]

  disconnect address/int -> none:
    invoke_ I2CService.DISCONNECT_INDEX [address]
    
  read address/int count/int -> ByteArray:
    return invoke_ I2CService.READ_INDEX [address, count]

  read_reg address/int register/int count/int -> ByteArray:
    return invoke_ I2CService.READ_REG_INDEX [address, register, count]

  write address/int data/ByteArray -> none:
    invoke_ I2CService.WRITE_INDEX [address, data]