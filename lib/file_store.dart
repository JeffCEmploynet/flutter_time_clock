import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/punches.json');
}

Future<String> readFile() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();
    var jsonResponse = jsonDecode(contents);
    return jsonResponse;
  } catch (e) {
    // If encountering an error, return 0
    return '0';
  }
}

Future<File> writeFile(var dayPunch) async {
  final file = await _localFile;
  String myPath = file.toString();
  print('Here is your local path $myPath');
  // Write the file
  return file.writeAsString(dayPunch);
}
