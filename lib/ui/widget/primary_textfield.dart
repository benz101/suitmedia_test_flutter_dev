import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test_flutter_dev/helper/color_helper.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Function(String) onChanged;
  const PrimaryTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: textEditingController,
      placeholder: hintText,
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
    );
  }
}
