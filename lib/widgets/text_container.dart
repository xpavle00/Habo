import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer(
      {Key? key, required this.title, required this.hint, required this.label})
      : super(key: key);

  final TextEditingController title;
  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset.fromDirection(1, 3),
            color: const Color(0x21000000),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextField(
        controller: title,
        autofocus: true,
        maxLines: 1,
        maxLength: 120,
        textAlignVertical: TextAlignVertical.bottom,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(11),
          border: InputBorder.none,
          hintText: hint,
          labelText: label,
          counterText: "",
        ),
      ),
    );
  }
}
