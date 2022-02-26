import 'package:jisho/data/model/word.dart';
import 'package:jisho/database.dart';
import 'package:jisho/objectbox.g.dart';

class WordRepository {
  Future<Store> get _store async => await Database.instance.store;

  const WordRepository();

  Future<List<WordEntry>> getWords() async {
    final store = await _store;
    return store.box<WordEntry>().getAll();
  }

  Future<WordEntry?> getWord(int id) async {
    final store = await _store;
    return store.box<WordEntry>().get(id);
  }
}
