import 'package:jisho/data/database.dart';
import 'package:jisho/models/kanji.dart' as k;
import 'package:jisho/models/word.dart';

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

  Future<List<Word>> getFavoriteWords() async {
    return await database.getWords("favorite");
  }

  Future<List<Word>> getVisitedWords() async {
    return await database.getWords("visited");
  }

  Future<Word> addFavoriteWord(String id) async {
    return await database.updateWord(id, "favorite", true);
  }

  Future<Word> removeFavoriteWord(String id) async {
    return await database.updateWord(id, "favorite", false);
  }

  Future<Word> setVisitedWord(String id) async {
    return await database.updateWord(id, "visited", true);
  }

  Future<List<k.Kanji>> getKanjiList(List<String> text) async {
    return await database.getKanjiList(text);
  }

  Future<k.Kanji> getKanji(String text) async {
    return await database.getKanji(text);
  }

  MapEntry<String, List<Word>> getLastSearch() {
    return _lastSearch;
  }

}