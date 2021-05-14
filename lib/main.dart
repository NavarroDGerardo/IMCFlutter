import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCStateful(),
    );
  }
}

class IMCStateful extends StatefulWidget{
  @override
  IMCState createState() => IMCState();

}

class IMCState extends State<IMCStateful>{
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();

  GlobalKey<FormState> formEstado = GlobalKey<FormState>();
  String mensaje = "Bienvenido!!";

  void reiniciar(){
    peso.text = "";
    altura.text = "";
    setState(() {
      mensaje = "Calcula tu IMC !!";
    });
  }

  void calculaImc(){
    setState(() {
      double peso_d = double.parse(peso.text);
      double altura_d = double.parse(altura.text);
      double imc = peso_d / (altura_d * altura_d);
      if(imc < 18.5){
        mensaje = "Peso Bajo (tu IMC = ${imc.toStringAsPrecision(2)})";
      }else if(imc >= 18.6 && imc <24.9){
        mensaje = "Peso normal (tu IMC = ${imc.toStringAsPrecision(2)})";
      }else if(imc >= 24.9 && imc <29.9){
        mensaje = "sobrepeso (tu IMC = ${imc.toStringAsPrecision(2)})";
      }else if(imc >= 29.9 && imc <34.9){
        mensaje = "Obesidad tipo 1 (tu IMC = ${imc.toStringAsPrecision(2)})";
      }else if(imc >= 35 && imc <39.9){
        mensaje = "Obesidad tipo 2 (tu IMC = ${imc.toStringAsPrecision(2)})";
      }else{
        mensaje = "Obesidad tipo 3 (tu IMC = ${imc.toStringAsPrecision(2)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC APP:"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reiniciar,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formEstado,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
              ),
              Icon(Icons.account_circle_outlined, size: 100.0, color: Colors.deepPurpleAccent,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso: ",
                  labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 30)
                ),
                textAlign: TextAlign.center,
                controller: peso,
                validator: (value){
                  if(value.isEmpty){
                    return "Peso vacio";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura: ",
                    labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 30)
                ),
                textAlign: TextAlign.center,
                controller: altura,
                validator: (value){
                  if(value.isEmpty){
                    return "altura vacia";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formEstado.currentState.validate()) {
                        calculaImc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}