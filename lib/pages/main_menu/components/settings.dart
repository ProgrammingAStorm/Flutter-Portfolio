import 'package:dart_code_viewer2/dart_code_viewer2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// TODO Allow speed of animation selection
// TODO Allw different effect types
class Settings extends StatefulWidget {
  const Settings(
      {super.key,
      required this.setScale,
      required this.setColors,
      required this.setTween});

  final Function setScale;
  final Function setColors;
  final Function setTween;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<bool> _isOpen = [false, false, false, false];

  // TODO Explaind gradient mouse effect with modal
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
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
                    'Tween',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            body: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(color: Colors.deepPurpleAccent, width: 3),
              ),
              child: TweenForm(
                setTween: widget.setTween,
              ),
            )),
        ExpansionPanel(
            backgroundColor: Colors.deepPurpleAccent,
            canTapOnHeader: true,
            isExpanded: _isOpen[1],
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
                  border: Border.all(color: Colors.deepPurpleAccent, width: 3),
                ),
                child: ScaleForm(setScale: widget.setScale))),
        ExpansionPanel(
            backgroundColor: Colors.deepPurpleAccent,
            canTapOnHeader: true,
            isExpanded: _isOpen[2],
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
                    border:
                        Border.all(color: Colors.deepPurpleAccent, width: 3)),
                child: ColorChanger(setColors: widget.setColors))),
        ExpansionPanel(
            backgroundColor: Colors.deepPurpleAccent,
            canTapOnHeader: true,
            isExpanded: _isOpen[3],
            headerBuilder: (context, isOpen) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: const Center(
                  child: Text(
                    'Explanation',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            body: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    border:
                        Border.all(color: Colors.deepPurpleAccent, width: 3)),
                child: const Explanation())),
      ],
    );
  }
}

class TweenForm extends StatefulWidget {
  const TweenForm({super.key, required this.setTween});

  final Function setTween;

  @override
  State<TweenForm> createState() => _TweenFormState();
}

class _TweenFormState extends State<TweenForm> {
  static const List<String> entries = <String>["Mouse", "Daily"];

  String dropdownValue = entries.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropdownValue,
        dropdownColor: Colors.deepPurpleAccent,
        items: entries.map<DropdownMenuItem<String>>((entry) {
          return DropdownMenuItem<String>(
              value: entry,
              child: Text(
                entry,
                style: Theme.of(context).textTheme.displaySmall,
              ));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });

          widget.setTween(value);
        });
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
          Text(
            "This number affects the spread of gradient as it follows the mouse. The size of the screen is divided by this number, and the result is used to calculate the gradient. This number will only affect the mouse effect. The default is 1.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Scale"),
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.bodyMedium,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\.]')),
            ],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number.';
              }

              try {
                double.parse(value);
              } catch (e) {
                return 'Please enter a proper number.';
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
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.setScale(_scale);
                          _formKey.currentState!.reset();
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                  color: Colors.deepPurple, strokeAlign: 1.0))),
                      child: Text(
                        "Submit",
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ElevatedButton(
                      onPressed: () {
                        widget.setScale(1);
                        _formKey.currentState!.reset();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                  color: Colors.deepPurple, strokeAlign: 1.0))),
                      child: Text("Reset",
                          style: Theme.of(context).textTheme.bodySmall)),
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
        Text(
          "Here you can use this color picked to select which colors you would like to use for the effect. The effect requires that at least two colors be selected.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
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
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            actions: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: ElevatedButton(
                                    onPressed: () => setState(() {
                                          _stagedColors.add(_pickedColor);
                                        }),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            side: BorderSide(
                                                color: Colors.deepPurple,
                                                strokeAlign: 1.0))),
                                    child: Text(
                                      "Add",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                              )
                            ],
                            backgroundColor: Colors.deepPurpleAccent,
                            contentPadding: const EdgeInsets.all(5),
                            content: SingleChildScrollView(
                              child: Container(
                                color: Colors.deepPurple,
                                padding: const EdgeInsets.all(15),
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
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(
                              color: Colors.deepPurple, strokeAlign: 1.0))),
                  child: Text(
                    "Color Picker",
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ElevatedButton(
                  onPressed: () {
                    clearColors();
                    widget.setColors([
                      Colors.indigo,
                      Colors.deepPurpleAccent,
                      Colors.pink,
                    ]);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(
                              color: Colors.deepPurple, strokeAlign: 1.0))),
                  child: Text(
                    "Clear",
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
            ),
            Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: ElevatedButton(
                    onPressed: () {
                      if (_stagedColors.length < 2) {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                actions: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                side: BorderSide(
                                                    color: Colors.deepPurple,
                                                    strokeAlign: 1.0))),
                                        child: Text(
                                          "Got it.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )),
                                  )
                                ],
                                backgroundColor: Colors.deepPurpleAccent,
                                contentPadding: const EdgeInsets.all(5),
                                content: SingleChildScrollView(
                                  child: Container(
                                    color: Colors.deepPurple,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Caution!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          "The gradient requires at least two colors.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
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
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                                color: Colors.deepPurple, strokeAlign: 1.0))),
                    child: Text("Submit",
                        style: Theme.of(context).textTheme.bodySmall)))
          ],
        ),
      ],
    );
  }
}

