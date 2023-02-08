import 'package:flutter/material.dart';
import 'package:portfolio/components/folder_button.dart';
import 'package:portfolio/components/settings.dart';
import 'package:portfolio/components/welcome.dart';
import 'package:portfolio/pages/contents.dart';

// TODO Make FolderButton a class in the same file
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
