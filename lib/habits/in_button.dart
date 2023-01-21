import 'package:flutter/material.dart';

class InButton extends StatelessWidget {
  const InButton({Key? key, this.icon, this.text}) : super(key: key);

  final Icon? icon;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: text ?? icon,
    );
  }
}
