import 'package:flutter/material.dart';

class PopupPage extends StatelessWidget {
  const PopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CompositedTransformFollower Example'),
        ),
        body: const Center(
          child: TipBox(),
        ),
      ),
    );
  }
}

class TipBox extends StatefulWidget {
  const TipBox({super.key});
  @override
  State<TipBox> createState() => _TipBoxState();
}

class _TipBoxState extends State<TipBox> {
  final LayerLink layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOverlay,
      child: CompositedTransformTarget(
        link: layerLink,
        child: Image.asset(
          'assets/images/login/btn_next_enable.png',
          width: 80,
          height: 80,
        ),
      ),
    );
  }

  void _toggleOverlay() {
    if (!show) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
    show = !show;
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (BuildContext context) => UnconstrainedBox(
          child: CompositedTransformFollower(
            followerAnchor: Alignment.bottomCenter,
            targetAnchor: Alignment.topCenter,
            offset: const Offset(0, -10),
            link: layerLink,
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'testtesttesttesttesttest',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ),
        ),
      );

  void _hideOverlay() {
    _overlayEntry.remove();
  }
}
