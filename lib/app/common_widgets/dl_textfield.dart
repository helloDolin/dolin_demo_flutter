import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DLTextField extends StatefulWidget {
  const DLTextField(
      {super.key,
      this.text = '',
      required this.maxLength,
      this.enabled = true,
      this.onChanged,
      this.autofocus = false});
  final String text;
  final int maxLength;
  final bool enabled;
  final bool autofocus;
  final Function(String)? onChanged;

  @override
  State<DLTextField> createState() => _DLTextFieldState();
}

class _DLTextFieldState extends State<DLTextField> {
  final TextEditingController _controller = TextEditingController();
  late List<TextInputFormatter> _textInputFormatterList;

  @override
  void initState() {
    _setController();
    _textInputFormatterList = [
      LengthLimitingTextInputFormatter(widget.maxLength),
      // 金额正则表达式
      FilteringTextInputFormatter.allow(
          RegExp(r'^\-?([1-9]\d*|0)(\.\d{0,2})?')),
      //RegExp(r'^[0-9]+(.[0-9]{0,2})?$')
      //
    ];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DLTextField oldWidget) {
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
    return TextField(
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      controller: _controller,
      inputFormatters: _textInputFormatterList,
      onChanged: (text) {
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
      },
    );
  }
}
