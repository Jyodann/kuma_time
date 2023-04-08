import 'dart:async';

import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kuma time!"),
        ),
        body: StopwatchPage(),
      ),
    );
  }
}

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StopWatchWidget(),
    );
  }
}

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({super.key});

  @override
  State<StopWatchWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  late Stopwatch _stopWatch;
  late Timer _timer;
  String result = "00:00:00";

  bool isStopwatchCanBeReset = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _stopWatch = Stopwatch();

    _stopWatch.start();

    _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      setState(() {
        result = returnFormattedStopWatchTime(_stopWatch.elapsed);
      });
    });
  }

  void PauseResumeStopWatch() {
    if (_stopWatch.isRunning) {
      _stopWatch.stop();
      return;
    }
    _stopWatch.start();

    setState(() {
      isStopwatchCanBeReset = false;
    });
  }

  void ResetStopWatch() {
    _stopWatch.reset();
    _stopWatch.stop();

    setState(() {
      isStopwatchCanBeReset = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(result),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () => {
                PauseResumeStopWatch(),
              },
              child: Text(_stopWatch.isRunning ? "Pause" : "Start"),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Lap'),
            ),
            ElevatedButton(
              onPressed:
                  isStopwatchCanBeReset ? null : () => {ResetStopWatch()},
              child: Text('Reset'),
            )
          ],
        )
      ],
    );
  }
}

String returnFormattedStopWatchTime(Duration duration) {
  var milsec = duration.inMilliseconds % 100;
  var seconds = duration.inSeconds % 60;
  var minutes = duration.inMinutes % 60;
  var hours = duration.inHours;

  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milsec.toString().padLeft(2, '0')}";
}
