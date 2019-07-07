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

  MapEntry<String, List<Word>> _lastSearch = new MapEntry<String, List<Word>>(null, null);

  Future<List<Word>> findWords(String query) async {
    var words = await database.findWords(query);
    _lastSearch = MapEntry<String, List<Word>>(query, words);
    return words;
  }

  MapEntry<String, List<Word>> getLastSearch() {
    return _lastSearch;
  }

}