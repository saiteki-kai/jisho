import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final _instance = AppDatabase._();

  static get instance => _instance;

  Completer<Database> _completer;

  AppDatabase._();

  Future<Database> get database async {
    if (_completer == null) {
      _completer = Completer();
      _openDatabase();
    }
    return _completer.future;
  }

  Future _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'jisho.db');

    final exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "jisho.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    final database = await openDatabase(path);
    _completer.complete(database);
  }

  init() async {
    await database;
  }

  close() async {
    (await database).close();
  }
}
