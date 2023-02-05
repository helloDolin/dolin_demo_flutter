import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
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
            // final _counter = Provider.of<CounterModel>(context, listen: true);
            // print(_counter.counter);
            Navigator.pushNamed(context, '/customPaintPage');
          }),
          Card('asyncPage', () {
            Navigator.pushNamed(context, '/asyncPage');
          }),
        ],
      ),
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
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          height: 44,
          child: Text(title),
        ));
  }
}
