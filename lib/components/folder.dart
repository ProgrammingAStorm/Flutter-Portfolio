import 'package:flutter/material.dart';
import 'package:portfolio/components/folder_button.dart';
import 'package:portfolio/components/welcome.dart';
import 'package:portfolio/pages/contents.dart';

class Folder extends StatefulWidget {
  const Folder({super.key});

  static Widget? getStaticPages(String page, BuildContext context) {
    Map<String, Widget> pages = {
      "Welcome": Welcome(),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 1, top: 20),
        child: SizedBox(
          height: 750,
          width: 750,
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
