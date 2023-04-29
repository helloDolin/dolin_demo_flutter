import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RateTextField extends StatefulWidget {
  const RateTextField(
      {super.key,
      this.text = '',
      required this.maxLength,
      this.enabled = true,
      this.onChanged});
  final String text;
  final int maxLength;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  State<RateTextField> createState() => _RateTextFieldState();
}

class _RateTextFieldState extends State<RateTextField> {
  final TextEditingController _controller = TextEditingController();
  late List<TextInputFormatter> _textInputFormatterList;

  @override
  void initState() {
    _setController();
    _textInputFormatterList = [
      LengthLimitingTextInputFormatter(widget.maxLength)
    ];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RateTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      if (mounted) {
        setState(() {
          _setController();
        });
      }
    }
  }

  _setController() {
    _controller.text = widget.text;
    _controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: widget.enabled,
        controller: _controller,
        inputFormatters: _textInputFormatterList,
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
      ),
    );
  }
}
