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
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      body: Center(
        child: Column(
          children: <Widget>[//表示画面
            Text(
              '*現在時刻*',
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'IBMPlexMono',
              ),
            ),
            Clock(),
            Text(
              '*アラーム時間の設定*',
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'IBMPlexMono',
              ),
            ),
            Text(
              formatter.format(_mydatetime),
              style: TextStyle(
              fontSize: 60.0,
              fontFamily: 'IBMPlexMono',
              ),
            ),
            RaisedButton(//変更ボタン
              elevation: 16,
              child: const Text('変更'),
              onPressed: () {
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
              color: Colors.orange,
            ),
            RaisedButton(
              elevation: 16,
              child: const Text('音オン'),
              onPressed: _sound,
              color: Colors.orange,
            ),
            RaisedButton(
              elevation: 16,
              child: const Text('音オフ'),
              onPressed: _stopSound,
              color: Colors.orange,
            ),
          ]
        ),
      ),
       
      floatingActionButton: FloatingActionButton(//右下のボタン
        onPressed: () {},
        child: Icon(Icons.photo), //写真のアイコン
      ),
    );
  }
}