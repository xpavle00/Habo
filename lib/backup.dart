import 'dart:convert';
import 'dart:io';

import 'package:Habo/widgets/habit.dart';
import 'package:path_provider/path_provider.dart';

class Backup {
  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/backup.json');
  }

  static Future<File> writeBackup(List<Habit> input) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(input));
  }

  static Future<String> readBackup(String path) async {
    try {
      final file = File(path);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }
}
