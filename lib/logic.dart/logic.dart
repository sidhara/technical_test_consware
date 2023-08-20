// ignore_for_file: curly_braces_in_flow_control_structures
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:technical_test_consware/components/splash_screen.dart';
import 'package:technical_test_consware/frames/presentation.dart';
import 'dart:math';

const String splash1 = 'assets/splash1.png', splash2 = 'assets/splash2.png', 
  primitiveSlothLogoDark='assets/Primitive_Sloth_Software_Logo_Dark.png',
  conswareLogo='assets/consware-logo.png',bgDraw1='assets/bg-draw-r.png',
  bankLogo='assets/logo.png',bgDraw2='assets/bg-draw-l.png',
  bgDraw3='assets/bg-draw-c.png',googleLogo='assets/google-logo.png',
  appleLogo='assets/apple-logo.png',registerLogo='assets/register-logo.png',
  handLogo='assets/hand-emoji.png';

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
            child: const Presentation(),
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

Future<bool> isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? isLoggedIn = prefs.getString('isLoggedIn');
  if(isLoggedIn=='true')return true;
  else return false;
}

Future<String> register(String name,String id,String email,String password) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? users = prefs.getStringList('users');
  if(users==null || users.isEmpty){
    try {
      await prefs.setStringList('users', <String>["$name-$id-$email-$password"]);
    } catch (e) {
      return 'failed';
    }
    return 'successful';
  }else{
    bool switch1=false;
    for (var user in users) {
      if(user.contains("$email-$password")){
        switch1=true;
      }
    }
    if(!switch1) return 'user already exist';
    else {
      try {
        users.add("$name-$id-$email-$password");
        await prefs.setStringList('users', users);
      } catch (e) {
        return 'failed';
      }
      return 'successful';
    }
  }
}

Future<bool> login(String email,String password,bool rememberLogin) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? users = prefs.getStringList('users');
  if(users==null || users.isEmpty){
    return false;
  }else{
    bool switch1=false;
    for (var user in users) {
      if(user.contains("$email-$password")){
        switch1=true;
      }
    }
    if(switch1){
      try {
        await prefs.setString('currentUserEmail', email);
        await prefs.setString('currentUserPassword', password);
        if(rememberLogin)await prefs.setString('isLoggedIn', 'true');
        else await prefs.setString('isLoggedIn', 'false');
      } catch (e) {
        return false;
      }
      return true;
    }else return false;
  }
}

Future<String?> getNameLoggedUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? users = prefs.getStringList('users');
  final String? email = prefs.getString('currentUserEmail');
  for (var user in users!) {
    if(user.contains(email!)){
      final endIndex = user.indexOf('-', 0);
      return user.substring(0,endIndex);
    }
  }
  return null;
}

List<List<double>> generateTable(double salary, int months,double interestsGeneral){
  double lentAmount=(salary*7)/0.15;

  double cuotaN=1;
  double valCuota=(lentAmount*interestsGeneral)/(1-pow((1+interestsGeneral),cuotaN));
  double interests=lentAmount*interestsGeneral;
  double abono=valCuota-interests;
  double saldo=lentAmount-abono;

  List<List<double>> table = 
  [//#cuota|valCuota|interes|capital|saldo
    [cuotaN,valCuota,interests,abono,saldo],
  ];
  while(saldo>0){
    cuotaN++;
    valCuota=(lentAmount*interestsGeneral)/(1-pow((1+interestsGeneral),cuotaN));
    interests=lentAmount*interestsGeneral;
    abono=valCuota-interests;
    saldo=lentAmount-abono;
    table.add([cuotaN,valCuota,interests,abono,saldo]);
  }
  return table;
}

Future<String>createExcel(String name)async{
  final Workbook workbook=Workbook();
  //write
  final Worksheet sheet=workbook.worksheets[0];
  sheet.getRangeByName('A1').setText('to write');
  //save file to download
  final List<int>bytes=workbook.saveAsStream();
  workbook.dispose();
  final String path=(await getApplicationSupportDirectory()).path;
  final String fileName='$path/$name.xlsx';
  final File file=File(fileName);
  await file.writeAsBytes(bytes,flush: true);
  //OpenFile.open(fileName);
  return fileName;
}

void alertPopUp(BuildContext context,String title,String content){
  AlertDialog alert= AlertDialog(
    title: Text(title),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text(content),
        ],
      ),
    )
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}