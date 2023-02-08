import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  // TODO Explaind gradient mouse effect with modal
  // TODO Put each section into a dropdown or a folddown
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Settings',
          style: TextStyle(color: Colors.deepPurpleAccent.shade100),
        ),
        ScaleForm(setScale: setScale),
        ColorChanger(setColors: setColors)
      ],
    );
  }
}

class ScaleForm extends StatefulWidget {
  const ScaleForm({super.key, required this.setScale});

  final Function setScale;

  @override
  State<ScaleForm> createState() => _ScaleFormState();
}

class _ScaleFormState extends State<ScaleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _scale = 4;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        Form.of(primaryFocus!.context!).save();
      },
      child: Column(
        children: [
          const Text(
              "This number affects the spread of gradient as it follows the mouse. The size of the screen is divided by this number, and the result is used to calculate the gradient. This number will only affect the mouse effect. The default is 1."),
          TextFormField(
            decoration: const InputDecoration(hintText: "Scale"),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\.]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number.';
              }
              return null;
            },
            onSaved: (newValue) {
              _scale = double.parse(newValue!);
            },
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.setScale(_scale);
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text("Submit")),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      onPressed: () {
                        widget.setScale(1);
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Reset")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ColorChanger extends StatefulWidget {
  const ColorChanger({super.key, required this.setColors});

  final Function setColors;

  @override
  State<ColorChanger> createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  List<Color> _stagedColors = [];
  Color _pickedColor = Colors.deepPurple;

  void clearColors() {
    setState(() {
      _stagedColors = [];
    });
  }

  List<Widget> getColoredBoxes(List<Color> colors) {
    final List<Widget> boxes = [];

    for (var color in colors) {
      boxes.add(Container(
        width: 25,
        height: 25,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        color: color,
      ));
    }

    return boxes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: getColoredBoxes(_stagedColors),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  onPressed: () => setState(() {
                                        _stagedColors.add(_pickedColor);
                                      }),
                                  child: const Text("Add"))
                            ],
                            backgroundColor: Colors.deepPurpleAccent,
                            contentPadding: const EdgeInsets.all(5),
                            content: SingleChildScrollView(
                              child: Container(
                                color: Colors.deepPurple,
                                child: ColorPicker(
                                  onColorChanged: ((value) => setState(() {
                                        _pickedColor = value;
                                      })),
                                  pickerColor: Colors.deepPurple,
                                ),
                              ),
                            ),
                          );
                        }));
                  },
                  child: const Text("Color Picker")),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: () {
                    clearColors();
                    widget.setColors([
                      Colors.indigo,
                      Colors.deepPurpleAccent,
                      Colors.pink,
                    ]);
                  },
                  child: const Text("Clear")),
            ),
            Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                    onPressed: () {
                      if (_stagedColors.length < 2) {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                      child: const Text("Got it."))
                                ],
                                backgroundColor: Colors.deepPurpleAccent,
                                contentPadding: const EdgeInsets.all(5),
                                content: SingleChildScrollView(
                                  child: Container(
                                    color: Colors.deepPurple,
                                    child: Column(
                                      children: const [
                                        Text("Caution!"),
                                        Text(
                                            "The gradient requires at least two colors.")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                      } else {
                        widget.setColors(_stagedColors);
                        clearColors();
                      }
                    },
                    child: const Text("Submit")))
          ],
        ),
      ],
    );
  }
}
