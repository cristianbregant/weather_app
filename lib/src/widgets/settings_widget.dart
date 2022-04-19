import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  final Widget child;
  const SettingsRow({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDarkMode ? Colors.grey[800] : Colors.teal[50]),
      child: child,
    );
  }
}

class SettingsHeader extends StatelessWidget {
  final String title;

  const SettingsHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Text(title.toUpperCase(), style: TextStyle(color: Colors.teal[500])),
        ],
      ),
    );
  }
}

class SettingsCategory extends StatelessWidget {
  final String title;
  final List<SettingsRow> items;

  const SettingsCategory({Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SettingsHeader(title: title),
        ...items,
      ],
    );
  }
}