// TODO Add line numbers
// TODO Cite line numbers
// TODO Couple the data with the UI in a cleaner manner here. See if can upload a list of text and settings to generate all of this dynamically, rather than hard coding everything.
class Explanation extends StatelessWidget {
  const Explanation({super.key});

  static const TextStyle baseStyle = TextStyle(fontSize: 20);
  static const TextStyle punctuationStyle =
      TextStyle(fontSize: 20, color: Colors.blueAccent);
  static final TextStyle classStyle =
      TextStyle(fontSize: 20, color: Colors.blue.shade900);
  static const TextStyle keywordStyle =
      TextStyle(fontSize: 20, color: Colors.deepOrange);
  static final TextStyle numberStyle =
      TextStyle(fontSize: 20, color: Colors.deepOrangeAccent.shade700);
  static final TextStyle commentStyle =
      TextStyle(fontSize: 20, color: Colors.lightBlueAccent.shade700);
  static const TextStyle stringStyle =
      TextStyle(fontSize: 20, color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.deepPurple,
          child: Column(children: [
            Row(children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    textAlign: TextAlign.center,
                    '''
The first few things you need to understand about the effect are the widgets that compose its basic structure

First: The SizeBox is a very simple container that is just there to provide constant dimensions that match the viewport. This is achieved by using media-queiries for the height and width of the box. 

Second: The MouseRegion captures the position of the mouse within it boundaries, and passes that position to its onHover and onExit listeners.

Third: The DecoratedBoxTransition functions like a regular container with the exception that its decoration is given an decoration tween that can defines the beginning and end of an animation that involves the decoration properties (i.e. height, width, background color, etc.) The decoration tween also requires a controller to handle the animation and define the timeframe in which the animation will take place.

Make note of the functions _updateLocation, _clearLocation, and _getTween, as well as the variables _x, _y, widget.scale, and widget.colors.''',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: DartCodeViewer(
                      backgroundColor: Colors.deepPurpleAccent,
                      '''
SizedBox(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
  child: MouseRegion(
    onHover: _updateLocation,
    onExit: _clearLocation,
    child: DecoratedBoxTransition(
      decoration: _getTween(context, _x, _y, widget.scale, widget.colors)
          .animate(_animationController),
      child: Container(),
    ),
  ),
)''',
                      showCopyButton: false,
                      height: 325,
                      baseStyle: baseStyle,
                      punctuationStyle: punctuationStyle,
                      classStyle: classStyle,
                      keywordStyle: keywordStyle,
                    ),
                  ),
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
The gradient is a stateful widget, meaning that it can have mutable state that can cause the widget to re-render. The animation controller is immutable and needs to be defined before the effect can begin.
You can see that it is given a duration of 4 seconds and when it completed, and that it is to reverse and start over.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
void initState() {
  super.initState();
  _animationController =
      AnimationController(duration: const Duration(seconds: 4), vsync: this)
        ..repeat(reverse: true);
}''',
                        showCopyButton: false,
                        height: 161,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
The variables that hold on to the mouse's position are part of the gradient's state, and as such they require proper setters so that the widget can rebuild properly.
The _updateLocation and _clearLocation functions that you saw before simply update these variables; either to the mouse's current position within the MouseRegion, or to -0 when the mouse exits the MouseRegion, respectively.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
double _x = 0.0;
double _y = 0.0;

void _updateLocation(PointerEvent details) {
  setState(() {
    _x = details.position.dx;
    _y = details.position.dy;
  });
}
void _clearLocation(PointerEvent details) {
  setState(() {
    _x = -0;
    _y = -0;
  });
}''',
                        showCopyButton: false,
                        height: 346,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
The widget.scale and widget.colors variables are part of the gradient's parent's state. This is done so that the setters can be passed to other widgets so that the scale and colors can be changed externally.
The scale variable is used in the _getTween function to determine the spread of the gradient, and the colors are just the colors of the gradient.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
List<Color> _colors = const [
  Color(0xFF3F51B5),
  Color(0xFF7C4DFF),
  Color(0xFFE91E63),
];
double _scale = 1;

void _setScale(double scale) {
  setState(() {
    _scale = scale;
  });
}
void _setColors(List<Color> colors) {
  setState(() {
    _colors = colors;
  });
}''',
                        showCopyButton: false,
                        height: 391,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
Now that you have have seen all values required for the effect as well as their setters, I was hoping to explain how _getTween works. It is the function that is run every frame and is the one that actually displays the effect. The function isn't particularly difficult, but there is a lot of mathematical muddiness due to the way that the linear gradient API is implemented. So it breaks down to being less of a coding skill problem, and turns more into a flutter inner-workings issue.
All of that being said, there will have to be some breakdown of the API to really understand how the gradient is implemented and why figuring out how to implement the animation was such a challenge.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
There are a few things in particular here that you need to notice.

First: Notice that the list of colors as defined earlier are being passed into the function. The only place they are used is in the return value where you can see the DecorationTween that is being returned. The DecorationTween is simply a class that is used to to interpolate between two BoxDecorations. In layman's terms that means: It's the object that defines the two gradients that are going to transition into each other. If you remember from before that the _animationController was set with a duration of 4 seconds, with the configuration to repeat and reverse itself. The controller is given this tween to use to animate the background.

Second: Notice at the top the currently undefined Alignment variables. This is where the trouble with the API begins.
The following is a quote from the Flutter documentation concerning the Alignment class:
"Alignment(-1.0, -1.0) represents the top left of the rectangle.

Alignment(0.0, -0.5) represents a point that is horizontally centered with respect to the rectangle and vertically half way between the top edge and the center.

Alignment(x, y) in a rectangle with height h and width w describes the point (x * w/2 + w/2, y * h/2 + h/2) in the coordinate system of the rectangle."

Remember that the mouse is determined by the values _x and _y being set to -0, and that they are set to -0 when the mouse is no longer being tracked by the MouseRegion. You can see that by default the starting color starts at the top right and goes to the bottom left, then the starting color goes from top left to bottom right.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
DecorationTween _getTween(BuildContext context, double mouseX, double mouseY,
    double scale, List<Color> colors) {
  Alignment beginBegin;
  Alignment beginEnd;
  Alignment endBegin;
  Alignment endEnd;

  if (mouseX == -0 || mouseY == -0) {
    beginBegin = Alignment.topRight;
    beginEnd = Alignment.bottomLeft;
    endBegin = Alignment.topLeft;
    endEnd = Alignment.bottomRight;
  } else {
    // Calculate gradient positions
  }

  return DecorationTween(
    begin: BoxDecoration(
      gradient: LinearGradient(
        begin: beginBegin,
        end: beginEnd,
        colors: widget.colors,
      ),
    ),
    end: BoxDecoration(
      gradient: LinearGradient(
        begin: endBegin,
        end: endEnd,
        colors: widget.colors,
      ),
    ));
}''',
                        showCopyButton: false,
                        height: 759,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                        commentStyle: commentStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
This diagram shows what values will be in play for the calculation. Refer to the image as needed as I continue to descript the mechanics of the effect.
The final points A, B, C, and D, are the corners of a rectangle whose width is the width of the viewport divided by the scale variable and whose height is the height of the viewport divided by the height of the scale variable, with its center-point being the mouse's position. You can directly see the scale variable effects the gradient as you can use it to increase or decrease the size of the rectangle used to determine the alignments.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Colors.deepPurpleAccent,
                                        contentPadding: const EdgeInsets.all(5),
                                        content: SingleChildScrollView(
                                            child: Container(
                                          color: Colors.deepPurple,
                                          padding: const EdgeInsets.all(15),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/Diagram.png'),
                                          ),
                                        )),
                                      );
                                    });
                              },
                              child: const Image(
                                image: AssetImage('assets/Diagram.png'),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.all(10),
                            child:
                                const Text("Press on the image to enlarge.")),
                      ],
                    ))
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
Notice here in the first part of the else statement of _getTween, which is executed if the mouse is being tracked by the MouseRegion, how the view's width and height are queried and then divided by scale variable to get the dimensions of the square around the mouse.
However, since the corners are only half the length and width of rectangle away from the origin, a.k.a. the mouse, we add or subtract the mouse's position by half the appropriate dimention of the rectangle.
Whether we add or subtract from the position of the mouse is determined by the direction of the corner relative to the mouse. It is important to note, however, that this is determined in terms of Alignment, not in terms of an actual coordinate plane.
For example:
Since A is in the top left, its coordinates are both subtracted from the mouse, since top left is (-1, -1), even though that up from the origin is an increase in the y-axis, not a decrease.
The same goes for B, C, and D being top right, bottom right, and bottom left, respectively.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
} else {
  final double viewWidth = MediaQuery.of(context).size.width;
  final double viewHeight = MediaQuery.of(context).size.height;

  final double rotationSquareWidth = viewWidth / scale;
  final double rotationSquareHeight = viewHeight / scale;

  final Map<String, Map<String, double>> rotationPoints = {
    'a': {
      'x': mouseX - (rotationSquareWidth / 2),
      'y': mouseY - (rotationSquareHeight / 2)
    },
    'b': {
      'x': mouseX + (rotationSquareWidth / 2),
      'y': mouseY - (rotationSquareHeight / 2)
    },
    'c': {
      'x': mouseX + (rotationSquareWidth / 2),
      'y': mouseY + (rotationSquareHeight / 2)
    },
    'd': {
      'x': mouseX - (rotationSquareWidth / 2),
      'y': mouseY + (rotationSquareHeight / 2)
    }
  };

  // TODO Convert coordinates into aligments
}''',
                        showCopyButton: false,
                        height: 759,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                        commentStyle: commentStyle,
                        stringStyle: stringStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
Consider the formula given to us by the documentation that tells us about how the API describes the alignment, where x and y are equal to Alignment(x, y), or Alignment(-1, -1) to equal top left.: 

(x * w/2 + w/2, y * h/2 + h/2)

Since we already have the points we want do describe, a.k.a. A, B, C, and D, we need to manipulate the formula to give us the alignments from the coordinates.
First: we need to change alignments from x and y to j and show how they equal the coordinates.


x = j * w/2 + w/2
y = k * h/2 + h/2

Continue to solve for j and k.

2 * x = j * w + w
2 * y = k * h + h

2 * x - w = j * w
2 * y - h = k * h

(2 * x - w) / w = j
(2 * y - h) / h = k

(2 * x - w) / w
(2 * y - h) / h

Here at the end you can see how the formula maps very directly to the code written when solving for alignment. If done for each corner in the order specified, the resulting code is exactly all the Alignments needed for the effect to operate.
The tween is then returned with said alignments and is used to paint the gradient every frame.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DartCodeViewer(
                        backgroundColor: Colors.deepPurpleAccent,
                        '''
