import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UizardTextForm extends StatelessWidget {
  const UizardTextForm({
    required this.label,
    required this.controller,
    required this.obscure,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        style: context.general.textTheme.bodyMedium,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: context.general.textTheme.bodySmall,
        ),
      ),
    );
  }
}
