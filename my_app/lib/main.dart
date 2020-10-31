import 'package:flutter/material.dart';
import 'clock.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

int _counter = 0;
void _incrementCounter() {
  _counter++;
  return;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Away From FUTON!!'),
        backgroundColor: Colors.yellow,
        
      ),
      body: Center(
        child: Column(
          children: <Widget>[
          
            
            Text(
              '*現在時刻*',
              style: Theme.of(context).textTheme.headline4,
            ),
            Clock(),
            Text(
              '*アラーム時間の設定*',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            
          ]
        
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.photo), //写真のアイコン
      ),
    );
  }
}