import 'package:flutter/material.dart';

class TextFieldHome extends StatelessWidget {
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final IconData icon;
  final int id;
  final String prefixText;
  final TextEditingController controller;

  TextFieldHome({
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.labelText,
    this.icon,
    this.id = 0,
    this.prefixText,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLength: id == 2 ? 4 : null,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          labelText: labelText,
          hintText: hintText,
          prefixText: id == 1 ? prefixText : null,
          prefixIcon: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}