beginBegin = Alignment(
    ((2 * rotationPoints['b']!['x']!) - viewWidth) / viewWidth,
    ((2 * rotationPoints['b']!['y']!) - viewHeight) / viewHeight);

beginEnd = Alignment(
    ((2 * rotationPoints['d']!['x']!) - viewWidth) / viewWidth,
    ((2 * rotationPoints['d']!['y']!) - viewHeight) / viewHeight);

endBegin = Alignment(
    ((2 * rotationPoints['a']!['x']!) - viewWidth) / viewWidth,
    ((2 * rotationPoints['a']!['y']!) - viewHeight) / viewHeight);

endEnd = Alignment(
    ((2 * rotationPoints['c']!['x']!) - viewWidth) / viewWidth,
    ((2 * rotationPoints['c']!['y']!) - viewHeight) / viewHeight);''',
                        showCopyButton: false,
                        height: 539,
                        baseStyle: baseStyle,
                        punctuationStyle: punctuationStyle,
                        classStyle: classStyle,
                        keywordStyle: keywordStyle,
                        numberStyle: numberStyle,
                        commentStyle: commentStyle,
                        stringStyle: stringStyle,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
              ),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.deepPurpleAccent))),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        textAlign: TextAlign.center,
                        '''
The alignments are are then returned with the DecorationTween from _getTween and are used by the controller to update the effect every frame. Keep in mind that _getTween is run every time, the colors, the scale, or the mouse position, which is tracked by the MouseRegion, are changed.
This allows the controller to always be aware of where the mouse is as long as the mouse is moving in front of the gradient. If the mouse is not tracked, the position is considered -0, and the gradient is centered. Otherwise, the gradient will always be following the mouse.''',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
              ]),
            ),
          ])),
    );
  }
}
