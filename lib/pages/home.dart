import 'package:dolin_demo_flutter/model/counter.dart';
import 'package:dolin_demo_flutter/util/randomColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = 'home';

  @override
  Widget build(BuildContext context) {
    debugPrint('homne build');
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Card('scrollView', () {
                Navigator.pushNamed(context, '/scrollViewPage',
                    arguments: {'key': 'value'}).then((value) {
                  if (value != null) {
                    setState(() {
                      _title = value.toString();
                    });
                  }
                });
              }),
              Card('customPaintPage', () {
                Navigator.pushNamed(context, '/customPaintPage');
              }),
              Card('asyncPage', () {
                Navigator.pushNamed(context, '/async+provider');
              }),
              Card('arenaPage', () {
                Navigator.pushNamed(context, '/arenaPage');
              }),
              Card('blocPage', () {
                Navigator.pushNamed(context, '/blocPage');
              }),
              Card('yiledStudy', () {
                Navigator.pushNamed(context, '/yiledStudy');
              }),
              Text(
                  'couter count 为：${Provider.of<CounterModel>(context).counter.toString()}')
            ],
          )),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.title, this.onTap, {Key? key}) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: getRandomColor(), width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          height: 44,
          child: Text(title),
        ));
  }
}
