import 'package:sembast/sembast.dart';
import 'package:jisho/data/app_database.dart';
import 'package:jisho/models/word.dart';

class HistoryDao {
  static const WORD_STORE_NAME = 'words';
  static const HISTORY_STORE_NAME = 'history';

  final _wordStore = intMapStoreFactory.store(WORD_STORE_NAME);
  final _historyStore = intMapStoreFactory.store(HISTORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(int key) async {
    await _historyStore.add(await _db, {"word": key});
  }

  Future delete(int key) async {
    final finder = Finder(filter: Filter.equal("word", key));

    await _historyStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Word>> getHistory() async {
    final snapshots = await _historyStore.find(await _db);
    final keys = snapshots.map((x) => x["word"]);

    print(keys);

    final recordSnapshots = [];

    keys.forEach((key) async {
      recordSnapshots.add(await _wordStore.find(
        await _db,
        finder: Finder(filter: Filter.byKey(key)),
      ));
    });

    print(recordSnapshots);

    return recordSnapshots.map((snapshot) {
      return Word.fromMap(snapshot.value);
    }).toList();
  }
}
