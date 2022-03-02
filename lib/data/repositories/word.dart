import 'package:jisho/data/model/word.dart';
import 'package:jisho/data/sql_database.dart';
import 'package:jisho/utils/japanese.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:math';

class WordRepository {
  const WordRepository();

  Future<Database> get _db async => await AppDatabase.instance.db;

  Future<List<WordEntry>> getWords(String term) async {
    final db = await _db;

    List<int> word_ids = [];
    List<Map<String, Object?>> res = [];

    if (Japanese.isJapanese(term)) {
      if (Japanese.hasKanji(term)) {
        res = await db.query(
          "kanji",
          distinct: true,
          columns: ["word_id"],
          where: "text LIKE ?",
          whereArgs: ["%$term%"],
          orderBy: "common DESC, kanji_id ASC",
        );
      } else {
        res = await db.query(
          "reading",
          distinct: true,
          columns: ["word_id"],
          where: "text LIKE ?",
          whereArgs: ["%$term%"],
          orderBy: "common DESC, reading_id ASC",
        );
      }
    } else {}

    word_ids = res
        .map((e) => int.parse(e["word_id"].toString()))
        .toList()
        .sublist(0, min(res.length, 1000));
    print((word_ids).length);

    // retrieve all entries from word_ids
    List<WordEntry> words = [];
    final stopwatch = Stopwatch()..start();
    for (int word_id in word_ids) {
      words.add(await getEntry(db, word_id));
    }
    print(stopwatch.elapsed);
    return words;
  }

  Future<WordEntry?> getWord(int id) async {
    final db = await _db;
    return null;
  }

  Future<WordEntry> getEntry(Database db, int word_id) async {
    final kanji_map = await db.query(
      "kanji",
      where: "word_id = ?",
      whereArgs: [word_id],
    );

    final reading_map = await db.query(
      "reading",
      where: "word_id = ?",
      whereArgs: [word_id],
    );

    final kanji = kanji_map.map((map) => Kanji.fromMap(map)).toList();
    final reading = reading_map.map((map) => Reading.fromMap(map)).toList();

    return Future.value(WordEntry(id: word_id, kanji: kanji, reading: reading));
  }
}
