import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habo/constants.dart';

class ColorIcon extends StatefulWidget {
  const ColorIcon(
      {super.key,
      required this.color,
      required this.icon,
      required this.defaultColor,
      required this.onPicked});

  final Color color;
  final IconData icon;
  final Color defaultColor;
  final Function onPicked;

  @override
  State<ColorIcon> createState() => _ColorIconState();
}

class _ColorIconState extends State<ColorIcon> {
  late Color tempColor;

  @override
  void initState() {
    super.initState();
    tempColor = widget.color.withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: tempColor,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 3,
        shadowColor: Theme.of(context).colorScheme.shadow,
        child: SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              widget.icon,
              size: 16,
            ),
            color: Colors.white,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: tempColor,
                              onColorChanged: (Color color) {
                                setState(
                                  () {
                                    tempColor = color;
                                  },
                                );
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.grey),
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        widget.defaultColor),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    tempColor = widget.defaultColor;
                                  },
                                );
                              },
                              child: const Text('Reset'),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        HaboColors.primary),
                              ),
                              child: const Text('Done'),
                              onPressed: () {
                                widget.onPicked(tempColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
