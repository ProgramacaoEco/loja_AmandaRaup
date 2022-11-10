import "package:flutter/material.dart";

class Decor extends InputDecoration {
  InputBorder get border => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[800], width: 0.0));

  InputBorder get enabledBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[800], width: 0.0));

  InputBorder get focusedBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[800], width: 0.0));

  TextStyle get labelStyle => TextStyle(color: Colors.grey[800]);

  Decor({String labelText, bool isDense})
      : super(labelText: labelText, isDense: isDense);
}
