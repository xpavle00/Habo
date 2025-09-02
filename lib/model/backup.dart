import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Backup {
  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/backup.json');
  }



  static Future<File> writeBackup(dynamic data) async {
    try {
      final file = await _localFile;
      // Encode either a List<Habit> (legacy) or a full Map backup payload
      final jsonData = jsonEncode(data);
      
      // Validate JSON before writing
      try {
        jsonDecode(jsonData);
      } catch (e) {
        throw Exception('Invalid JSON data: $e');
      }
      
      return file.writeAsString(jsonData);
    } catch (e) {
      throw Exception('Failed to create backup: $e');
    }
  }

  static Future<String> readBackup(String filePath) async {
    try {
      final file = File(filePath);
      final json = await file.readAsString();
      return json;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getBackupFileInfo(String path) async {
    try {
      final file = File(path);
      final stat = await file.stat();
      
      return {
        'size': stat.size,
        'modified': stat.modified,
        'exists': true,
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'exists': false,
      };
    }
  }
}
