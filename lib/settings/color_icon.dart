import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';

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
    tempColor = widget.color.withValues(alpha: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: tempColor,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2,
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
                                    tempColor = color.withValues(alpha: 1.0);
                                  },
                                );
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                foregroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        Colors.grey),
                              ),
                              child: Text(S.of(context).cancel),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                foregroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(
                                        widget.defaultColor),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    tempColor = widget.defaultColor;
                                  },
                                );
                              },
                              child: Text(S.of(context).reset),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                foregroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        HaboColors.primary),
                              ),
                              child: Text(S.of(context).done),
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
