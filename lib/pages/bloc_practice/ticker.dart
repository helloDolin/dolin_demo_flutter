// 秒表的数据源
// 返回一个每秒发送剩余秒数的流
class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream<int>.periodic(
        const Duration(seconds: 1), (x) => ticks - x - 1).take(ticks);
  }
}
/*
Stream
! 延迟间隔
! future 数据源
? 阿斯顿发第三方
* 阿打发打发
TODO:
*/
