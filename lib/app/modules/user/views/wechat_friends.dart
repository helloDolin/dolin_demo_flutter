import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:flutter/material.dart';

class WechatFriends extends StatefulWidget {
  const WechatFriends({super.key});

  @override
  State<WechatFriends> createState() => _WechatFriendsState();
}

class _WechatFriendsState extends State<WechatFriends>
    with SingleTickerProviderStateMixin {
  // 层管理
  OverlayState? _overlayState;
  // 遮罩层
  OverlayEntry? _overlayEntry;

  Offset _btnOffset = Offset.zero;

  // 菜单宽度
  final double kMenuWidth = ScreenAdapter.width(200);

  late AnimationController _animationController;
  late Animation<double> _sizeTween;

  void _getBtnOffset(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    final Offset offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    _btnOffset = offset;
  }

  @override
  void initState() {
    super.initState();
    _overlayState = Overlay.of(context);

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _sizeTween = Tween(begin: 0.0, end: kMenuWidth).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('微信朋友圈'),
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _header(),
            _menu(),
            SizedBox(height: ScreenAdapter.height(10)),
            _menu(),
          ],
        ),
      ),
    );
  }

  _removeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  _showMenu() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () async {
              if (_animationController.status == AnimationStatus.completed) {
                // 需要异步等待结束，否则没有动画效果
                await _animationController.reverse();
                _removeMenu();
              }
            },
            child: Stack(children: [
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Positioned(
                      top: _btnOffset.dy,
                      left: _btnOffset.dx - _sizeTween.value,
                      child: Container(
                        width: _sizeTween.value,
                        height: ScreenAdapter.height(40),
                        color: Colors.white,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final w = constraints.maxWidth;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (w > ScreenAdapter.width(100))
                                  const Text(
                                    '赞',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                if (w > ScreenAdapter.width(150))
                                  const Text('评论',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                              ],
                            );
                          },
                        ),
                      ));
                },
              )
            ]),
          ),
        );
      },
    );
    _overlayState?.insert(_overlayEntry!);
    Future.delayed(const Duration(microseconds: 100), () {
      if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  Widget _header() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: ScreenAdapter.height(15)),
          width: double.infinity,
          height: ScreenAdapter.height(200),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://wmdb.querydata.org/movie/poster/1603701754760-c50d8a.jpg'),
                  fit: BoxFit.cover)),
        ),
        Positioned(
            right: ScreenAdapter.width(10),
            bottom: 0,
            child: Row(
              children: [
                Text(
                  'DOLIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(18),
                      letterSpacing: 3,
                      height: 1,
                      shadows: const [
                        Shadow(
                          color: Colors.cyanAccent,
                          offset: Offset(3, 3),
                          blurRadius: 1,
                        )
                      ]),
                ),
                SizedBox(
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.width(50),
                  child: Image.network(
                      'https://avatars.githubusercontent.com/u/12538263?s=100&v=4'),
                ),
              ],
            ))
      ],
    );
  }

  Widget _menu() {
    GlobalKey btnKey = GlobalKey();
    return SizedBox(
        child: Row(
      children: [
        const Text('123'),
        const Spacer(),
        InkWell(
          onTap: () {
            _getBtnOffset(btnKey);
            _showMenu();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: ScreenAdapter.height(40),
            color: Colors.blue,
            key: btnKey,
            child: const Text('更多'),
          ),
        )
      ],
    ));
  }
}

class Btn extends StatelessWidget {
  const Btn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          side: MaterialStateProperty.all(
              const BorderSide(width: 1, color: Color(0xffCAD0DB))), //边框

          shape: MaterialStateProperty.all(
              // CircleBorder()
              // RoundedRectangleBorder
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
          // margin: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: const Text('更多'));
  }
}
