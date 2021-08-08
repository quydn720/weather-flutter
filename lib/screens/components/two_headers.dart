import 'package:flutter/material.dart';

class TwoHeaders extends StatelessWidget {
  const TwoHeaders({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        ),
        Text(
          subtitle,
        ),
      ],
    );
  }
}
