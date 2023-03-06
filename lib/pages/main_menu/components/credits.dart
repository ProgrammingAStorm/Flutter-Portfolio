import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  static const List<Map<String, String>> entries = [
    {
      "name": "Flutter Responisve Framework",
      "link": "https://pub.dev/packages/responsive_framework",
    },
    {
      "name": "Flutter ScreenUtil",
      "link": "https://pub.dev/packages/flutter_screenutil",
    },
    {
      "name": "URL Launcher",
      "link": "https://pub.dev/packages/url_launcher",
    },
    {
      "name": "Dart Code Viewer V2",
      "link": "https://pub.dev/packages/dart_code_viewer2/versions",
    },
    {
      "name": "Flutter Colorpicker",
      "link": "https://pub.dev/packages/flutter_colorpicker",
    },
    {
      "name": "Firebase Hosting",
      "link": "https://firebase.google.com/",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var entry in entries)
          CreditsEntries(name: entry["name"]!, link: entry["link"]!)
      ],
    );
  }
}

class CreditsEntries extends StatelessWidget {
  const CreditsEntries({super.key, required this.name, required this.link});

  final String name;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
          TextButton(
              onPressed: () async {
                final Uri url = Uri.parse(link);

                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Text(link, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
