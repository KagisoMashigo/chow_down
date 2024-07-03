import 'package:chow_down/components/design/chow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormField extends StatefulWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final int? maxLength;
  final bool obscureText;
  final bool isDisabled;
  final bool enableSuggestions;
  final bool autocorrect;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isClearable;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? initialValue;
  final bool upperCase;
  final Iterable<String>? autofillHints;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final InputDecoration? decoration;

  const TextFormField({
    Key? key,
    this.controller,
    this.maxLength,
    this.label,
    this.labelStyle,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.errorText,
    this.onSaved,
    this.autofillHints,
    this.keyboardType,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.isClearable = false,
    this.isDisabled = false,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.initialValue,
    this.upperCase = false,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.autovalidateMode,
    this.decoration,
  }) : super(key: key);

  @override
  TextFormFieldState createState() => TextFormFieldState();
}

class TextFormFieldState extends State<TextFormField> {
  late bool _isTextObscured;

  @override
  void initState() {
    _isTextObscured = widget.obscureText;
    super.initState();
  }

  Widget toggleTextVisibility() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTextObscured = !_isTextObscured;
        });
      },
      child: Text(
        _isTextObscured ? 'Show' : 'Hide',
        style: const TextStyle(color: ChowColors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: widget.textAlign,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      // TODO review this cursor color
      // cursorColor: ChowColors.borderGreen,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      autofillHints: widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        suffix: widget.obscureText ? toggleTextVisibility() : null,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: widget.isDisabled ? ChowColors.grey200 : ChowColors.white,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ChowColors.red700,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(color: ChowColors.red700),
        errorText: widget.errorText,
        errorMaxLines: 99,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.fromLTRB(Spacing.sm, 0, Spacing.sm, 0),
        hintText: widget.hint,
        hintStyle:
            widget.hintStyle ?? const TextStyle(fontSize: ChowFontSizes.md),
        floatingLabelBehavior: widget.floatingLabelBehavior,
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ChowColors.red700,
            width: 2,
          ),
        ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: VistaTextFieldTokens.focusedBorderColor,
        //       width: VistaTextFieldTokens.focusedBorderWidth),
        // ),
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: VistaTextFieldTokens.borderColor),
        // ),
        // disabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: VistaTextFieldTokens.borderColor),
        // ),
        // labelText: widget.label,
        // labelStyle: widget.labelStyle ??
        //     const TextStyle(color: VistaTextFieldTokens.labelColor),
      ),
      obscureText: _isTextObscured,
      // enabled: !widget.isDisabled,
      inputFormatters: widget.inputFormatters,
      initialValue: widget.initialValue,
      // textCapitalization: widget.upperCase
      //     ? TextCapitalization.characters
      //     : TextCapitalization.none,
      // style: widget.textStyle,
    );
  }
}
