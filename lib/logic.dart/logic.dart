import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:technical_test_consware/components/splash_screen.dart';
import 'package:technical_test_consware/frames/presentation.dart';

const String splash1 = 'assets/splash1.png', splash2 = 'assets/splash2.png', 
  primitiveSlothLogoDark='assets/Primitive_Sloth_Software_Logo_Dark.png',
  conswareLogo='assets/consware-logo.png',bgDraw1='assets/bg-draw-r.png',
  bankLogo='assets/logo.png',bgDraw2='assets/bg-draw-l.png',
  bgDraw3='assets/bg-draw-c.png',googleLogo='assets/google-logo.png',
  appleLogo='assets/apple-logo.png';

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double percentage(double input, double percentage) {
  return (input / 100) * percentage;
}

void controlDeviceOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

startAnimation(dynamic mounted,BuildContext context,List splashScreens)async{
  for(int i=0;i<splashScreens.length;i++){
    if(i==splashScreens.length-1){
      await passToNextSplash(
        context,
        splashScreens[i]['color'],
        splashScreens[i]['logo'],
        true
      );
    }else{
      if (!mounted) return;//this is necesary for passing building context in between async gaps
      await passToNextSplash(
        context,
        splashScreens[i]['color'],
        splashScreens[i]['logo'],
        false,
        splashScreens[i+1]['color'],
        splashScreens[i+1]['logo']
      );
    }
  }
}

Future<void> passToNextSplash(
  BuildContext context,
  Color colorCurrentSplash,
  String imgRouteCurrentSplash,
    [
      bool finalSplash=false,
      Color colorNextSplash=Colors.red,
      String imgRouteNextSplash='',
    ]
)async{
  await Future.delayed(
    const Duration(seconds: 4),
    (){
      if(finalSplash==true){
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            duration: const Duration(seconds: 1),
            type: PageTransitionType.fade, 
            child: const Presentation(),//isLoggedIn()?const Home():const Login(),
            childCurrent: Splash(color: colorCurrentSplash,imgRoute: imgRouteCurrentSplash)
          ),
          (route) => false
        );
      }else{
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(seconds: 1),
            type: PageTransitionType.fade, 
            child: Splash(
              color: colorNextSplash,
              imgRoute: imgRouteNextSplash,
            ),
            childCurrent: Splash(
              color: colorCurrentSplash,
              imgRoute: imgRouteCurrentSplash
            )
          )
        );
      }
    }
  );   
}

bool isLoggedIn(){
  //in development
  return true;
}