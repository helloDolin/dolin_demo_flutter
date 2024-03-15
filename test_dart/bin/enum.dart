enum PortType {
  usbA('USB-A', true),
  usbC('USB-C', true),
  typeC('TYPE-C'),
  unknown('UNKNOWN');

  final String name;
  final bool isUSB;
  // 枚举也可以有构造函数
  const PortType(this.name, [this.isUSB = false]);
}