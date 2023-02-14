import 'package:flutter/material.dart';
import 'package:portfolio/pages/main_menu/components/construction.dart';
import 'package:portfolio/pages/main_menu/components/web_dev_book.dart';
import './settings.dart';
import './welcome.dart';

class Folder extends StatefulWidget {
  const Folder({super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  Widget? getStaticPages(String page, BuildContext context) {
    Map<String, Widget> pages = {
      "Welcome": const Welcome(),
      "Web Dev's Handbook": const Construction(),
      "Interactive Resume": const Construction(),
      "Projects": const Construction(),
      "Settings": Settings(
        setScale: setScale,
        setColors: setColors,
      ),
      "Credits": const Construction(),
    };

    return pages[page];
  }

  static List<Map<String, dynamic>> staticTabs = [
    {"title": "Welcome"},
    {"title": "Web Dev's Handbook"},
    {"title": "Interactive Resume"},
    {"title": "Projects"},
    {"title": "Settings"},
    {"title": "Credits"},
  ];

  static List<FolderButton> generateTabs(int selectedTab, Function setTab) {
    List<FolderButton> newTabs = [];

    for (int x = 0; x < staticTabs.length; x++) {
      bool selected;

      if (selectedTab == x) {
        selected = true;
      } else {
        selected = false;
      }

      newTabs.add(FolderButton(
          title: staticTabs[x]["title"],
          count: x,
          selected: selected,
          setTab: setTab));
    }

    return newTabs;
  }

  @override
  State<Folder> createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  int _selectedTab = 0;

  void _setTab(int count) {
    setState(() {
      _selectedTab = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Wrap(
          verticalDirection: VerticalDirection.up,
          children: Folder.generateTabs(_selectedTab, _setTab)),
      Container(
        padding: const EdgeInsets.all(5),
        //margin: const EdgeInsets.only(bottom: 200, left: 250, right: 250),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.deepPurpleAccent.shade700,
                  blurRadius: 2,
                  offset: Offset.fromDirection(0))
            ]),
        child: Container(
            padding: const EdgeInsets.all(5),
            width: 1000,
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: widget.getStaticPages(
                Folder.staticTabs[_selectedTab]['title'], context)),
      )
    ]);
  }
}

class FolderButton extends StatefulWidget {
  const FolderButton(
      {super.key,
      required this.title,
      required this.count,
      this.selected = false,
      required this.setTab});

  final String title;
  final int count;
  final bool selected;
  final Function setTab;

  static Color getBackground(bool selected) {
    if (selected) {
      return Colors.deepPurpleAccent;
    }

    return Colors.deepPurple;
  }

  @override
  State<FolderButton> createState() => _FolderButtonState();
}

class _FolderButtonState extends State<FolderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      decoration: BoxDecoration(
          color: FolderButton.getBackground(widget.selected),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                side: BorderSide(color: Colors.deepPurple, strokeAlign: 1.0))),
        onPressed: () => {widget.setTab(widget.count)},
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
