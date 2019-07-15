import 'package:jisho/data/database.dart';
import 'package:jisho/models/kanji.dart' as k;
import 'package:jisho/models/word.dart';
import 'package:jisho/models/sentence.dart';

class Repository {

  static final _repo = Repository._internal();

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

  var _lastSearch = MapEntry<String, List<Word>>(null, null);

  Future<List<Word>> findWords(String query, int limit, int skip) async {
    var words = await database.findWords(query, limit, skip);
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

  Future<List<Sentence>> findPhrases(String query) async {
    return await database.findPhrases(query);
  }

  MapEntry<String, List<Word>> getLastSearch() {
    return _lastSearch;
  }

}