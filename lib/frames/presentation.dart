import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/components/splash_screen.dart';
import 'package:technical_test_consware/frames/login.dart';
import 'package:technical_test_consware/frames/sign_up.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class Branding extends StatefulWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  State<Branding> createState() => _BrandingState();
}

class _BrandingState extends State<Branding> {

  late List splashScreens=[];
  
  @override
  void initState(){
    super.initState();
    splashScreens=[
      {'color': Colors.white, 'logo': conswareLogo},
      {'color': AppColor.purple, 'logo': primitiveSlothLogoDark}
    ];
    controlDeviceOrientation();
    startAnimation(mounted,context,splashScreens);
  }

  @override
  Widget build(BuildContext context) {
    return Splash(
      color: splashScreens[0]['color'],
      imgRoute: splashScreens[0]['logo']
    );
  }
}

class Presentation extends StatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  late List onboardingScreens = [];
  late double width, height;

  @override
  void initState() {
    super.initState();
    onboardingScreens = [
      {
        'text': "Accede a créditos\ncon un solo toque y sin\ncomplicaciones.",
        'background': splash1
      },
      {
        'text':
            "Toma el control de tus\nfinanzas con confianza y\naccede a ellas sin\nrestricciones.",
        'background': splash2
      }
    ];
    controlDeviceOrientation();
  }

  @override
  Widget build(BuildContext context) {
    width = getDeviceWidth(context);
    height = getDeviceHeight(context);
    return Scaffold(
        body: Stack(children: [
      slider(),
      protectiveScreen(),
      loginButton("Ingresar"),
      registerButton("Registrarme")
    ]));
  }

  Positioned slider() {
    return Positioned(
        child: CarouselSlider.builder(
      disableGesture: true,
      itemCount: onboardingScreens.length,
      options: CarouselOptions(
        height: height,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlay: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return OnboardingSplash(
            text: onboardingScreens[index]['text'],
            imgRoute: onboardingScreens[index]['background']);
      },
    ));
  }

  Container protectiveScreen() {
    return Container(width: width, height: height, color: Colors.transparent);
  }

  Positioned loginButton(String text) {
    return Positioned(
      left: 10,
      bottom: percentage(height, 11),
      child: LargeRectangularButton(
        fontFamily: 'Product-sans',
        width: width - 20,
        backgroundColor: Colors.white,
        textColor: AppColor.blackFont,
        text: text,
        borderRadius: 10,
        onTap: () => onPressed(0)
      )
    );
  }

  Positioned registerButton(String text) {
    return Positioned(
      left: 10,
      bottom: percentage(height, 4),
      child: LargeRectangularButton(
        fontFamily: 'Product-sans',
        width: width - 20,
        backgroundColor: AppColor.purple,
        textColor: Colors.white,
        text: text,
        borderRadius: 10,
        onTap: () => onPressed(1)
      )
    );
  }

  void onPressed(int option) {
    if (option == 0) {//login
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.bottomToTop, 
          child: const Login(),
          childCurrent: const Presentation()
        )
      );
    } else {//register
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.bottomToTop, 
          child: const SignUp(),
          childCurrent: const Presentation()
        )
      );
    }
  }
}
