import 'package:flutter/material.dart';
import 'package:suitmedia_test_flutter_dev/helper/color_helper.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;

  const PrimaryButton({Key? key, required this.text, required this.fontSize, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
      style: ElevatedButton.styleFrom(
          primary: ColorHelper.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
