import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart'; //AudioCacheのインポート
import 'package:audioplayers/audioplayers.dart';
import 'package:my_app/camera.dart';
import 'clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'videoPlayer.dart';

AudioCache _player = AudioCache();
AudioPlayer _audioPlayer;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

void _stopSound() {
  //音オフ呼び出される、音を鳴らす
  if (_audioPlayer != null) _audioPlayer.stop();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  TimeOfDay _alarmTime = TimeOfDay.now();
  String alarmTimeStr;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        final int hour = prefs.getInt('hour');
        final int minute = prefs.getInt('minute');
        if (hour != null && minute != null) {
          _alarmTime = TimeOfDay(hour: hour, minute: minute);
          this.alarmTimeStr =
              _alarmTime.hour.toString() + _alarmTime.minute.toString();
          soundTheAlarm(this.alarmTimeStr);
        }
      });
    });

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void soundTheAlarm(setAlarmTimeStr) async {
    TimeOfDay now = TimeOfDay.now();
    String nowStr = now.hour.toString() + now.minute.toString();
    if (nowStr == setAlarmTimeStr) {
      _audioPlayer = await _player.loop('bell.mp3');
    }
  }

  Future<void> _updateNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    final Time time = Time(_alarmTime.hour, _alarmTime.minute, 0);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('reminder', 'Reminder', 'Daily reminder',
            sound: RawResourceAndroidNotificationSound('bell'));
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Keep Away from FUTON!!',
        "Good morning!!布団を畳んでください",
        time,
        platformChannelSpecifics);
  }

  void startCamera() async {
    final cameras = await availableCameras();
    final firstcamera = cameras.first;
    final result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TakePictureScreen(camera: firstcamera);
    }));
    if (result == true) {
      _stopSound();
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return VideoPlayerScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Away from Futon'),
        backgroundColor: Colors.blue,
      ),
      body: new Column(
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
                  new Icon(Icons.access_time,
                      color: const Color(0xFF8b91ff), size: 48.0),
                  new Text(
                    "TIME",
                    style: new TextStyle(
                      fontSize: 38.0,
                      color: const Color(0xFF8b91ff),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Itim-Regular",
                    ),
                  )
                ]),
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
                  new Icon(Icons.access_alarms,
                      color: const Color(0xFFff8080), size: 48.0),
                  new Text(
                    "ALARM",
                    style: new TextStyle(
                        fontSize: 38.0,
                        color: const Color(0xFFff8080),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Itim-Regular"),
                  )
                ]),
            new Text(
              "${_alarmTime.format(context)}",
              style: new TextStyle(
                  fontSize: 55.0,
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
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: _alarmTime,
                ).then<void>((TimeOfDay value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _alarmTime = value;
                  });
                  SharedPreferences.getInstance()
                      .then((SharedPreferences prefs) {
                    prefs.setInt('hour', value.hour);
                    prefs.setInt('minute', value.minute);
                  });
                  _updateNotification();
                });
              },
            ),
            new SizedBox(
              width: 500.0,
              height: 200.0,
            ),
          ]),
      floatingActionButton: new RaisedButton.icon(
        icon: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        label: const Text('カメラで布団を撮影'),
        onPressed: startCamera,
        color: Colors.blue,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        //padding: new EdgeInsets.all(20),
      ),
    );
  }
}
