import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:jisho/objectbox.g.dart';

class Database {
  Database._internal();

  static final Database _instance = Database._internal();

  static Database get instance => _instance;

  Store? _store;

  Future<Store> get store async {
    _store ??= await _openDatabaseStore();
    return Future.value(_store);
  }

  Future<Store> _openDatabaseStore() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbDir = Directory(join(dir.path, "objectbox"));

    if (!dbDir.existsSync()) {
      await _copyDatabaseFromAssets(dbDir);
    }

    return openStore(directory: dbDir.path);
  }

  Future<void> _copyDatabaseFromAssets(Directory directory) async {
    // create the destination folder if it doesn't already exist
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }

    // move the database from assets
    final dbFile = File(join(directory.path, 'data.mdb'));
    if (!dbFile.existsSync()) {
      ByteData data = await rootBundle.load(
        join("assets", "databases", "data.mdb"),
      );
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }
  }

  Future close() async {
    final store = await instance.store;
    store.close();
  }
}
