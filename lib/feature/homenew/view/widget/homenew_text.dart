import 'package:flutter/material.dart';

class HomenewText extends StatelessWidget {
  const HomenewText({required this.text, super.key});

  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(text ?? 'aa');
  }
}
