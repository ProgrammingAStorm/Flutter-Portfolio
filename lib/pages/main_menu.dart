import 'package:flutter/material.dart';
import 'package:portfolio/components/folder.dart';
import 'package:portfolio/pages/contents.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        // TODO Set to proper colors and animate
        // TODO Have animation include some mouse interactivity
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(1, 1),
            colors: <Color>[
              Color(0xffef5350),
              Color(0x00ef5350),
            ],
          ),
        ),
        child: Center(
            child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blueGrey)),
                child: const Padding(
                    padding: EdgeInsets.all(15.0), child: Folder()))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Contents()))
        },
      ),
    );
  }
}
