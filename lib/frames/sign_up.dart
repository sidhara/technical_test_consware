import 'package:flutter/material.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            background(),
            header("Banca créditos"),
            title("Regístrate", "solo te tomara unos minutos")
          ]
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
            child: Image.asset(bgDraw2, scale: 1)
          )
        ],
      ),
    );
  }

  Positioned header(String text) {
    return Positioned(
        width: width - 10,
        left: 5,
        top: percentage(height, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(bankLogo, scale: 2.4),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none
              ),
            )
          ],
        ));
  }

  Positioned title(String textBold, String text) {
    return Positioned(
      width: width - 20,
      left: 10,
      top: percentage(height, 23),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColor.blackFont,
            fontFamily: 'Product-sans',
          ),
          children: <TextSpan>[
            TextSpan(
              text: "$textBold\n", 
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25)
            ),
            TextSpan(text: text,style: const TextStyle(fontSize: 16)),
          ],
        ),
      )
    );
  }
}