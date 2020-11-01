import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';//AudioCacheのインポート
import 'package:audioplayers/audioplayers.dart'; 
import 'clock.dart';



AudioCache _player = AudioCache();
AudioPlayer _ap;
void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );


void _sound() async{//右下のボタンを押すと呼び出される、音を鳴らす
  //_player.play('bell.mp3');
  //_player.loop('bgm.wav');
  _ap = await _player.loop('bell.mp3');
  

}
void _stopSound() {//右下のボタンを押すと呼び出される、音を鳴らす
  _ap.stop();
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
            Text(
              '9:00',//変更できるようにする
              style: TextStyle(
              fontSize: 60.0,
              fontFamily: 'IBMPlexMono',
              ),
            ),
            RaisedButton(
              elevation: 16,
              child: const Text('変更'),
              onPressed: () {},
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