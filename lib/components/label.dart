import 'package:flutter/material.dart';

Widget TextLabel(String label, BuildContext context) {
  return FittedBox(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 30, 2),
      child: Text(
        label,
        style: TextStyle(color: Theme.of(context).primaryIconTheme.color),
      ),
    ),
  );
}