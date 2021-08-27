import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The default value of [PhoneNumInput.inputBorderSideWidth].
const double defaultInputBorderSideWidth = 0.5;

/// The default value of [fontSize] of [PhoneNumInput.style].
const double defaultTextSize = 14;

/// The default value of [fontSize] of [PhoneNumInput.helperStyle].
const double defaultHelperTextSize = 10;

/// The default value of [PhoneNumInput.clearBtnSize].
const double defaultClearBtnSize = 13;

/// The default value of [PhoneNumInput.clearBtnMaxSize].
const double defaultClearBtnMaxSize = 30;

class PhoneNumInput extends StatefulWidget {
  /// The width of [PhoneNumInput].
  final double? width;

  /// Empty space to surround the container and [PhoneNumInput].
  final EdgeInsetsGeometry? margin;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// See [InputDecoration.hintText] for details.
  final String? hintText;

  /// The style to use for the [hintText].
  ///
  /// See [InputDecoration.hintStyle] for details.
  final TextStyle? hintStyle;

  /// Text that provides context about the [InputDecorator.child]'s value, such
  /// as how the value will be used.
  ///
  /// See [InputDecoration.helperText] for details.
  final String? helperText;

  /// The style to use for the [helperText].
  ///
  /// See [InputDecoration.helperStyle] for details.
  final TextStyle? helperStyle;

  /// The style to use for the text being edited.
  ///
  /// See [TextField.style] for details.
  final TextStyle? style;

  /// The clear button of [PhoneNumInput].
  final Widget? clearBtn;

  /// The size of the [clearBtn].
  final double clearBtnSize;

  /// The size of the constraints for the [clearBtn].
  final double clearBtnMaxSize;

  /// The width of this side of the border.
  ///
  /// See [BorderSide.width] for details.
  final double inputBorderSideWidth;

  /// Controls the text being edited.
  ///
  /// See [TextField.controller] for details.
  final TextEditingController controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// See [TextField.focusNode] for details.
  final FocusNode? focusNode;

  /// The callback with a length of 11.
  final ValueChanged<bool>? onNumInputComplete;

  /// The callback with value change.
  ///
  /// See [TextField.onChanged] for details.
  final ValueChanged<String>? onChanged;

  /// The type of action button to use for the keyboard.
  ///
  /// See [TextField.textInputAction] for details.
  final TextInputAction textInputAction;

  /// See [TextField.onEditingComplete] for details.
  final VoidCallback? onEditingComplete;

  /// Whether to show error state.
  final bool isShowErrorState;

  /// Whether to show [helperText].
  final bool isShowHelperText;

  /// Whether to show [InputBorder] of [PhoneNumInput].
  final bool isShowInputBorder;

  /// Whether the Helper text is synchronized with the error state.
  final bool helperTextSyncErrorState;

