import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'file_store.dart' as filestore;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TimeClock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Time Punch Page'),
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
  String _punchTime = '';
  int punchCount = 0;

  String _dayStart = '';
  String _lunchStart = '';
  String _lunchEnd = '';
  String _dayEnd = '';

  String _dayPunches = '';
  var timeCardJson;

  var punchLog = {'punchIn': '', 'lunchOut': '', 'lunchIn': '', 'punchOut': ''};

  void _getTime() {
    final String formattedDateTime =
        DateFormat('yyy-MM-dd kk:mm:ss').format(DateTime.now()).toString();
        
    setState(() {
      _punchTime = formattedDateTime;
      if (punchCount < 4) {
        punchCount++;
      } else {
        punchCount = 1;
      }

      if (punchCount == 1) {
        _dayStart = _punchTime;
        punchLog['punchIn'] = _punchTime;
      }
      if (punchCount == 2) {
        _lunchStart = _punchTime;
        punchLog['lunchOut'] = _punchTime;
      }
      if (punchCount == 3) {
        _lunchEnd = _punchTime;
        punchLog['lunchIn'] = _punchTime;
      }
      if (punchCount == 4) {
        _dayEnd = _punchTime;
        punchLog['punchOut'] = _punchTime;
      }

      _dayPunches = """
          Day In: $_dayStart 
          Lunch Out: $_lunchStart 
          Lunch In: $_lunchEnd 
          Punch Out: $_dayEnd""";
    });
    timeCardJson = jsonEncode(punchLog);

    print(timeCardJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You just created a punch for:',
            ),
            Text(
              _punchTime,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(_dayPunches),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTime,
        child: const Icon(Icons.punch_clock),
      ),
    );
  }
}
