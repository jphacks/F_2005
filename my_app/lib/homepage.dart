import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart'; //AudioCacheのインポート
import 'package:audioplayers/audioplayers.dart';
import 'package:my_app/camera.dart';
import 'clock.dart';
import "package:intl/intl.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

AudioCache _player = AudioCache();
AudioPlayer _ap;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

void _sound() async {
  //音オンで呼び出される、音を鳴らす
  _ap = await _player.loop('bell.mp3');
}

void _stopSound() {
  //音オフ呼び出される、音を鳴らす
  _ap.stop();
}

class _HomePageState extends State<HomePage> {
  String debugTextForCamera = '';

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  TimeOfDay _alarmTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        final int hour = prefs.getInt('hour');
        final int minute = prefs.getInt('minute');
        if (hour != null && minute != null) {
          _alarmTime = TimeOfDay(hour: hour, minute: minute);
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
        'Keep Away From FUTON!!',
        "Good morning!!!",
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
    setState(() {
      debugTextForCamera = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Away From FUTON!!'),
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
                borderRadius: BorderRadius.circular(5),
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
                ]),
            Text(debugTextForCamera),
          ]),
      floatingActionButton: new Visibility(
        visible: true,
        child: new FloatingActionButton(
          onPressed: startCamera,
          child: new Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
