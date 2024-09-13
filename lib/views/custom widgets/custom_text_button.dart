import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String prefixText;
  final String buttonText;
  final VoidCallback onPressed;
  const CustomTextButton({
    super.key,
    required this.prefixText,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixText),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        )
      ],
    );
  }
}
