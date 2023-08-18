import 'package:flutter/material.dart';

class LargeRectangularButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double borderRadius;
  final Function() onTap;
  const LargeRectangularButton({
    Key? key, 
    required this.width,
    required this.backgroundColor, 
    required this.textColor, 
    required this.text, 
    required this.borderRadius, 
    required this.onTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FloatingActionButton.extended(
        onPressed: onTap,
        backgroundColor: backgroundColor,
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold
          )
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)
        )
      ),
    );
  }
}
