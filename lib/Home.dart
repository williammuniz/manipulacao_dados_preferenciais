import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textoSalvo = "Nada salvo";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async{
    final prefs = await SharedPreferences.getInstance();
    String valorDigitado = _controllerCampo.text;
    await prefs.setString("nome", valorDigitado);
    print("valor salvo: ${valorDigitado} " );
    setState(() {
      _textoSalvo = valorDigitado;
    });

  }
  _recuperar() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem Valor";
    });

  }

  _remover() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nome");
    setState(() {
      _textoSalvo  = "Nada salvo";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manipulação de dados"),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Text(_textoSalvo,
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Digite Algo"),
                controller: _controllerCampo,
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: _salvar,
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Salvar",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  RaisedButton(
                    onPressed: _recuperar,
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Recuperar",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  RaisedButton(
                    onPressed: _remover,
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Remover",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
