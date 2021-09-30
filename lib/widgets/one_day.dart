import 'package:flutter/material.dart';

class OneDay extends StatelessWidget {
  const OneDay({Key key, this.date, this.color, this.child}) : super(key: key);

  final DateTime date;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(15.0),
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          child: this.child != null
              ? this.child
              : Center(
                  child: Text(
                    this.date.day.toString(),
                  ),
                ),
        ),
      ),
    );
  }
}
