
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
        leading: new Icon(Icons.trending_down,
      color: Colors.yellow),
      ),
      body: _cryptoWidget(),
      
      
    );
  }
  
  Widget _cryptoWidget(){
    return new ListView.builder(
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
      onTap: () => print(currency['name']),//can open a new view 
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

}

