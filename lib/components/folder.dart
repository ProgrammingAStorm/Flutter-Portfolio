import 'package:flutter/material.dart';
import 'package:portfolio/components/settings.dart';
import 'package:portfolio/components/welcome.dart';
import 'package:portfolio/pages/contents.dart';

class Folder extends StatefulWidget {
  const Folder({super.key, required this.setScale, required this.setColors});

  final Function setScale;
  final Function setColors;

  Widget? getStaticPages(String page, BuildContext context) {
    Map<String, Widget> pages = {
      "Welcome": const Welcome(),
      "Web Dev's Handbook": Column(
        children: [
          Text(
            "Web Dev's Handbook",
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          ),
          TextButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contents()))
                  },
              child: const Text("Go"))
        ],
      ),
      "Interactive Resume": Column(
        children: [
          Text(
            'Interactive Resume',
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          )
        ],
      ),
      "Projects": const Text("Projects"),
      "Settings": Settings(
        setScale: setScale,
        setColors: setColors,
      ),
      "Credits": Column(
        children: [
          Text(
            'Credits',
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          )
        ],
      ),
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
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        Wrap(
            verticalDirection: VerticalDirection.up,
            children: Folder.generateTabs(_selectedTab, _setTab)),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Container(
              width: 750,
              decoration: const BoxDecoration(color: Colors.deepPurple),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.getStaticPages(
                    Folder.staticTabs[_selectedTab]['title'], context),
              )),
        )
      ]),
    );
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
          style: TextStyle(
              color: Colors.deepPurpleAccent.shade100,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
