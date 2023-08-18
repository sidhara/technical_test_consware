import 'package:flutter/material.dart';

class LargeRectangularButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String fontFamily;
  final String iconImg;
  final double borderRadius;
  final Function() onTap;
  const LargeRectangularButton({
    Key? key,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    this.fontFamily = 'null',
    this.iconImg='null',
    required this.borderRadius,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FloatingActionButton.extended(
          heroTag: UniqueKey(),
          onPressed: onTap,
          backgroundColor: backgroundColor,
          icon: iconImg!='null'?Image.asset(iconImg, height: 25,):null,
          label: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily != 'null' ? fontFamily : null
            )
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
    );
  }
}

class TextOnlyButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final Function() onTap;
  const TextOnlyButton(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.fontFamily = 'null',
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: fontFamily != 'null' ? fontFamily : null,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: color),
      ),
    );
  }
}
