import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconBordered extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  const IconBordered(
      {Key? key,
      required this.icon,
      required this.color,
      required this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, color: background),
        child: FaIcon(
          icon,
          color: color,
          size: 20,
        ));
  }
}
