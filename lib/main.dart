import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hodl100/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  List currencies = await getCurrencies();
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final List _currencies;
  MyApp(this._currencies);
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "HODL 100",
      theme: new ThemeData(
        primaryColor: Colors.black,
        canvasColor: Colors.black,
      ),
      home: new HomePage(_currencies),
    );
  }
}

  Future<List> getCurrencies() async {
    String cryptoURL = "https://api.coinmarketcap.com/v1/ticker";
    http.Response response = await http.get(cryptoURL);
    return JSON.decode(response.body);
  }

