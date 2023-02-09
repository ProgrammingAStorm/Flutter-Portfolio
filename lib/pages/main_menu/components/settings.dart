import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<bool> _isOpen = [false, false];

  // TODO Explaind gradient mouse effect with modal
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 10),
          child: Text(
            'Settings',
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          ),
        ),
        ExpansionPanelList(
          expansionCallback: (i, isOpen) {
            setState(() {
              _isOpen[i] = !isOpen;
            });
          },
          children: [
            ExpansionPanel(
                backgroundColor: Colors.deepPurpleAccent,
                canTapOnHeader: true,
                isExpanded: _isOpen[0],
                headerBuilder: (context, isOpen) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    child: const Center(
                      child: Text(
                        'Scale',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                body: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        border: Border.all(
                            color: Colors.deepPurpleAccent, width: 3)),
                    child: ScaleForm(setScale: widget.setScale))),
            ExpansionPanel(
                backgroundColor: Colors.deepPurpleAccent,
                canTapOnHeader: true,
                isExpanded: _isOpen[1],
                headerBuilder: (context, isOpen) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: const Center(
                      child: Text(
                        'Color',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                body: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        border: Border.all(
                            color: Colors.deepPurpleAccent, width: 3)),
                    child: ColorChanger(setColors: widget.setColors)))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      backgroundColor: Colors.deepPurpleAccent,
                      content: SingleChildScrollView(
                          child: Container(
                        //padding: const EdgeInsets.all(5),
                        color: Colors.deepPurple,
                        child: Text("nigger"),
                      )),
                    );
                  })),
              child: const Text("Explanation")),
        )
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
        const Text(
            "Here you can use this color picked to select which colors you would like to use for the effect. The effect requires that at least two colors be selected."),
        Container(
          margin: const EdgeInsets.all(5),
          child: Wrap(
            children: getColoredBoxes(_stagedColors),
          ),
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
