import 'package:jisho/data/app_database.dart';
import 'package:jisho/data/cache.dart';
import 'package:jisho/data/history_dao.dart';
import 'package:jisho/data/sentence_dao.dart';
import 'package:jisho/data/word_dao.dart';
import 'package:jisho/models/sentence.dart';
import 'package:jisho/models/word.dart';

class Repository {
  static final _repo = Repository._internal();

  final _wordDao = WordDao();
  final _wordCache = Cache<List<Word>>();

  final _historyDao = HistoryDao();
  final _historyCache = Cache<List<Word>>();

  final _sentenceDao = SentenceDao();

  AppDatabase _database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    _database = AppDatabase.instance;
  }

  Future init() async {
    return await _database.init();
  }

  Future close() async {
    return await _database.close();
  }

  Future<List<Word>> getWords({String term}) async {
    if (_wordCache.contains(term)) {
      return _wordCache.get(term);
    } else {
      final result = await _wordDao.getWords(search: term);
      _wordCache.set(term, result);
      return result;
    }
  }

  // TODO: rethink cache for history and favorites

  Future<List<Word>> getHistory() async {
    if (_historyCache.contains("HISTORY")) {
      return _historyCache.get("HISTORY");
    } else {
      final result = await _historyDao.getHistory();
      _historyCache.set("HISTORY", result);
      return result;
    }
  }

  Future<List<Word>> getFavorites() async {
    if (_historyCache.contains("FAVORITES")) {
      return _historyCache.get("FAVORITES");
    } else {
      final result = await _historyDao.getFavorites();
      _historyCache.set("FAVORITES", result);
      return result;
    }
  }

  Future addToHistory(Word word) async {
    final result = await _historyDao.insert(word);
    _historyCache.set("HISTORY", null);
    return result;
  }

  Future deleteFromHistory(Word word) async {
    return await _historyDao.delete(word);
  }

  Future<bool> isVisitedWord(Word word) async {
    return await _historyDao.isVisited(word);
  }

  Future<bool> isFavoritedWord(Word word) async {
    return await _historyDao.isFavorited(word);
  }

  Future setFavorite(Word word, bool value) async {
    final result = await _historyDao.setFavorite(word, value);
    _historyCache.remove("FAVORITES");
    return result;
  }

  Future<List<Sentence>> getSentences(String query) async {
    return await _sentenceDao.getSentences(query);
  }
}
