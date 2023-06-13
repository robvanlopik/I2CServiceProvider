# I2CServiceProvider
Provides I2C access for Toit containers (WIP)

Usage:
Install examples/base.toit in a container that will provide acces to the I2C bus.

When another program want to use an I2C device it can do so as follows:
``` toit
bus := XI2CBus
device := bus.device address
```
device responds to the usual i2c commands.

You can use driver libraries for i2c devices if they type the `device_` as `serial.Device`. If the driver uses `i2c.Device` is does not work.


