import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    super.key,
    required this.borderColor,
    required this.content,
    required this.onPressed,
  });

  final Color borderColor;
  final Function() onPressed;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: content,
          ),
        ),
      ),
    );
  }
}
