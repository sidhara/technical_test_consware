// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/components/textfield.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<String>name;

  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
    name=getName();
  }

  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);
  TextEditingController salaryController = TextEditingController();
  TextEditingController lendAmountController = TextEditingController();
  TextEditingController monthController = TextEditingController();
      
  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
      onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: navbar('Home', 'Historial créditos'),
        body: SingleChildScrollView(
          child: screens[index]
        )
      )
    );
  }

  List dropdownlist=['Selecciona el tipo de créditos','Crédito de Vehículo',
    'Crédito de Vivienda','Crédito de Libre Inversíon'];
  List textlist=['¿Qué tipo de créditos deseas realizar?',
    '¿Cuántos es tu salario base?','\$10´000.000,00',
    'Digíta tu salario para calcular el préstamo que necesitas','\$ 0',
    '¿A cuántos meses?','48','Elije un plazo desde 12 hasta 84 meses',
    'simular'];  

  int index=0;
  NavigationBarTheme navbar(String text1,String text2){
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        indicatorColor: Colors.transparent
      ), 
      child: NavigationBar(
        selectedIndex: index,
        height: 60,
        onDestinationSelected: (value) => setState(() =>index=value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_filled), 
            label: text1,
            selectedIcon: Icon(Icons.home_filled,color: AppColor.purple),
          ),
          NavigationDestination(
            icon: const Icon(Icons.wallet_outlined), 
            label: text2,
            selectedIcon: Icon(Icons.wallet_outlined,color: AppColor.purple),
          ),        
        ]
      )
    );
  }
  late List<Widget> screens=[
    Stack(
      children: [
        background(),
        FutureBuilder<String>(
          future: name, 
          builder: (BuildContext context, AsyncSnapshot<String>snapshot)  
          {
            if(snapshot.hasData)
              return header("Hola ${snapshot.data}");
            else
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        ),
        bellButton(),
        title("Simulador de crédito"),
        subtitle("Ingresa los datos para tu crédito según lo que necesites"),
        inputs(textlist, dropdownlist),
        simulationButton('Simular')
      ]
    ),
    Stack(
      children: [
        background(),
      ],
    )
  ];

  SizedBox background() {
    return SizedBox(
      width: width,
      height: height-60,//the 60 here is the height of the navbar
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

  Future<String> getName() async {
    String? name=await getNameLoggedUser();
    return name!;
  }
  Positioned header(String text) {
    return Positioned(
      left: percentage(width, 5),
      top: percentage(height, 8),
      child: Row(
        children: [
          Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Product-sans',
              color: AppColor.blackFont,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(handLogo, scale: 1.5),
        ],
      )
    );
  }

  Positioned title(String text) {
    return Positioned(
      left: percentage(width, 5),
      top: percentage(height, 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Product-sans',
              color: AppColor.purple,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none
            )
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => onPressed(1),
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColor.purple,
              size: 30,
            )
          )
        ],
      )
    );
  }

  Positioned subtitle(String text) {
    return Positioned(
      width: percentage(width, 90),
      left: percentage(width, 5),
      top: percentage(height, 23),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Product-sans',
          color: AppColor.blackFont,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none
        )
      ),
    );
  }

  Positioned inputs(List text,List dropdownItems) {
    return Positioned(
        width: percentage(width, 90),
        left: percentage(width, 5),
        top: percentage(height, 33),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(//credit type
            text[0],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          DropdownButtonCustom(
            items: dropdownItems,
            width: percentage(width, 90),
            border: true
          ),
          const SizedBox(height: 13),
          Text(//salary
            text[1],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none
              ),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
            numeric: true,
            color: Colors.grey,
            text: text[2],
            controller: salaryController,
            border: true,
            helperText: text[3],
            onChange: (val)=>{
              setState(() {
                double salary=double.parse(salaryController.text);
                double amountToLend=(salary*7)/0.15;
                final oCcy = NumberFormat("#,##0.00", "en_US");
                lendAmountController.text='\$ ${oCcy.format(amountToLend)}';
              })
            },
          ),
          const SizedBox(height: 13),
          TextFieldCustom(//amount available to lend
            text: text[4], 
            controller: lendAmountController, 
            color: Colors.grey,
            enabled: false,
            height: 50,
          ),
          const SizedBox(height: 13),
          Text(//months
            text[5],
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Product-sans',
                color: AppColor.blackFont,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 13),
          TextFieldCustom(
            numeric: true,
            color: Colors.grey,
            text: text[6],
            controller: monthController,
            border: true,
            helperText: text[7],
          )
        ]
      )
    );
  }

  Positioned simulationButton(String text){
    return Positioned(
      width: percentage(width, 90),
      left: percentage(width, 5),
      top: percentage(height, 83),
      child: LargeRectangularButton(
        fontFamily: 'Product-sans',
        width: percentage(width, 80),
        borderRadius: 10,
        backgroundColor: AppColor.purple,
        textColor: Colors.white,
        text: text,
        onTap: () => onPressed(2)
      )
    );
  }

  Positioned bellButton(){
    return Positioned(
      right: percentage(width, 5),
      top: percentage(height, 8),
      child: GestureDetector(
        child: const Icon(Icons.notifications_active_outlined,size: 35),
        onTap: () => onPressed(0),
      )
    );
  }

  void onPressed(int option) {
    if (option == 0) {//notifications
      //out of scope
      alertPopUp(context, 'Notificaciónes', 'Información de notificaciónes');
    }else if(option == 1){
      //out of scope
      alertPopUp(context, 'Info', 'Información de credito');
    }else{//simular
      if(monthController.text.length>2) 
        alertPopUp(context, 'Error', 'La cantidad de meses debe ser minimo 12 y maximo 84');
      else{
        int month=int.parse(monthController.text);
        if(month<12||month>84)
          alertPopUp(context, 'Error', 'La cantidad de meses debe ser minimo 12 y maximo 84');
        else if(salaryController.text.isEmpty||double.parse(salaryController.text)<=0)
          alertPopUp(context, 'Error', 'El salario base debe ser un numero valido superior a cero');
        else if(getSelectedItem()=='Selecciona el tipo de créditos')
          alertPopUp(context, 'Error', 'Escoja un tipo de crédito');
        else{
          
        }
      }
    }
  }
}