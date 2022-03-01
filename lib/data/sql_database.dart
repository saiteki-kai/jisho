import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._internal();

  static final AppDatabase _instance = AppDatabase._internal();

  static AppDatabase get instance => _instance;

  Completer<Database>? _completer;

  Future<Database> get db async {
    if (_completer == null) {
      _completer = Completer();
      _openDatabase();
    }

    return _completer!.future;
  }

  static const _dbFilename = "database.db";

  void _openDatabase() async {
    final docDir = await getApplicationDocumentsDirectory();
    final dbDir = join(docDir.path, "databases");
    final filepath = join(dbDir, _dbFilename);

    if (!File(filepath).existsSync()) {
      await _copyDatabaseFromAssets(dbDir);
    }

    try {
      final db = await openDatabase(filepath, onOpen: (db) {
        db.rawQuery(
          "PRAGMA synchronous=1; PRAGMA JOURNAL_MODE=WAL; PRAGMA locking_mode=exclusive",
        );
      });
      _completer!.complete(db);
    } catch (e) {
      _completer!.completeError(e);
    }
  }

  Future<void> _copyDatabaseFromAssets(String path) async {
    final dir = Directory(path);

    // create the destination folder if it doesn't already exist
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }

    // move the database from assets
    final dbFile = File(join(dir.path, _dbFilename));
    if (!dbFile.existsSync()) {
      ByteData data = await rootBundle.load(
        join("assets", "databases", _dbFilename),
      );
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }
  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
