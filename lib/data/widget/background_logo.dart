import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LogoApplication extends StatefulWidget {
  @override
  _LogoApplicationState createState() => _LogoApplicationState();
}

class _LogoApplicationState extends State<LogoApplication> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 524,
      height: 280,
      child: Stack(
        children: [
          Positioned(
            left: -150,
            top: -150,
            child: backGroundBrownBall(),
          ),
          Positioned(
            left: 100,
            top: 50,
            child: Opacity(
              opacity: 0.20,
              child: backGroundLowOpacityBall(),
            ),
          ),
          Positioned(
            left: 130,
            top: 130,
            child: titleTextOfApplication(),
          ),
        ],
      ),
    );
  }
}

Text titleTextOfApplication() {
  return Text(
    'Cafe Cup',
    textAlign: TextAlign.center,
    style: GoogleFonts.pacifico(
      color: const Color(0xFF352B19),
      fontSize: 60,
      fontWeight: FontWeight.w400,
      height: 0,
    ),
  );
}

Container backGroundLowOpacityBall() {
  return Container(
    width: 200,
    height: 200,
    decoration: const ShapeDecoration(
      color: Color(0xFFB99470),
      shape: OvalBorder(),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
  );
}

Container backGroundBrownBall() {
  return Container(
    width: 360,
    height: 360,
    decoration: const ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, -1.00),
        end: Alignment(0, 1),
        colors: [Color(0xFF643303), Color(0xFFAF5523)],
      ),
      shape: OvalBorder(),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
  );
}
