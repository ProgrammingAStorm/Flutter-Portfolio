import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  // TODO Allow gradient color changing
  // TODO Allow gradient mouse effect resizing
  // TODO Allow color theme changing
  // TODO Allow gradient speend changing
  // TODO Explaind gradient mouse effect with modal
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Settings',
          style: TextStyle(color: Colors.deepPurpleAccent.shade100),
        ),
        SettingsForm(setScale: setScale, setColors: setColors)
      ],
    );
  }
}

class SettingsForm extends StatefulWidget {
  const SettingsForm(
      {super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _scale = 4;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        Form.of(primaryFocus!.context!)?.save();
      },
      child: Column(
        children: [
          Column(
            children: [
              const Text(
                  "This number affects the spread of gradient as it follows the mouse. The size of the screen is divided by this number, and the result is used to calculate the gradient. This number will only affect the mouse effect."),
              TextFormField(
                decoration: const InputDecoration(hintText: "Scale"),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.setScale(_scale);
                      }
                    },
                    child: const Text("Submit")),
              )
            ],
          )
        ],
      ),
    );
  }
}
