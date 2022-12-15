import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //para consegui pegar os valores digitados
  TextEditingController weightController = TextEditingController(); //peso
  TextEditingController heightController = TextEditingController(); //altura

  String _infoText = "Informe os seus dados!";

  //chave global para verificar se os campos foram preenchidos
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Para o botão reset
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe os seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(
          weightController.text); // para converter o texto em double
      double height = double.parse(heightController.text) /
          100; //para não dar um num estranho pq está em cm e peso em kg
      double imc = weight / (height * height);
      //print(imc);
      if (imc < 18.6) {
        _infoText =
            "Abaixo do Peso (${imc.toStringAsPrecision(2)})"; //vai colocar precisão de 4 dígitos
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  //Scaffold: serve para facilitar na hora de colocar widgets do material design
  // que necessitam da barra de navegação, ícones, tabs
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Barra de navegação
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        //SingleChildScrollView: para a tela rolar para baixo
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0,
                0.0), // para ter espaçamento na esquerda e direita
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, //para centralizar na horizontal
                children: [
                  Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                  TextFormField(
                    //TextFormField: possui um parâmetro validator
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  // ignore: deprecated_member_use
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0), //espaçamento do botão em cima e em baixo
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        //botão com fundo
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
