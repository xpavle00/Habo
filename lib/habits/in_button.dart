import 'package:flutter/material.dart';

class InButton extends StatelessWidget {
  const InButton({super.key, this.icon, this.text});

  final Icon? icon;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: text ?? icon,
    );
  }
}
