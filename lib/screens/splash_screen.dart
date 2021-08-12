import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.wb_sunny_rounded,
      size: MediaQuery.of(context).size.width * 0.785,
    );
  }
}
