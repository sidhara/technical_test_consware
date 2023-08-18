import 'package:flutter/material.dart';
import 'package:technical_test_consware/components/animated_switch.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/components/textfield.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

late bool rememberPassword;

class _LoginState extends State<Login> {
  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
    rememberPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Scaffold(
            body: Stack(children: [
          background(),
          header("Banca créditos"),
          title("Inicia sesión o continua,"," solo te tomara unos minutos"),
          loginInputs("Email o Usuario","Contraseña","Recordarme","¿Olvide mi contraseña?"),
          loginButtons("Iniciar sesión","Ingresa con Google","Ingresa con Apple","¿no tienes cuenta?","Registrate")
        ])));
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
                  decoration: TextDecoration.none),
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
            fontSize: 23,
            color: AppColor.blackFont,
            fontFamily: 'Product-sans',
          ),
          children: <TextSpan>[
            TextSpan(
              text: textBold, 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            TextSpan(text: text),
          ],
        ),
      )
    );
  }

  Positioned loginInputs(String textEmail,String textPassword,String textRemember,String textForgot) {
    return Positioned(
        width: percentage(width, 80),
        left: percentage(width, 10),
        top: percentage(height, 40),
        child: Column(
          children: [
            TextFieldCustom(//email
              color: AppColor.purple,
              text: textEmail,
              controller: emailController,
              border: true,
              user: true,
            ),
            const SizedBox(height: 20),
            TextFieldCustom(//password
              color: AppColor.purple,
              password: true,
              controller: passwordController,
              text: textPassword,
              border: true,
            ),
            const SizedBox(height: 20),
            Row(//row of remember login and forgot password
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(//remember login
                    children: [
                  const AnimatedSwitch(),
                  const SizedBox(width: 10),
                  Text(
                    textRemember,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.blackFont),
                  )
                ]),
                TextOnlyButton(//forgot your password
                  text: textForgot,
                  fontSize: 14,
                  color: AppColor.purple,
                  onTap: () => onPressed(1),
                  fontFamily: 'Product-sans',
                )
              ],
            )
          ],
        ));
  }

  Positioned loginButtons(String textLogin,String textLoginGoogle,String textLoginApple,String textRegister,String textSignUp) {
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      top: percentage(height, 65),
      child: Column(
        children: [
          LargeRectangularButton(//login
            fontFamily: 'Product-sans',
            width: percentage(width, 80),
            borderRadius: 10,
            backgroundColor: AppColor.purple,
            textColor: Colors.white,
            text: textLogin,
            onTap: () => onPressed(0)
          ),
          const SizedBox(height: 15),
          Image.asset(bgDraw3, width: width),
          const SizedBox(height: 15),
          LargeRectangularButton(//login Google
            iconImg: googleLogo,
            fontFamily: 'Product-sans',
            width: percentage(width, 80),
            borderRadius: 10,
            backgroundColor: Colors.white,
            textColor: AppColor.blackFont,
            text: textLoginGoogle,
            onTap: () => onPressed(2)
          ),
          const SizedBox(height: 15),
          LargeRectangularButton(//login Apple
            iconImg: appleLogo,
            fontFamily: 'Product-sans',
            width: percentage(width, 80),
            borderRadius: 10,
            backgroundColor: Colors.white,
            textColor: AppColor.blackFont,
            text: textLoginApple,
            onTap: () => onPressed(3)
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textRegister,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Product-sans',
                    color: AppColor.blackFont,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(width: 5),
              TextOnlyButton(//Register
                text: textSignUp,
                fontSize: 14,
                color: AppColor.purple,
                onTap: () => onPressed(4),
                fontFamily: 'Product-sans',
              )
            ],
          )
        ],
      )
    );
  }

  void onPressed(int option) {
    if (option == 0) {//login
      print('login, remember=$rememberPassword');
    } else if (option == 1) {//forgot password
      print('forgot password');
    } else if (option == 2) {//login google
      print('login google');
    } else if (option == 3) {//login apple
      print('login apple');
    } else {//sign up
      print('sign up');
    }
  }
}
