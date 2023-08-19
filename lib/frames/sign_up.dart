import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/components/textfield.dart';
import 'package:technical_test_consware/frames/login.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

late bool isChecked;

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
    isChecked = false;
  }

  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List inputTexts = [
      "Nombre completo",
      "Escribe tu nombre",
      "Identificación",
      "Escribe tu número de identificación",
      "Email",
      "Uname@mail.com",
      "Contraseña",
      "Password"
    ];
    
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Scaffold(
            body: Stack(children: [
          background(),
          header("Banca créditos"),
          title("Regístrate", "solo te tomara unos minutos"),
          inputs(inputTexts),
          buttons("Continuar")
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
        bottom: percentage(height, 81),
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
      bottom: percentage(height, 74),
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25)),
            TextSpan(text: text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      )
    );
  }

  Positioned inputs(List text) {
    return Positioned(
        width: percentage(width, 80),
        left: percentage(width, 10),
        bottom: percentage(height, 18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            //name
            text[0],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
            color: AppColor.purple,
            text: text[1],
            controller: nameController,
            border: true,
            user: true,
          ),
          const SizedBox(height: 13),
          Text(
            //id
            text[2],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
              color: AppColor.purple,
              text: text[3],
              controller: idController,
              border: true),
          const SizedBox(height: 13),
          Text(
            //email
            text[4],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
            color: AppColor.purple,
            text: text[5],
            controller: emailController,
            border: true,
            user: true,
          ),
          const SizedBox(height: 13),
          Text(
            //password
            text[6],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
            color: AppColor.purple,
            text: text[7],
            controller: passwordController,
            border: true,
            password: true,
          ),
          const SizedBox(height: 13),
        ]));
  }

  Positioned buttons(String registerText) {
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      bottom: percentage(height, 3),
      child: Column(
      children: [
          Row(
            children: [
              Checkbox(
              value: isChecked,
                onChanged: (newBool) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                }
              ),
              Flexible(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Product-sans',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Acepto los ",
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: "Términos ", 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: "y ", 
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: "Condiciones ", 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: "y la ", 
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: "Política de privacidad ", 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: "de Banca créditos", 
                        style: TextStyle(color: AppColor.blackFont)),
                    ],
                  ),
                )
              )
            ]
          ),
          const SizedBox(height: 5),
          LargeRectangularButton(//register
            fontFamily: 'Product-sans',
            width: percentage(width, 80),
            borderRadius: 10,
            backgroundColor: AppColor.purple,
            textColor: Colors.white,
            text: "Continuar",
            onTap: () => onPressed(0)
          ),
          const SizedBox(height: 5),
          Row(//Login
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿Ya tienes una cuenta?",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Product-sans',
                  color: AppColor.blackFont,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none
                ),
              ),
              const SizedBox(width: 5),
              TextOnlyButton(
                text: "Inicia sesión",
                fontSize: 14,
                color: AppColor.purple,
                onTap: () => onPressed(1),
                fontFamily: 'Product-sans',
              )
            ],
          )
        ]
      )
    );
  }

  void onPressed(int option) {
    if (option == 0) {//register
      print('register, checkmark: $isChecked');
    } else{//login
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft, 
          child: const Login(),
          childCurrent: const SignUp()
        )
      );
    }
  }
}
