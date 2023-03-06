import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              '''
     Thank you for visiting my portfolio! I hope you enjoy the background effects that I created. Please do enjoy tinkering with them, and look forward to more as, even though I'm not currently working on this page, I have much more planned to come.
     
     The mouse effect was a small idea that turned out to be big, but the sunrise/sunset effect stole my heart. I managed to finish it in a fraction of the time compared to the mouse effect, since I learned a lot the first time around, but I still had to start from scratch half-way through.
     
     Currently, I'm working on my resume, but I plan to add a lot to this site. No spoilers of course. ;) In the mean time please check out my 'About Me' section if you'd like to learn more about my background. ''',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
          ),
          Column(children: [
            const Text("Check out this page's source code below:"),
            TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'https://github.com/ProgrammingAStorm/Flutter-Portfolio');

                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text(
                  'https://github.com/ProgrammingAStorm/Flutter-Portfolio',
                  style: Theme.of(context).textTheme.displaySmall,
                ))
          ]),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              "Thank you again for visiting my portfolio!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
