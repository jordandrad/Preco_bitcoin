import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String preco = "";
  void atualizaPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response;
    response = await http.get(url);
    // print(response.body);
    json.decode(response.body);
    Map<dynamic, dynamic> retorno = json.decode(response.body);
    var usd = retorno["USD"]["sell"];

    print(usd.toString());

    setState(() {
      preco = usd.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  bottom: 25,
                ),
                child: Image.asset(
                  "images/bitcoin_image.png",
                  height: 70,
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                "\$ $preco",
                style: TextStyle(fontSize: 40, color: Colors.grey.shade700),
              ),
            ),
            Container(
              height: 45,
              width: 150,
              child: ElevatedButton(
                onPressed: atualizaPreco,
                child: Text("Atualizar"),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
            )
          ],
        )));
  }
}
