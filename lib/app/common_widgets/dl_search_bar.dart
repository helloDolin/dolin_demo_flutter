import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DLSearchBar extends StatefulWidget implements PreferredSizeWidget {
  const DLSearchBar({
    super.key,
    this.hideCancelBtn = false,
    this.hint,
    this.hintTextStyle,
    this.defaultText = '',
    this.onChanged,
    this.hideScanBtn = true,
    this.tapScanBtn,
    this.isPopWithAnimated = true,
    this.tapBackBtn,
    this.returnChanged,
    this.inputType,
    this.autofocus = false,
    this.backTitle,
    this.hideLeftBackBtn = true,
    this.tapLeftBackBtn,
    this.onSubmmit,
    this.focusNode,
  })
  // 仿 SDK AppBar 写法
  // ignore: avoid_field_initializers_in_const_classes
  : preferredSize = const Size.fromHeight(kToolbarHeight);

  final FocusNode? focusNode;
  final bool? hideCancelBtn;
  final bool? hideScanBtn;
  final String? hint;
  final TextStyle? hintTextStyle;
  final String? defaultText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? returnChanged;
  final VoidCallback? tapScanBtn;
  final VoidCallback? tapBackBtn;
  final bool? isPopWithAnimated;
  final TextInputType? inputType; // 键盘输入类型

  final bool? autofocus; // 为 true 时，与 flutter_boost 冲突，需要手动唤起键盘
  final String? backTitle;
  final bool? hideLeftBackBtn;
  final VoidCallback? tapLeftBackBtn;
  final ValueChanged<String>? onSubmmit;
  @override
  DLSearchBarState createState() => DLSearchBarState();

  @override
  final Size preferredSize;
}

class DLSearchBarState extends State<DLSearchBar> {
  bool _showClear = false; // 是否展示 × 号
  final double _searchBarHeight = 30; // 搜索框高度
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.defaultText!;
    super.initState();
  }

  @override
  void didUpdateWidget(DLSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.defaultText!.isNotEmpty) {
      _controller.value = TextEditingValue(
        text: widget.defaultText!,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.defaultText!.length),
        ),
      );
      _showClear = _controller.text.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        // 60 / 88 = 0.68
        alignment: const Alignment(-1, 0.68),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            _leftBackBtn,
            _scanBtn,
            _inputBox,
            _cancelBtn,
          ],
        ),
      );

  Widget get _leftBackBtn => Offstage(
        offstage: widget.hideLeftBackBtn!,
        child: InkWell(
          onTap: widget.tapLeftBackBtn ?? Get.back<void>,
          child: const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
      );
  Widget get _scanBtn => Offstage(
        offstage: widget.hideScanBtn!,
        child: InkWell(
          onTap: widget.tapScanBtn,
          child: const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Icon(
              Icons.qr_code,
              color: Colors.grey,
              size: 18,
            ),
          ),
        ),
      );

  Widget get _cancelBtn => widget.hideCancelBtn!
      ? const SizedBox(
          width: 18,
        )
      : InkWell(
          onTap: widget.tapBackBtn ?? Get.back<void>,
          child: Container(
            alignment: Alignment.center,
            height: _searchBarHeight,
            padding: const EdgeInsets.only(left: 12, right: 18),
            child: Text(
              widget.backTitle ?? '取消',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        );

  Widget get _inputBox => Expanded(
        child: Container(
          height: _searchBarHeight,
          padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
          margin: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(
              18 * MediaQuery.of(context).size.width / 375,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.search,
                size: 15,
                color: Color(0xFFBBBBBB),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: TextField(
                    controller: _controller,
                    autofocus: widget.autofocus!,
                    focusNode: widget.focusNode,
                    onChanged: _onChanged,
                    onSubmitted: _onSubmitted,
                    textInputAction: TextInputAction.search,
                    keyboardType: widget.inputType ?? TextInputType.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: widget.hint ?? '',
                      hintStyle: widget.hintTextStyle ??
                          const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFBBBBBB),
                          ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: !_showClear,
                child: InkWell(
                  onTap: () {
                    _controller.clear();
                    _onChanged('');
                    _onReturnChanged('');
                  },
                  child: SizedBox(
                    width: _searchBarHeight,
                    height: _searchBarHeight,
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  // 输入框内容改变
  void _onChanged(String text) {
    if (mounted) {
      setState(() {
        _showClear = text.isNotEmpty;
      });
    }
    // 回调
    widget.onChanged!(text.trim());
  }

  void _onSubmitted(String value) {
    widget.onSubmmit!(value);
    _onReturnChanged(value);
  }

  // 输入框内容改变
  void _onReturnChanged(String text) {
    if (mounted) {
      setState(() {
        _showClear = text.isNotEmpty;
      });
    }
    // 回调
    widget.returnChanged!(text.trim());
  }
}
