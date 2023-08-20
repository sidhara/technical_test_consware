// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:technical_test_consware/components/buttons.dart';
import 'package:technical_test_consware/components/colors.dart';
import 'package:technical_test_consware/logic.dart/logic.dart';

class SimulationResults extends StatefulWidget {
  final String creditType;
  final String salary;
  final String months;

  const SimulationResults({super.key, required this.creditType, required this.salary, required this.months});

  @override
  State<SimulationResults> createState() => _SimulationResultsState();
}

class _SimulationResultsState extends State<SimulationResults> {
  late final double width = getDeviceWidth(context),
      height = getDeviceHeight(context);

  late List<List<double>> tabla;

  @override
  void initState() {
    super.initState();
    controlDeviceOrientation();
  }

  @override
  Widget build(BuildContext context) {
    double interest;
    if(widget.creditType=='Crédito de vehículo')
      interest=0.03;
    else if(widget.creditType=='Crédito de vivienda')
      interest=0.01;
    else
      interest=0.035;

    //tabla=generateTable(double.parse(widget.salary), int.parse(widget.months), interest);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: 
          Stack(
            children: [
              background(),
              bellButton(),
              header('Resultado de tu simulador de credito'),
              title('Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito'),
              subtitle('Tabla de créditos'),
              tableButton(),
              downloadButton('Descargar tabla'),
              saveButton('Guardar cotización'),
              table()
            ]
          )
        )
      )
    );
  }

  List notificationText=['Notificaciónes','Información de notificaciónes','Tabla'
    ,'Configuraciones de la tabla'];

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

  Positioned header(String text) {
    return Positioned(
      left: percentage(width, 5),
      width: percentage(width, 65),
      top: percentage(height, 10),
      child: Text(
        textAlign: TextAlign.left,
        text,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Product-sans',
          color: AppColor.purple,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none
        ),
      )
    );
  }

  Positioned title(String text) {
    return Positioned(
      left: percentage(width, 5),
      width: percentage(width, 85),
      top: percentage(height, 20),
      child: Text(
        textAlign: TextAlign.left,
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

  Positioned subtitle(String text) {
    return Positioned(
      left: percentage(width, 5),
      width: percentage(width, 85),
      top: percentage(height, 28),
      child: Text(
        textAlign: TextAlign.left,
        text,
        style: TextStyle(
          fontSize: 19,
          fontFamily: 'Product-sans',
          color: AppColor.blackFont,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none
        ),
      )
    );
  }  

  Positioned tableButton(){
    return Positioned(
      right: percentage(width, 5),
      top: percentage(height, 28),
      child: GestureDetector(
        child: const Icon(Icons.tune_sharp,size: 35),//display_settings
        onTap: () => onPressed(1),
      )
    );
  }

  Positioned table(){
    return Positioned(
      width: percentage(width, 90),
      left: percentage(width, 5),
      top: percentage(height, 35),
      child: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              children: 
                ['No. Cuota','Valor de cuota','Interés','Abono a capital','Saldo periodo','Saldo inicial'].map(
                  (cell) => Text(cell)
                ).toList()
            )
          ],
        )
      ) 
    );
  }

  Positioned downloadButton(String text){
    return Positioned(
      width: percentage(width, 90),
      left: percentage(width, 5),
      bottom: percentage(height, 10),
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

  Positioned saveButton(String text){
    return Positioned(
      width: percentage(width, 90),
      left: percentage(width, 5),
      bottom: percentage(height, 2),
      child: LargeRectangularButton(
        fontFamily: 'Product-sans',
        width: percentage(width, 80),
        borderRadius: 10,
        backgroundColor: Colors.white,
        textColor: AppColor.purple,
        text: text,
        onTap: () => onPressed(3)
      )
    );
  }  

  void onPressed(int option) {
    if (option == 0) {//notifications
      //out of scope
      alertPopUp(context, notificationText[0], notificationText[1]);
    }else if (option == 1){//table settings
      //out of scope
      alertPopUp(context, notificationText[2], notificationText[3]);
    }else if (option == 2){//download table
      print(tabla);
    }else{//save table

    }
  }
}