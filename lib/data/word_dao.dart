import 'package:jisho/utils/japanese.dart';
import 'package:jisho/data/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jisho/models/word.dart';

class WordDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future update(Word word, String property, bool value) async {}

  Future<List<Word>> getWords({String search}) async {
    if (search != null && search.isNotEmpty) return await find(search);

    return null;
  }

  Future<List<Word>> find(String search) async {
    String param;
    if (Japanese.hasKanji(search)) {
      param = "kanji_text";
    } else if (Japanese.hasKana(search)) {
      param = "kana_text";
    } else {
      param = "gloss";
    }

    var arg1 = search;
    var arg2 = search.substring(0, search.length - 1) +
        String.fromCharCode(search.codeUnitAt(search.length - 1) + 1);

    var where = (param == "gloss")
        ? 'WHERE $param LIKE "%$arg1%"'
        : 'WHERE $param >= "$arg1" AND $param < "$arg2"';

    Database db = await _db;
    var results = await db.rawQuery("""
      SELECT * FROM 'words' as w
      INNER JOIN (
        SELECT DISTINCT(word_id) FROM 'words' 
        $where
      ) as ids 
      ON ids.word_id = w.word_id
      ORDER BY kanji_common DESC, kana_common DESC,
               kanji_text ASC, kana_text ASC,
               word_id ASC, n ASC
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

  Future setVisited(Word word) async {
    update(word, "visited", true);
  }

  Future setFavorites(Word word, bool value) async {
    update(word, "visited", value);
  }

  // ...

  Future<List<Word>> _filterByProperty(String property) async {}

  Future<List<Word>> getHistory() async {
    return _filterByProperty("visited");
  }

  Future<List<Word>> getFavorites() async {
    return _filterByProperty("favorite");
  }
}
