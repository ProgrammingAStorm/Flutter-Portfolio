import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 33, left: 55),
      child: Container(
        alignment: Alignment.topLeft,
        width: 300,
        height: 80,
        decoration: const BoxDecoration(color: Colors.indigo),
        child: Center(
            child: Text(
          "ProgrammingAStorm",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Colors.pink),
        )),
      ),
    );
  }
}
