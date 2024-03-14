import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';
import 'package:wrapper/wrapper.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('时光轴'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 46),
        child: const Column(
          children: [
            TimeLineNode(),
            // TimeLineNode2(),
          ],
        ),
      ),
    );
  }
}

class TimeLineNode extends StatelessWidget {
  const TimeLineNode({super.key});

  final double dashLineWith = 20;
  final double marginTop = 10;
  final double offset = 20 + 10;
  final double lineWidth = 2;
  final double circleRadius = 5;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildDecoration(),
          Expanded(flex: 10, child: _buildCenterWidget()),
          const Spacer()
        ],
      ),
    );
  }

  Widget _buildDecoration() => Container(
        margin: const EdgeInsets.only(left: 20),
        width: dashLineWith,
        decoration: DashDecoration(
          circleColor: Colors.blueAccent,
          lineColor: Colors.white,
          circleRadius: circleRadius,
          color: Colors.white,
          circleOffset: Offset(lineWidth / 2, offset + 10 / 2),
        ),
      );

  Widget _buildCenterWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrapper(
        color: Colors.white,
        offset: 20 + 10 / 2 - 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '一名优秀的大前端工程师应该具备以下特征',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                '''
一名优秀的大前端工程师应该具备以下特征：
在技术层面应该抛开对开发框架的站队，除了应用层 API 之外，能够更多地关注其底层原理、设计思路和通用理念，对中短期技术发展方向有大致思路，并思考如何与过往的开发经验相结合，融汇进属于自己的知识体系抽象网络；
而在业务上应该跳出自身职能的竖井，更多关注产品交互设计层面背后的决策思考，在推进项目时，能够结合大前端直面用户的优势，将自己的专业性和影响力辐射到协作方上下游，综合提升自己统筹项目的能力。

进步很难，其实是因为那些可以让人进步的事情往往都是那些让人焦虑、带来压力的。而人生的高度，可能就在于你怎么面对困难，真正能够减轻焦虑的办法就是走出舒适区，迎难而上，去搞定那些给你带来焦虑和压力的事情，这样人生的高度才能被一点点垫起来。解决问题的过程通常并不是一帆风顺的，这就需要坚持。所谓胜利者，往往是能比别人多坚持一分钟的人。

勿畏难，勿轻略，让我们在技术路上继续扩大自己的边界，保持学习，持续成长。''',
                style: TextStyle(
                  color: Color(
                    0xffCBCBCB,
                  ),
                  fontSize: 12,
                  shadows: [Shadow(color: Colors.blueAccent, blurRadius: .1)],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Image(
                image: AssetImage(
                  'assets/images/btc_2_the_moon.jpg',
                ),
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              '2020-04-15',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashDecoration extends Decoration {
  const DashDecoration({
    required this.color,
    required this.circleColor,
    required this.lineColor,
    required this.circleOffset,
    required this.circleRadius,
  });
  final Color color;
  final Color circleColor;
  final Color lineColor;
  final Offset circleOffset;
  final double circleRadius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      DashBoxPainter(decoration: this);
}

class DashBoxPainter extends BoxPainter {
  const DashBoxPainter({required this.decoration});
  final DashDecoration decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    final Paint paint = Paint()..style = PaintingStyle.stroke;
    final Path path = Path();
    canvas.translate(
      offset.dx,
      offset.dy,
    );
    // 绘制直线
    canvas.drawLine(
      Offset(-decoration.circleOffset.dx, 0),
      Offset(-decoration.circleOffset.dx, configuration.size!.height),
      paint
        ..color = decoration.lineColor
        ..strokeWidth = 2,
    );

    // 绘制虚线
    path
      ..moveTo(0, decoration.circleOffset.dy)
      ..relativeLineTo(configuration.size!.width, 0);
    const DashPainter(step: 3).paint(
      canvas,
      path,
      paint
        ..color = decoration.color
        ..strokeWidth = 1,
    );

    //绘制圆点
    final Paint paint2 = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(-decoration.circleOffset.dx, decoration.circleOffset.dy),
      decoration.circleRadius,
      paint2,
    );
    canvas.drawCircle(
      Offset(-decoration.circleOffset.dx, decoration.circleOffset.dy),
      decoration.circleRadius * 0.6,
      paint2..color = decoration.circleColor,
    );
    canvas.restore();
  }
}
