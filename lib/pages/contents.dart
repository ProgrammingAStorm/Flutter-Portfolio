import "package:flutter/material.dart";
import "dart:convert";

// TODO Make text more responsive
class Contents extends StatelessWidget {
  const Contents({Key? key}) : super(key: key);

  static const int L = 50, M = 40, S = 35;

  static final contentsData = jsonDecode(
      "{\"containers\": [[{\"text\": \"Table of Contents\", \"size\": $L}],[{\"text\": \"Markup Basics\", \"size\": $M},{\"text\": \"HTML\", \"size\": $S},{\"text\": \"CSS\", \"size\": $S},{\"text\": \"Forms\", \"size\": $S}],[{\"text\": \"Programming\", \"size\": $M},{\"text\": \"Javascript\", \"size\": $S},{\"text\": \"Business Logic\", \"size\": $S},{\"text\": \"State\", \"size\": $S},{\"text\": \"Dynamic State\", \"size\": $S},{\"text\": \"Data Querying\", \"size\": $S},{\"text\": \"Data Storage\", \"size\": $S}],[{\"text\": \"Back-End I Modelling\", \"size\": $M},{\"text\": \"User-Data Models\", \"size\": $S},{\"text\": \"User-Data Access\", \"size\": $S},{\"text\": \"User-Data Manipulation\", \"size\": $S},{\"text\": \"User-Data Management\", \"size\": $S}],[{\"text\": \"Back-End II APIs & Routing\", \"size\": $M},{\"text\": \"Routing\", \"size\": $S},{\"text\": \"URL Querying\", \"size\": $S},{\"text\": \"Authentication\", \"size\": $S},{\"text\": \"API Structure\", \"size\": $S}],[{\"text\": \"Front-End I Abstractions\", \"size\": $M},{\"text\": \"Advanced Styling\", \"size\": $S},{\"text\": \"CSS Frameworks\", \"size\": $S},{\"text\": \"Frameworks / Libraries\", \"size\": $S}],[{\"text\": \"Front-End II Rendering Paradigms\", \"size\": $M},{\"text\": \"Static Site\", \"size\": $S},{\"text\": \"Multi-Page\", \"size\": $S},{\"text\": \"Single-Page\", \"size\": $S},{\"text\": \"SSR\", \"size\": $S},{\"text\": \"Jamstack\", \"size\": $S},{\"text\": \"ISR\", \"size\": $S},{\"text\": \"Islands\", \"size\": $S},{\"text\": \"Streaming SSR\", \"size\": $S},{\"text\": \"Resumability\", \"size\": $S}],[{\"text\": \"Miscellaneous\", \"size\": $M},{\"text\": \"MVP\", \"size\": $S},{\"text\": \"MVC\", \"size\": $S},{\"text\": \"SEO\", \"size\": $S},{\"text\": \"BaaS\", \"size\": $S},{\"text\": \"Saas\", \"size\": $S}]]}");

  static List<Widget> generateText() {
    List<Widget> widgets = [];

    List<RichText> createRichText(container) {
      final List<RichText> text = [];

      for (var content in container) {
        text.add(RichText(
            text: TextSpan(
                text: content["text"] as String,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: content["size"] as double))));
      }

      return text;
    }

    for (var container in contentsData['containers']) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: createRichText(container),
          ),
        ),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: generateText()),
    );
  }
}
