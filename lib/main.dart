import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';

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
  int time = 0;
  void startRecord() async {
    FlutterScreenRecording.startRecordScreen('test$time');
  }

  void stopRecord() async {
    String path = await FlutterScreenRecording.stopRecordScreen;
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
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    timer();
  }

  requestPermissions() async {
    // await PermissionHandler().requestPermissions([
    //   PermissionGroup.storage,
    //   PermissionGroup.photos,
    //   PermissionGroup.microphone,
    // ]);
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
          Text(time.toString()),
          Center(
            child: CupertinoButton(
              child: Text(
                isRecording.toString(),
                style: TextStyle(fontSize: 32),
              ),
              onPressed: toggleRecording,
            ),
          ),
        ],
      ),
    );
  }
}
