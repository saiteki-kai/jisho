import 'package:jisho/data/app_database.dart';
import 'package:jisho/utils/japanese.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jisho/models/kanji.dart';

class KanjiDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<Kanji>> getKanjiFromList(List<String> list) async {
    if (list == null || list.length == 0) return null;

    Database db = await _db;
    var results = await db.query(
      "kanji",
      where: "literal IN ('${list.join("','")}')",
    );

    List<Kanji> kanjiList = [];
    for (var x in list) {
      var el = results.singleWhere((r) => r["literal"] == x); // keep order
      if (el != null) kanjiList.add(Kanji.fromRecord(el));
    }
    return kanjiList;
  }

  // TODO: Convert Katakana to Hiragana and viceversa...?
  Future<List<Kanji>> getKanji(String text) async {
    if (text == null || text.isEmpty) return null;

    String where;
    List<String> args;

    if (Japanese.hasKanji(text)) {
      where = "literal = ?";
      args = [text];
    } else {
      where = "kun_readings LIKE ? OR on_readings LIKE ?";
      args = ["%$text%", "%$text%"];
    }

    Database db = await _db;
    var results = await db.query(
      "kanji",
      where: where,
      whereArgs: args,
      orderBy: "stroke_count ASC, meanings ASC, grade DESC",
    );

    return results.map((r) => Kanji.fromRecord(r)).toList();
  }
}
