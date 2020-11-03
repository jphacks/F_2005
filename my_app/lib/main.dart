import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';//AudioCacheのインポート
import 'package:audioplayers/audioplayers.dart'; 
import 'clock.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:intl/intl.dart";

AudioCache _player = AudioCache();
AudioPlayer _ap;

void main() => runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Flutter Datepicker Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Datepicker Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


void _sound() async{//音オンで呼び出される、音を鳴らす
  _ap = await _player.loop('bell.mp3');
}
void _stopSound() {//音オフ呼び出される、音を鳴らす
  _ap.stop();
}

class _MyHomePageState extends State<MyHomePage> {
  //選択した時刻
  var _mydatetime = new DateTime.now();
  //表示するフォーマット
  var formatter = new DateFormat('HH:mm');

  

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Away From FUTON!!'),
        backgroundColor: Colors.blue,
        
      ),
      body:
          new Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                width: 500.0,
                height: 10.0,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Icon(
                    Icons.access_time,
                    color: const Color(0xFF8b91ff),
                    size: 48.0),
    
                  new Text(
                  "TIME",
                    style: new TextStyle(fontSize:38.0,
                    color: const Color(0xFF8b91ff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Itim-Regular",),
                  )
                ]
    
              ),
    
              Clock(),
              new SizedBox(
                width: 500.0,
                height: 5.0,
              ),
             new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Icon(
                    Icons.access_alarms,
                    color: const Color(0xFFff8080),
                    size: 48.0),
    
                  new Text(
                  "ALARM",
                    style: new TextStyle(fontSize:38.0,
                    color: const Color(0xFFff8080),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Itim-Regular"),
                  )
                ]
    
              ),
    
              new Text(
              formatter.format(_mydatetime),
                style: new TextStyle(fontSize:55.0,
                color: const Color(0xFFff8080),
                fontWeight: FontWeight.w400,
                fontFamily: "Itim-Regular"),
              ),
              new SizedBox(
                width: 500.0,
                height: 5.0,
              ),
              RaisedButton(
                child: const Text('アラーム時間の変更'),
                textColor: Colors.white,
                color: const Color(0xFFff8080),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                
                
              ),
              onPressed:  () {
                DatePicker.showTimePicker(
                context,
                showTitleActions: true,
                // onChanged内の処理はDatepickerの選択に応じて毎回呼び出される
                onChanged: (date) {
                // print('change $date');
                }, 
                // onConfirm内の処理はDatepickerで選択完了後に呼び出される
                onConfirm: (date) {
                  setState(() {
                    _mydatetime = date;
                  });
                }, 
                // Datepickerのデフォルトで表示する日時
                currentTime: DateTime.now(), 
                // localによって色々な言語に対応
                locale: LocaleType.jp
                );
              },
              ),
              new SizedBox(
                width: 500.0,
                height: 15.0,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new RaisedButton(
                    child: const Text('Sound ON'),
                    textColor: Colors.white,
                    color: const Color(0xFFffb225),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: _sound,
                  ),
                  new SizedBox(
                    width: 50.0,
                    height: 10.0,
                  ),
                  new RaisedButton(
                    child: const Text('Sound OFF'),
                    textColor: Colors.white,
                    color: const Color(0xFFffb225),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: _stopSound,
                  ),
                  
                ]
    
              ),
            ]
            
    
          ),
        

        floatingActionButton: new Visibility( 
          visible: true,
          child: new FloatingActionButton(
            onPressed: (){},
            child: new Icon(Icons.add_a_photo),
          ), 
        ),    
      
    );
  }

}