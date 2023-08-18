import 'package:flutter/material.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class OnboardingSplash extends StatelessWidget {
  final String text;
  final String imgRoute;
  const OnboardingSplash({Key? key, required this.text, required this.imgRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = getDeviceWidth(context),
        height = getDeviceHeight(context);
    return Stack(
      children: [
        Positioned(//bg img
          child: SizedBox(
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(imgRoute),
            )
          ),
        ),
        Positioned(//shadow
          bottom: 0,
          child: SizedBox(
            width: width,
            height: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5000,
                    spreadRadius: 270
                  )
                ],
              ),
            ),
          )
        ),
        Positioned(//text
          width: width-40,
          left: 20,
          bottom: percentage(height, 20),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 26,
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.normal, 
              decoration: TextDecoration.none
            ),
          )
        ),
      ],
    );
  }
}

class Splash extends StatelessWidget {
  final Color color;
  final String imgRoute;
  const Splash({Key? key, required this.color, required this.imgRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width=getDeviceWidth(context),
    height=getDeviceHeight(context);
    return Container(
      color: color,
      child: Stack(
        children: [
          Positioned(
            top: percentage(height, 35),
            height: percentage(height, 30),
            left: percentage(width, 15),
            width: percentage(width, 70),
            child: Image.asset(imgRoute)
          )
        ],
      )
    );
  }
}
