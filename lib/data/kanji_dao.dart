import 'package:jisho/data/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jisho/models/kanji.dart';

class KanjiDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<Kanji>> getKanjiList(List<String> list) async {
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
}
