import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onPressed;
  const DateTimeSelector({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.all(10)),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
