import 'package:flutter/material.dart';

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
     Thank you for visiting my portfolio! I hope you enjoy the background effect that I have created. It was very fun and challenging to create.
     If you would like to learn more about the effect, or if you would like to play around with some of its settings, then you can go to the Settings tab for more options. Otherwise, click on the other tabs for more information on those topics and to be navigated to the appropriate page.
     Please forgive the lack of content as doing the whole from scratch while also learning flutter and explaining it took a lot out of me, and I have more immediately important things to work on. Such things inclue, my resume, fixing up old projects to put on my resume, a C# full-stack MVC project, in that order.
     That being said, I have much planned for the continuation of this site, and I hope you will visit again as it continues to develop.
     Thank you for your understanding, and please enjoy the site.''',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
          ),
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