  PhoneNumInput({
    Key? key,
    this.width,
    this.margin,
    this.hintText,
    this.hintStyle,
    this.helperText,
    this.helperStyle,
    this.style,
    this.clearBtn,
    this.clearBtnSize = defaultClearBtnSize,
    this.clearBtnMaxSize = defaultClearBtnMaxSize,
    this.inputBorderSideWidth = defaultInputBorderSideWidth,
    required this.controller,
    this.focusNode,
    this.onNumInputComplete,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.isShowErrorState = false,
    this.isShowHelperText = false,
    this.isShowInputBorder = true,
    this.helperTextSyncErrorState = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhoneNumState();
}

class _PhoneNumState extends State<PhoneNumInput> {
  bool hasFocus = false;
  bool hasTextInput = false;
  bool isInputComplete = false;

  String _lastChangedText = "";
  String _lastInputContent = "";

  @override
  void initState() {
    widget.focusNode?.addListener(() {
      _onChangeStated("");
      setState(() {
        hasFocus = widget.focusNode!.hasFocus;
      });
    });
    super.initState();
  }

  TextStyle get _hintStyle =>
      widget.hintStyle ??
      TextStyle(
        fontSize: defaultTextSize,
        color: Colors.grey,
      );

  TextStyle get _helperStyle =>
      widget.helperStyle ??
      TextStyle(
        fontSize: defaultHelperTextSize,
        color: widget.helperTextSyncErrorState && widget.isShowErrorState
            ? Colors.redAccent
            : Colors.grey,
      );

  TextStyle get _style =>
      widget.style ??
      TextStyle(
        fontSize: defaultTextSize,
        color: Colors.black54,
      );

  InputBorder get _inputBorder => UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.isShowInputBorder && widget.isShowErrorState
              ? Colors.redAccent
              : Colors.grey,
          width: widget.inputBorderSideWidth,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      width: widget.width,
      child: TextField(
        // Autocorrect and enableSuggestions are false here because problems in
        // calculating space positions are caused when pasting content directly
        // in the input box.
        autocorrect: false,
        enableSuggestions: false,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: _buildInputDecoration(),
        style: _style,
        keyboardType: TextInputType.phone,
        textInputAction: widget.textInputAction,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp(r"[0-9]|\s")),
          LengthLimitingTextInputFormatter(13),
        ],
        onChanged: _onTextChanged,
        onEditingComplete: _onEditingComplete,
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? "please enter the phone number",
      hintStyle: _hintStyle,
      helperText: widget.isShowHelperText ? widget.helperText : "",
      helperStyle: (widget.isShowHelperText &&
              widget.helperText != null &&
              widget.helperText != "")
          ? _helperStyle
          : TextStyle(height: 0),
      border: widget.isShowInputBorder ? _inputBorder : InputBorder.none,
      focusedBorder: widget.isShowInputBorder ? _inputBorder : InputBorder.none,
      enabledBorder: widget.isShowInputBorder ? _inputBorder : InputBorder.none,
      suffixIcon: hasFocus && hasTextInput ? _buildClearIcon() : null,
      suffixIconConstraints: BoxConstraints(
        maxWidth: widget.clearBtnMaxSize,
        maxHeight: widget.clearBtnMaxSize,
      ),
    );
  }

  Widget _buildClearIcon() {
    return IconButton(
      icon: Container(
        width: widget.clearBtnSize,
        height: widget.clearBtnSize,
        child: widget.clearBtn ??
            Icon(
              Icons.clear,
              color: Colors.grey,
            ),
      ),
      padding: EdgeInsets.zero,
      alignment: Alignment.centerRight,
      onPressed: () {
        widget.controller.clear();
        _onChangeStated("");
      },
    );
  }

  void _onChangeStated(String value) {
    String nowText = widget.controller.text.replaceAll(" ", "");
    // 1. have content input, refresh the component
    bool tempHasInput = nowText.length > 0;
    if (hasTextInput != tempHasInput) {
      setState(() {
        hasTextInput = tempHasInput;
      });
    }
    // 2. Call back when the content length reaches 11.
    bool tempIsInputComplete = nowText.length == 11;
    if (isInputComplete != tempIsInputComplete) {
      isInputComplete = tempIsInputComplete;
      widget.onNumInputComplete?.call(isInputComplete);
    }
    // 3. call the onChanged method
    widget.onChanged?.call(value);
  }

  void _onTextChanged(String value) {
    if (_lastChangedText == value) return;
    _lastChangedText = value;
    // 1. update state
    _onChangeStated(value);
    // 2. separate the content
    String nowText = widget.controller.text;
    if (_lastInputContent != nowText) {
      String newContent = _convertPhoneNum(nowText);
      int _cursorOffset = _calcCursorOffset(nowText, newContent);
      _lastInputContent = newContent;
      // Tips: Here's a problem. update the value of TextEditingValue, but the
      // display is incorrectly
      // e.g.
      // set the TextEditingValue to '123 4567 89', and the page shows
      // '123 45678 9'.
      widget.controller.value = TextEditingValue(
        text: newContent,
        selection: TextSelection.collapsed(offset: _cursorOffset),
      );
    }
  }

  int _calcCursorOffset(String nowText, String newContent) {
    // 1. init params (get the current cursor termination location and whether
    // to add content.)
    int _currentCursorExtentOffset = widget.controller.selection.extentOffset;
    bool _isAddText = nowText.length > _lastInputContent.length;
    // 2. the cursor is at the end, and the new cursor is at the end
    if (_currentCursorExtentOffset == nowText.length) return newContent.length;
    // 3. add content
    if (_isAddText) {
      // there is a space behind the cursor, and the new cursor moves back a
      // position
      if (" " ==
          nowText.substring(
            _currentCursorExtentOffset,
            _currentCursorExtentOffset + 1,
          )) return _currentCursorExtentOffset + 1;
      // the input is spaced, and the new cursor moves forward a position
      if (" " ==
          nowText.substring(
            _currentCursorExtentOffset - 1,
            _currentCursorExtentOffset,
          )) return _currentCursorExtentOffset - 1;
      return _currentCursorExtentOffset;
    }
    // 4. delete content
    // the cursor is at the start, and the new cursor is still at the start
    if (_currentCursorExtentOffset == 0) return 0;
    // there is a space in front of the cursor, and the new cursor moves forward
    // a position
    if (" " ==
        nowText.substring(
          _currentCursorExtentOffset - 1,
          _currentCursorExtentOffset,
        )) return _currentCursorExtentOffset - 1;
    return _currentCursorExtentOffset;
  }

  String _convertPhoneNum(String value) {
    // 1. remove irregular spaces
    value = value.trim().replaceAll(" ", "");
    // 2. start convert
    String result = value;
    if (value.length > 3) {
      if (value.length <= 7) {
        result = value.substring(0, 3) + " " + value.substring(3);
      } else if (value.length > 7) {
        result = value.substring(0, 3) +
            " " +
            value.substring(3, 7) +
            " " +
            value.substring(7);
      }
    }
    return result;
  }

  void _onEditingComplete() {
    String nowText = widget.controller.text.replaceAll(" ", "");
    if (nowText.length == 11) widget.onEditingComplete?.call();
  }
}
