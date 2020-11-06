import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:my_app/videoPlayer.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool _buttonEnabled = true;
  bool _waitingResponse = false;
  double _probability = 0;
  String _buttonText = '判定';

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startJudging() async {
    setState(() {
      _buttonEnabled = false;
    });
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.jpeg',
      );
      await _controller.takePicture(path);
      print('took a picture');
      File file = File(path);
      setState(() {
        _waitingResponse = true;
      });
      final response = await http.post(
          'https://jphacks-f2005.cognitiveservices.azure.com/customvision/v3.0/Prediction/04c0485b-9305-4829-9a32-fe82c0ce1f72/detect/iterations/FoldedFutonIteration1/image',
          headers: {
            "Prediction-Key": "7c040816259e43d3b401f1683a84e999",
            "Content-Type": "application/octet-stream"
          },
          body: file.readAsBytesSync());
      _probability =
          json.decode(response.body)['predictions'][0]['probability'];
      if (_probability >= 0.7) {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return VideoPlayerScreen();
        }));
        Navigator.of(context).pop(true);
      }
      print(_probability);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _waitingResponse = false;
        _buttonEnabled = true;
        _buttonText = '再判定';
      });
    }
  }

  void judge() {
    startJudging();
  }

  void debug() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoPlayerScreen();
    }));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Take a picture")),
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          (_waitingResponse
              ? Center(child: CircularProgressIndicator())
              : Container()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: _buttonEnabled ? judge : null,
            child: Text(_buttonText),
          ),
          Container(
            // 余白のためContainerでラップ
            margin: EdgeInsets.only(bottom: 16.0),
            child: RaisedButton(
              onPressed: _buttonEnabled ? debug : null,
              child: Text('強制認識'),
            ),
          ),
        ],
      ),
    );
  }
}
