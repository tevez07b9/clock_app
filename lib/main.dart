import 'dart:async';

import 'package:clock_app/providers/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider.value(
        value: TimerProvider(),
        child: const MyHomePage(title: 'Timer App'),
      ),
      debugShowCheckedModeBanner: false,
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
  void startTimer() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      if (Provider.of<TimerProvider>(context, listen: false).logs.length ==
          15) {
        timer.cancel();
      } else {
        var newTimer = timer.tick.toInt();
        // debugPrint(newTimer.toString());
        Provider.of<TimerProvider>(context, listen: false)
            .increaseTimer(newTimer);

        if (newTimer % 20 == 0) {
          Provider.of<TimerProvider>(context, listen: false)
              .insertLog(newTimer);
          debugPrint(newTimer.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<TimerProvider>(
          builder: (_, provider, child) {
            var currentTime = provider.timer.toString();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text("timer is: $currentTime s"),
                TextButton(onPressed: startTimer, child: Text("Start")),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      int log = provider.logs[index];
                      return Center(
                        child: Text("Tick at: $log s"),
                      );
                    }),
                    itemCount: provider.logs.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
