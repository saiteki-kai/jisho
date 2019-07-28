import 'package:jisho/data/word_dao.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:jisho/data/crendentials.dart';
import 'package:jisho/models/word_old.dart';
import 'package:jisho/models/sentence.dart';
import 'package:jisho/models/kanji.dart' as k;
import 'package:jisho/utils/japanese.dart';

class WordDatabase {
  static final _wordDatabase = WordDatabase._internal();

  Db db;

  var didInit = false;

  static WordDatabase get() {
    return _wordDatabase;
  }

  WordDatabase._internal();

  Future<Db> _getDb() async {
    if (!didInit) await _init();
    return db;
  }

  Future _init() async {
    var usr = Credentials.username;
    var pwd = Credentials.password;

    db = Db("mongodb://$usr:$pwd@ds135786.mlab.com:35786/jisho");
    await db.open();

    didInit = true;
  }

  Future init() async {
    return await _init();
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

  Future<List<Word>> findWords(String query, int limit, int skip) async {
    await _getDb();

    String param;
    if (Japanese.hasKanji(query)) {
      param = "kanji";
    } else if (Japanese.hasKana(query)) {
      param = "kana";
    } else {
      param = "sense.gloss";
    }

    // TODO: ordinare, se possibile, in base a quelli che matchano con il prima dell'array di kanji

    var selector = where.match("$param.0.text", "^$query");
    selector = selector.sortBy(param, descending: true);

    if (param == "sense.gloss") {
      selector = selector.sortBy("kana.0.common");
    } else {
      selector = selector.sortBy("$param.common");
    }

    /*
    var pipeline = [
      {
        "\$match": { "kanji.text": "/^$query/" }
      },
      {
        "\$addFields": {
          "exact": {
            "\$filter": {
              "input": "\$kanji.text",
              "cond": {
                "\$eq": ["\$\$this", query]
              }
            }
          }
        }
      },
      {
        "\$project": {"kanji": 1, "kana": 1, "sense": 1, "exact": 1}
      },
      {
        "\$sort": {"exact.0": -1}
      }
    ];

    var r = await db.collection('words').aggregate(pipeline, cursor: { 'batchSize': 3 }, allowDiskUse: true);

    var result = r["results"];
    print(r);
    */

    print("i'm searching!");

    var result = await db
        .collection('words')
        .find(where.exists("id")) ///////////////////////// test
        .skip(skip) // 1000/181508
        .take(limit)
        .toList();

    print(result);

    print("hi!");

    var words = List<Word>();
    //result.forEach((map) => words.add(Word.fromMap(map)));

    result.forEach((map) {
      map.remove("_id");
      // WordDao().insert(map);
    });

    return words;
  }

  Future<List<Word>> getWords(String property) async {
    await _getDb();

    var result =
        await db.collection('words').find(where.eq(property, true)).toList();

    var words = List<Word>();

    for (Map<String, dynamic> map in result) {
      words.add(Word.fromMap(map));
    }

    return words;
  }

  Future updateWord(String id, String property, bool value) async {
    await _getDb();

    await db
        .collection('words')
        .update(where.eq("id", id), modify.set(property, value));
  }

  Future<List<k.Kanji>> getKanjiList(List<String> list) async {
    await _getDb();

    var result = await db.collection('kanji').find({
      'literal': {"\$in": list}
    }).toList();

    List<k.Kanji> kanji = [];

    for (var x in list) {
      var el = result.singleWhere((r) => r["literal"] == x); // keep order
      if (el != null) kanji.add(k.Kanji.fromMap(el));
    }

    return kanji;
  }

  Future<k.Kanji> getKanji(String text) async {
    await _getDb();

    var result =
        await db.collection('kanji').findOne(where.eq("literal", text));

    return k.Kanji.fromMap(result);
  }

  Future<List<Sentence>> findPhrases(String query) async {
    await _getDb();

    print(query);

    var result = await db
        .collection('sentences')
        .find(where.match("jpn", ".*$query.*"))
        .take(10)
        .toList();

    print(result);

    List<Sentence> sentences = [];
    result.forEach((map) => sentences.add(Sentence.fromMap(map)));

    return sentences;
  }
}
