import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;

  const CustomButton({super.key, 
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.fontSize = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, padding: padding, backgroundColor: color,
        textStyle: TextStyle(fontSize: fontSize),
        shape: shape,
      ),
      child: Text(text),
    );
  }
}
