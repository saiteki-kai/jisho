import 'package:mongo_dart/mongo_dart.dart';

import 'package:jisho/data/crendentials.dart';
import 'package:jisho/model/word.dart';

class WordDatabase {
  static final _wordDatabase = new WordDatabase._internal();

  Db db;

  bool didInit = false;

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

    db = new Db("mongodb://$usr:$pwd@ds135786.mlab.com:35786/jisho");
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

  Future<List<Word>> findWords(query) async {
    await _getDb();

    var result = await db
        .collection('words')
        .find(where.match("kanji.text", "^$query"))
        .toList();

    List<Word> words = [];

    for(Map<String, dynamic> map in result) {
      words.add(new Word.fromMap(map));
    }

    return words;
  }
}
