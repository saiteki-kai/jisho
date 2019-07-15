import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

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
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'jisho.db');

    final database = await databaseFactoryIo.openDatabase(path);
    _completer.complete(database);
  }
}