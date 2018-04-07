
import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  String _time = "24";
  String _timeString = "hours";
  ScrollController _scrollController = new ScrollController();



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("HODL 100"),
        actions: <Widget>[
          new FlatButton(textColor: Colors.yellow,
          child: new Text(_time + " " + _timeString, style: new TextStyle( color: Colors.yellow,fontSize: 16.0)),
          onPressed: () {
          setState(() {
            if(_time != "1"){
              _time = "1";
              _timeString = "hour";
            }
            else{
              _time = "24";
              _timeString = "hours";
            }
          
            
          });
        },)
          ],
        leading: new IconButton(
          icon: new Icon(Icons.trending_up,
          color: Colors.yellow),
          onPressed: () {
          setState(() {
             _scrollController.animateTo(_scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeIn);
            });
      }),
      ),
      body: _cryptoWidget(),
      
      
    );
  }
  
  Widget _cryptoWidget(){
    return new ListView.builder(
              controller: _scrollController,
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index){
            final Map currency = widget.currencies[index];
        
            return _getListItemUI(currency);
                      },
    );

                
  }
  

  ListTile _getListItemUI(Map currency) {
    return new ListTile(
      leading: new Text(currency['rank'],style: new TextStyle( color: Colors.white,fontSize: 23.0)),
      title: new Text(currency['name'],
          style: new TextStyle(fontWeight: FontWeight.normal,fontSize: 22.0, color: Colors.white),),
      subtitle: new Text("\$" + currency['price_usd'] , style: new TextStyle(fontSize: 19.0, color: Colors.yellow)),
      trailing: _getSubtitleText(currency['percent_change_'+ _time + 'h']
      ),
      onTap: () => showCurrencyInformation(currency),//can open a new view 
    );
  }

  Widget _getSubtitleText(String change) {
    TextSpan percentageChangeTextWidget;

    if (double.parse(change) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: change  + "%",
          style: new TextStyle(color: Colors.green, fontSize: 20.0));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: change  + "%", style: new TextStyle(color: Colors.red, fontSize: 20.0));
    }

    return new RichText(
        text: new TextSpan(
            children: [percentageChangeTextWidget]));
  }

  Future<Null> showCurrencyInformation(Map currency) async{
    TextStyle style = new TextStyle(fontSize: 18.0,);
    String circulation = "Unbounded";
    if (currency['available_supply'] != null && currency['max_supply'] != null){
        double circ = 100*(double.parse(currency['available_supply'])/double.parse(currency['max_supply']));
        circulation = circ.toStringAsPrecision(2) + " \%";
    }

    
    await showDialog(
      context: context,
      child: new SimpleDialog(
        title: new Text(currency['name']),
        children: <Widget>[
          new SimpleDialogOption(
            child: new Text("Price: " + currency['price_usd'] + " \$", style: style, ),
          ),
          new SimpleDialogOption(
            child: new Text("Price: " + currency['price_btc'] + " btc", style: style ),
          ),
          new SimpleDialogOption(
            child: new Text("Volume: " + currency['24h_volume_usd'] + " \$", style: style ),
          ),
          new SimpleDialogOption(
            child: new Text("Market cap: " + currency['market_cap_usd'] + " \$", style: style ),
          ),
          new SimpleDialogOption(
            child: new Text("Circulating: " + circulation, style: style ),
          ),

        ],
      )
    );
}


}



