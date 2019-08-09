import 'package:jisho/utils/japanese.dart';
import 'package:jisho/data/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jisho/models/sentence.dart';

class SentenceDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<Sentence>> getSentences(String text) async {
    Database db = await _db;

    var where = "jap LIKE ?";
    if (!Japanese.hasKanji(text) && !Japanese.hasKana(text)) {
      where = "eng LIKE ?";
    }

    var results = await db.query(
      "sentences",
      where: where,
      whereArgs: ['%$text%'],
    );

    return results.map((x) => Sentence.fromMap(x)).toList();
  }
}
