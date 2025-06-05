import 'package:flutter/material.dart';

Widget buildWeatherInfo({
  required IconData icon,
  required Color color,
  required String label,
  required String value,
  required double iconSize,
  required double fontSize,
}) {
  return Row(
    children: [
      Icon(
        icon,
        color: color,
        size: iconSize,
      ),
      SizedBox(width: fontSize),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: fontSize)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    ],
  );
}