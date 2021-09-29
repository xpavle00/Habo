import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({Key key, this.title, this.hint, this.label})
      : super(key: key);

  final TextEditingController title;
  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: TextField(
          controller: title,
          autofocus: true,
          maxLines: 1,
          maxLength: 120,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(11),
            border: InputBorder.none,
            hintText: hint,
            labelText: label,
            counterText: "",
          ),
        ),
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryVariant,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: Offset.fromDirection(1, 3),
                color: Color(0x21000000))
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
