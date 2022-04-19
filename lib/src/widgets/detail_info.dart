import 'package:alpian_weather_flutter/src/widgets/icon_bordered.dart';
import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconBackground;
  final Color iconColor;
  const DetailInfo(
      {Key? key,
      required this.icon,
      required this.iconBackground,
      required this.label,
      required this.iconColor,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: const EdgeInsets.fromLTRB(4, 16, 12, 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconBordered(
              icon: icon,
              color: iconColor,
              background: iconBackground,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(
                height: 4,
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 10),
              )
            ],
          )
        ],
      ),
    );
  }
}
