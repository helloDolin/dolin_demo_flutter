import 'package:flutter/material.dart';

class UnKnowPage extends StatefulWidget {
  const UnKnowPage({Key? key}) : super(key: key);

  @override
  State<UnKnowPage> createState() => _UnKnowPageState();
}

class _UnKnowPageState extends State<UnKnowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: const Center(
        child: Text(
          '页面走失了',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
