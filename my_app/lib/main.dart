import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';//AudioCacheのインポート
import 'clock.dart';

AudioCache _player = AudioCache();

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );


void _sound() {//右下のボタンを押すと呼び出される、音を鳴らす
  _player.play('se.wav');
}

class MyApp extends StatelessWidget {
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
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(//右下のボタン
        onPressed: _sound,
        child: Icon(Icons.photo), //写真のアイコン
      ),
    );
  }
}