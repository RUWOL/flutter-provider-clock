import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TimeNow()),
        ],
        child: const MyApp(),
      )
  );
}


class TimeNow with ChangeNotifier{
  String _time = '00:00:00';
  String get nowTime => _time;
  void setNowTime() {
    _time = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);
    notifyListeners();
  }
}

// detect change
class Time extends StatelessWidget {
  const Time({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<TimeNow>().nowTime,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {context.read<TimeNow>().setNowTime();});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Time(),
          ],
        ),
      ),
    );
  }
}
