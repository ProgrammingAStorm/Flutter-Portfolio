import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
                color: Colors.deepPurpleAccent.shade100, fontSize: 40),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
                "Thank you for visiting my portfolio! I hope you enjoy the background effect that I have created. It was very fun and challenging to create.",
                style: TextStyle(
                    color: Colors.deepPurpleAccent.shade100, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
                "If you would like to learn more about the effect, or if you would like to play around with some of its settings, then you can go to the Settings tab for more options. Otherwise, click on the other tabs for more information on those topics and to be navigated to the appropriate page.",
                style: TextStyle(
                    color: Colors.deepPurpleAccent.shade100, fontSize: 20)),
          ),
          Text(
              "Also, be aware that this container is scrollable, so if it apears that something has been cut off at the bottom, try and scroll down.",
              style: TextStyle(
                  color: Colors.deepPurpleAccent.shade100, fontSize: 20)),
          Padding(
            padding: const EdgeInsets.only(top: 75, left: 50, right: 50),
            child: Text("Thank you again for visiting my portfolio!",
                style: TextStyle(
                    color: Colors.deepPurpleAccent.shade100, fontSize: 40)),
          )
        ],
      ),
    );
  }
}
