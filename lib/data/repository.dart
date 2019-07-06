import 'package:jisho/data/database.dart';
import 'package:jisho/model/word.dart';

class Repository {

  static final Repository _repo = new Repository._internal();

  WordDatabase database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    database = WordDatabase.get();
  }

  Future init() async{
    return await database.init();
  }

  Future close() async {
    return database.close();
  }

  Future<List<Word>> findWords(String query) {
    return database.findWords(query);
  }

}