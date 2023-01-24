import 'package:flutter/material.dart';
import 'package:portfolio/components/folder_button.dart';

// TODO Add some animation here too
// TODO Add real pages
class Folder extends StatefulWidget {
  const Folder({super.key});

  static Map<String, Widget> staticPages = {
    "Settings": Column(
      children: const [
        Text(
          'Ipsum',
          //style: TextStyle(backgroundColor: Colors.white)
        )
      ],
    ),
    "Test": Column(
      children: const [
        Text(
          'Test',
          //style: TextStyle(backgroundColor: Colors.white)
        )
      ],
    ),
  };

  static List<Map<String, dynamic>> staticTabs = [
    {"title": "Settings"},
    {"title": "Test"},
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

  static clearSelected() {}

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
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade300,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blueGrey)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Row(
                  children: Folder.generateTabs(_selectedTab, _setTab),
                ),
              ),
            ),
            Flexible(
              flex: 15,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade400,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      width: 800,
                      decoration: const BoxDecoration(color: Colors.blueGrey),
                      child: Folder.staticPages[Folder.staticTabs[_selectedTab]
                          ["title"]]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
