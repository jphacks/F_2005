import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
String _time = '';

class Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClockState();
  }
}



class _ClockState extends State<Clock> {
  
  //String _time = '';
  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );
    super.initState();
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    var formattedTime = formatter.format(now);
    setState(() => _time = formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _time,
      style: TextStyle(
        fontSize: 60.0,
        fontFamily: 'IBMPlexMono',
      ),
    );
  }
}