import 'package:jisho/data/app_database.dart';
import 'package:jisho/models/word.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Word word) async {
    Database db = await _db;
    return await db.insert(
      "history",
      {
        "word_id": word.id,
        "favorited": false,
        "visited_time": DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future delete(Word word) async {
    Database db = await _db;
    return await db.delete(
      "history",
      where: "word_id = ?",
      whereArgs: [word.id],
    );
  }

  Future<bool> isFavorite(Word word) async {
    Database db = await _db;
    var results = await db.query(
      "history",
      where: "word_id = ? and favorited = 1",
      whereArgs: [word.id],
    );

    print(results);
    return results != null && results.length > 0;
  }

  Future setFavorite(Word word, bool value) async {
    Database db = await _db;
    return await db.update(
      "history",
      {
        "favorited": value,
        "favorited_time": value ? DateTime.now().millisecondsSinceEpoch : null
      },
      where: "word_id = ?",
      whereArgs: [word.id],
    );
  }

  Future<List<Word>> getHistory() async {
    Database db = await _db;
    var results = await db.rawQuery("""
      SELECT w.* FROM history as h
      INNER JOIN words as w
      ON w.word_id = h.word_id
      ORDER BY h.visited_time DESC, w.word_id ASC, w.n ASC
    """);

    var words = Map<String, List>();

    for (var i in results) {
      var key = i["word_id"];

      if (!words.containsKey(key)) {
        words[key] = [];
      }
      words[key].add(i);
    }

    return words.entries.map((x) {
      return Word.fromRecord(x.key, x.value);
    }).toList();
  }

  Future<List<Word>> getFavorites() async {
    Database db = await _db;
    var results = await db.rawQuery("""
      SELECT w.* FROM history as h
      INNER JOIN words as w
      ON w.word_id = h.word_id
      WHERE h.favorited = 1
      ORDER BY h.favorited_time DESC, w.word_id ASC, w.n ASC
    """);

    var words = Map<String, List>();

    for (var i in results) {
      var key = i["word_id"];

      if (!words.containsKey(key)) {
        words[key] = [];
      }
      words[key].add(i);
    }

    return words.entries.map((x) {
      return Word.fromRecord(x.key, x.value);
    }).toList();
  }
}
