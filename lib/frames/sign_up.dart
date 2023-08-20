import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/components/textfield.dart';
import 'package:technical_test_consware/frames/home.dart';
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
    List inputTexts = ["Nombre completo","Escribe tu nombre","Identificación",
      "Escribe tu número de identificación","Email","Uname@mail.com","Contraseña",
      "Password"];
    List buttonTexts=["Acepto los ","Términos ","y ","Condiciones ","y la ",
      "Política de privacidad ","de Banca créditos","Continuar",
      "¿Ya tienes una cuenta?","Inicia sesión"];

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
            header("Banca créditos"),
            title("Regístrate", "solo te tomara unos minutos"),
            inputs(inputTexts),
            buttons(buttonTexts)
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
        top: percentage(height, 9),
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
      top: percentage(height, 18),
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

  Positioned buttons(List text) {
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
                        text: text[0],
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: text[1], 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: text[2], 
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: text[3], 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: text[4], 
                        style: TextStyle(color: AppColor.blackFont)),
                      TextSpan(
                        text: text[5], 
                        style: TextStyle(color: AppColor.purple)),
                      TextSpan(
                        text: text[6], 
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
            text: text[7],
            onTap: () => onPressed(0)
          ),
          const SizedBox(height: 5),
          Row(//Login
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text[8],
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
                text: text[9],
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

  Future<void> onPressed(int option) async {
    if (option == 0) {//register
      if(!isChecked){
        alertPopUp(context, 'Error!', 'Debe marcar la casilla de Términos y Condiciones para poder registrarse');
      }else{
        if(nameController.text.isEmpty||idController.text.isEmpty||
            emailController.text.isEmpty||passwordController.text.isEmpty){
          alertPopUp(context, 'Error!', 'Debe llenar todos los campos para poder registrarse');
        }
        String response=await register(nameController.text, idController.text, 
          emailController.text, passwordController.text);
        if (!context.mounted) return;//to control passing context between async process
        Navigator.pop(context);
        if(response=="successful"){
          login(emailController.text, passwordController.text, true);
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 500),
              type: PageTransitionType.bottomToTop, 
              child: const SuccessfulRegister(),
              childCurrent: const SignUp()
            ),
            (route) => false
          );
        }else if(response=="user already exist"){
          alertPopUp(context, 'Error!', 'El usuario ya existe');
        }else{
          alertPopUp(context, 'Error!', 'Error en el sistema al momento de guardar');
        }
      }
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

//------------------------------------------------------------------------------

class SuccessfulRegister extends StatefulWidget {
  const SuccessfulRegister({super.key});

  @override
  State<SuccessfulRegister> createState() => _SuccessfulRegisterState();
}

class _SuccessfulRegisterState extends State<SuccessfulRegister> {
  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          logo(),
          header("Registro exitoso"),
          title("Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante."),
          button("Continuar")
        ],
      )
    );
  }

  late final double width = getDeviceWidth(context),
    height = getDeviceHeight(context);

  Positioned background(){
    return Positioned(//shadow
      top: 0,
      child: SizedBox(
        width: width,
        height: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: AppColor.purple,
                blurRadius: 5000,
                spreadRadius: 125
              )
            ],
          ),
        ),
      )
    );
  }

  Positioned logo(){
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      top: percentage(height, 15),
      child: Image.asset(registerLogo)
    );
  }

  Positioned header(String text) {
    return Positioned(
      width: width - 10,
      left: 5,
      top: percentage(height, 47),
      child: Text(
        textAlign: TextAlign.center,
        text,
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

  Positioned title(String text) {
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      top: percentage(height, 54),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Product-sans',
          color: AppColor.blackFont,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none
        ),
      )
    );
  }  

  Positioned button(String textLogin){
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      top: percentage(height, 65),
      child: LargeRectangularButton(//login
        fontFamily: 'Product-sans',
        width: percentage(width, 80),
        borderRadius: 10,
        backgroundColor: AppColor.purple,
        textColor: Colors.white,
        text: textLogin,
        onTap: () => onPressed(0)
      )
    );
  }

  void onPressed(int option) {
    if (option == 0) {//continue to home
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.bottomToTop, 
          child: const Home(),
          childCurrent: const SuccessfulRegister()
        ),
        (route) => false
      );
    }
  }
}