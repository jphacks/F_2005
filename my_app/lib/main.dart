import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => HomePage(),
        },
      ),
    );
