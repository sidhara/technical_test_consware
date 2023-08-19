import 'package:flutter/material.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;

  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
  }

  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);
      
  @override
  Widget build(BuildContext context) {
    getName();
    return GestureDetector(
      onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
            background(),
            header("Hola ")
            ]
          )
        )
      )
    );
  }

  SizedBox background() {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned(right: 0, top: 0, child: Image.asset(bgDraw1, scale: 1.5)),
          Positioned(
              left: 0,
              bottom: percentage(height, 5),
              child: Image.asset(bgDraw2, scale: 1))
        ],
      ),
    );
  }

  Positioned header(String text) {
    return Positioned(
      width: width - 10,
      left: 5,
      top: percentage(height, 47),
      child: Text(
        textAlign: TextAlign.center,
        text+name!,
        style: TextStyle(
          fontSize: 28,
          fontFamily: 'Product-sans',
          color: AppColor.blackFont,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none
        ),
      )
    );
  }

  Future<void> getName() async {
    name=await getNameLoggedUser();
  }
}