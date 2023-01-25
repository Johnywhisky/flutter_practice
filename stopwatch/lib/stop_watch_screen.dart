import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;

  int _time = 0;
  bool _isRunning = false;
  final List<String> _lapTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) => setState(() => _time++),
    );
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  void _recordLapTimes(String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등 ${time}s');
  }

  @override
  void dispose() {
    _timer?.cancel(); // => if (_timer == null) {_timer.cancel();} 와 동일
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int secs = _time ~/ 100; // 몫
    int hours = 0;
    int minutes = 0;
    int milliSecs = _time % 100; // 나머지

    return Scaffold(
        appBar: AppBar(title: const Text('스톱워치')),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hours.toString(),
                  style: const TextStyle(fontSize: 50),
                ),
                const Text(
                  ':',
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  minutes.toString(),
                  style: const TextStyle(fontSize: 50),
                ),
                const Text(
                  ':',
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  secs.toString(),
                  style: const TextStyle(fontSize: 50),
                ),
                Text(
                  milliSecs.toString().padLeft(2, '0'),
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: ListView(
                children:
                    _lapTimes.map((time) => Center(child: Text(time))).toList(),
              ),
            ),
            const Spacer(), // 빈 공간을 차지하는 위젯
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: () => setState(() => _reset()),
                  child: const Icon(Icons.refresh),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _clickButton();
                    });
                  },
                  child: _isRunning
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  onPressed: () =>
                      _recordLapTimes('$hours.$minutes.$secs.$milliSecs'),
                  child: const Icon(Icons.add),
                )
              ],
            ),
            const SizedBox(height: 30)
          ],
        ));
  }
}
