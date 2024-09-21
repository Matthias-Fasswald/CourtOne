// BackgroundWidget.dart
import 'package:flutter/material.dart';

//-------------BackgroundPage-Start---------------//

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover, // Deckt den gesamten Bildschirm ab
          ),
        ),
        child, //  Chil-Widget im Vordergrund
      ],
    );
  }
}

//-------------BackgroundPage-END---------------//
