import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldGray extends StatelessWidget {
  TextfieldGray({
    this.hintText = 'Username',
    this.isobscure = false,
    required this.validator,
    this.showSuffix = false,
    this.letterSpacing = 0.0,
    this.fontWeight: FontWeight.w400,
    required this.textEditingController,
    this.isAutoFocus = false,
    this.textInputType = TextInputType.text,
    required this.suffixPressed,
    this.suffixIcon = Icons.remove_red_eye_outlined,
  });
  final String hintText;
  final bool isobscure;
  final bool showSuffix;
  final Function validator;
  final double letterSpacing;
  final FontWeight fontWeight;
  final TextEditingController textEditingController;
  final bool isAutoFocus;
  final TextInputType textInputType;
  final Function suffixPressed;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color? color = theme.scaffoldBackgroundColor == Colors.white
        ? Colors.grey[300]
        : Color(0xff252A34);
    return TextFormField(
      validator: (value) => validator(value),
      keyboardType: textInputType,
      cursorColor: theme.accentColor,
      obscureText: isobscure,
      controller: textEditingController,
      autofocus: isAutoFocus,
      style: TextStyle(
        // color: Color(0xffE9EAEF),
        color: Colors.grey[900],
        fontSize: 17,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 28),
        filled: true,
        fillColor: color,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: color!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: color),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: color),
        ),
        suffixIcon: showSuffix
            ? IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => suffixPressed(),
                icon: Icon(
                  suffixIcon,
                  color: theme.accentColor,
                ),
              )
            : null,
      ),
    );
  }
}
