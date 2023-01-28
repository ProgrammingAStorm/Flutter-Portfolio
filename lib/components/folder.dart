import 'package:flutter/material.dart';
import 'package:portfolio/components/folder_button.dart';
import 'package:portfolio/pages/contents.dart';

// TODO Add some animation here too
class Folder extends StatefulWidget {
  const Folder({super.key});

  // TODO Add button to move to handbook here instead of floating button
  static Column? getStaticPages(String page, BuildContext context) {
    Map<String, Column> pages = {
      "Welcome": Column(
        children: [
          Text(
            'Welcome',
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          )
        ],
      ),
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
      "Settings": Column(
        children: [
          Text(
            'Settings',
            style: TextStyle(color: Colors.deepPurpleAccent.shade100),
          )
        ],
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
    // TODO make sure the inner contents of the folder fill out properly
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 750,
        height: 750,
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
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        width: 800,
                        decoration:
                            const BoxDecoration(color: Colors.deepPurple),
                        child: Folder.getStaticPages(
                            Folder.staticTabs[_selectedTab]["title"], context)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
