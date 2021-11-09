import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRecording = false;
  String? path;
  int time = 0;
  late VideoPlayerController c;

  void startRecord() async {
    // Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    // print(tempPath);

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // print(appDocPath);
    FlutterScreenRecording.startRecordScreen('$time');
  }

  void stopRecord() async {
    String _path = await FlutterScreenRecording.stopRecordScreen;
    setState(() {
      print("$_path !!!!");
      path = _path;
    });
  }

  void toggleRecording() async {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      print('start');
      startRecord();
    } else {
      stopRecord();
      print('end');
    }
  }

  void timer() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        time++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timer();

    c = VideoPlayerController.file(
        File('/data/user/0/com.example.record_test/files/71.mp4'))
      ..initialize().then((value) => c.play());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (path != null) ...[
            Text(path!),
          ],
          Container(
            width: 300,
            height: 500,
            child: VideoPlayer(c),
          ),
          Text(time.toString()),
          Center(
            child: CupertinoButton(
              child: Text(
                isRecording.toString(),
                style: const TextStyle(fontSize: 32),
              ),
              onPressed: toggleRecording,
            ),
          ),
        ],
      ),
    );
  }
}
