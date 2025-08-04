import 'package:flutter/material.dart';

Widget buttonWidget(
  BuildContext context,
  VoidCallback onPressedCallback,
  String text,
) {
  return Expanded(
    child: ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(2),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
