import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:flutter/gestures.dart';
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

  final String _testTitle = '''一名优秀的大前端工程师应该具备以下特征：
在技术层面应该抛开对开发框架的站队，除了应用层 API 之外，能够更多地关注其底层原理、设计思路和通用理念，对中短期技术发展方向有大致思路，并思考如何与过往的开发经验相结合，融汇进属于自己的知识体系抽象网络；
而在业务上应该跳出自身职能的竖井，更多关注产品交互设计层面背后的决策思考，在推进项目时，能够结合大前端直面用户的优势，将自己的专业性和影响力辐射到协作方上下游，综合提升自己统筹项目的能力。

进步很难，其实是因为那些可以让人进步的事情往往都是那些让人焦虑、带来压力的。而人生的高度，可能就在于你怎么面对困难，真正能够减轻焦虑的办法就是走出舒适区，迎难而上，去搞定那些给你带来焦虑和压力的事情，这样人生的高度才能被一点点垫起来。解决问题的过程通常并不是一帆风顺的，这就需要坚持。所谓胜利者，往往是能比别人多坚持一分钟的人。

勿畏难，勿轻略，让我们在技术路上继续扩大自己的边界，保持学习，持续成长。''';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _item(
                  nickName: '昵称1',
                  imgUrl:
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F056708c6-0633-4b8e-9fdb-38f0d182aaaf%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1683630840&t=755472eff3fa2327192ee4b0e7856422'),
              const SizedBox(height: 15),
              _item(
                  nickName: '昵称2',
                  imgUrl:
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fe711d64a-9299-482e-9dac-e917ebe0db10%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1683630840&t=8e54318751a8cc8b064ac7cc57f03424',
                  photoUrlList: [
                    'https://pics7.baidu.com/feed/79f0f736afc3793121036d39363fa44d42a911be.jpeg@f_auto?token=0aaadd53c46984bba8bdf06f0cfc1d9a&s=3E04D6067A5162C41AB7AC6F0300603B',
                    'https://img.jinse.cn/5469608_image3.png',
                    'https://img95.699pic.com/element/40037/8013.png_860.png',
                    'https://is3-ssl.mzstatic.com/image/thumb/Purple115/v4/39/21/c9/3921c9ff-eaf0-452b-1a38-880e7b6b9098/source/200x200bb.jpg',
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fbf6fe5f0-4e5c-4dd1-9545-f58151164f0c%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1683630840&t=4b13e03de5df78801080a829a8f815f3',
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F8f92d2dc-7f0f-498b-b295-e878b2f8d83e%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1683630840&t=360880e0100225a1576860bd28fdddeb',
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F925460f4-2e50-4adb-85eb-f48d5dbdba35%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1683630840&t=5e10b6b9bdb940b2181eb09cfbd1f683'
                  ]),
              const SafeArea(child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
      {String? nickName = '昵称', String? imgUrl, List<String>? photoUrlList}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenAdapter.width(50),
            height: ScreenAdapter.width(50),
            child: Image.network(imgUrl!),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickName!,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableText(
                text: _testTitle,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              if ((photoUrlList ?? []).isNotEmpty) ...[
                const SizedBox(
                  height: 10,
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final width = (constraints.maxWidth - 10 * 2) / 3;

                    return (Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: photoUrlList!
                          .map((e) => SizedBox(
                                width: width,
                                height: width,
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList(),
                    ));
                  },
                )
              ],
              const SizedBox(
                height: 10,
              ),
              _menu('3分钟前'),
            ],
          ))
        ],
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
                        height: ScreenAdapter.height(20),
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
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.none),
                                  ),
                                if (w > ScreenAdapter.width(150))
                                  const Text('评论',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          decoration: TextDecoration.none)),
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

  Widget _menu(String title) {
    GlobalKey btnKey = GlobalKey();
    return SizedBox(
        child: Row(
      children: [
        Text(title),
        const Spacer(),
        InkWell(
          onTap: () {
            _getBtnOffset(btnKey);
            _showMenu();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(3))),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            height: ScreenAdapter.height(20),
            key: btnKey,
            child: const Icon(Icons.more_horiz_outlined),
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

class ExpandableText extends StatefulWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLines;
  final String? expandText;
  final String? collapseText;

  const ExpandableText(
      {Key? key,
      required this.text,
      this.style = const TextStyle(fontSize: 14, color: Colors.black),
      this.maxLines = 3,
      this.collapseText = '收起',
      this.expandText = '展开'})
      : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var span = TextSpan(
        text: widget.text,
        style: widget.style,
      ); // 一定记得传这个值，要不然 didExceedMaxLines 不知道怎么计算

      final textPainter = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: constraints.maxWidth);
      final textSize = textPainter.size;
      var position = textPainter.getPositionForOffset(Offset(
        textSize.width,
        textSize.height,
      ));
      print(position);
      final endOffset = textPainter.getOffsetBefore(position.offset);
      print(endOffset);

      if (textPainter.didExceedMaxLines) {
        print('超出最大');
      } else {
        print('未超出最大');
      }

      return RichText(
        text: TextSpan(
            text: _expand
                ? widget.text
                : '${widget.text!.substring(0,
                    //  endOffset
                    (endOffset! - (_expand ? widget.collapseText!.length : widget.expandText!.length)))}...',
            style: widget.style,
            children: [
              TextSpan(
                  text: _expand ? widget.collapseText : widget.expandText,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: widget.style!.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _expand = !_expand;
                      });
                    }),
            ]),
      );
    });
  }
}
