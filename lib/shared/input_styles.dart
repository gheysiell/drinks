import 'package:drinks/shared/palette.dart';
import 'package:flutter/material.dart';

class InputStyles {
  static OutlineInputBorder outlinedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Palette.white,
      width: 2,
    ),
  );
}
