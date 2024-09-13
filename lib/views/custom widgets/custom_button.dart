import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    required this.text, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
