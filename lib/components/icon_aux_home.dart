import 'package:flutter/material.dart';

class IconAuxHome extends StatelessWidget {
  final IconData icon;
  final Function function;
  final Color color;

  IconAuxHome({
    @required this.icon,
    @required this.function,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: function,
    );
  }
}
