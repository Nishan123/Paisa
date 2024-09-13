import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String icon;
  const GoogleButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.black),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
