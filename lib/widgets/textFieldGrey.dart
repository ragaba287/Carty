import 'package:flutter/material.dart';

Function? validateFunc(value) => null;

class TextfieldGray extends StatelessWidget {
  TextfieldGray({
    this.hintText = 'Username',
    this.isobscure = false,
    this.validator = validateFunc,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.suffixPressed,
    this.suffixIcon,
  });
  final String hintText;
  final bool isobscure;
  final Function validator;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function? suffixPressed;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    // App Theme
    var theme = Theme.of(context);

    //Check if dark mode enabled
    bool darkModeOn = theme.brightness == Brightness.dark;

    //Main Text Field Color
    Color? color = darkModeOn ? Color(0xff252A34) : Colors.grey[300];

    //Main Text Field border
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: color!),
    );

    return TextFormField(
      validator: (value) => validator(value!),
      keyboardType: textInputType,
      cursorColor: theme.accentColor,
      obscureText: isobscure,
      controller: textEditingController,
      style: TextStyle(
        color: darkModeOn ? Color(0xffE9EAEF) : Colors.grey[900],
        fontSize: 17,
        fontWeight: FontWeight.w400,
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
        enabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(color: Colors.red[700]!),
        ),
        focusedBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(color: Colors.red[700]!),
        ),
        suffixIcon: suffixPressed != null || suffixIcon != null
            ? IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => suffixPressed!(),
                icon: Icon(suffixIcon, color: theme.accentColor),
              )
            : null,
      ),
    );
  }
}
