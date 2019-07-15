import 'package:jisho/utils/japanese.dart';
import 'package:sembast/sembast.dart';
import 'package:jisho/data/app_database.dart';
import 'package:jisho/models/word.dart';

class WordDao {
  static const WORD_STORE_NAME = 'words';

  final _wordStore = intMapStoreFactory.store(WORD_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Word word) async {
    await _wordStore.add(await _db, word.toMap());
  }

  Future update(Word word, String property, bool value) async {
    final map = word.toMap();
    map[property] = value;

    final finder = Finder(filter: Filter.equals("id", word.id));

    await _wordStore.update(await _db, map, finder: finder);
  }

  Future<List<Word>> find(String search) async {
    String param;
    if (Japanese.hasKanji(search)) {
      param = "kanji";
    } else if (Japanese.hasKana(search)) {
      param = "kana";
    } else {
      param = "sense.gloss";
    }

    final regex = RegExp(param != "sense.gloss" ? "^$search" : "$search");

    final finder = Finder(
        filter: Filter.custom((snapshot) {
          final list = snapshot.value[param] as List;
          return list.any((x) => regex.hasMatch(x["text"]));
        }),
        sortOrders: [SortOrder("kanji.text")]);

    final recordSnapshots = await _wordStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      return Word.fromMap(snapshot.value);
    }).toList();
  }

  Future setVisited(Word word) async {
    update(word, "visited", true);
  }

  Future setFavorites(Word word, bool value) async {
    update(word, "visited", value);
  }

  Future<List<Word>> _filterByProperty(String property) async {
    final finder = Finder(filter: Filter.equals(property, true));

    final recordSnapshots = await _wordStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      return Word.fromMap(snapshot.value);
    }).toList();
  }

  Future<List<Word>> getHistory() async {
    return _filterByProperty("visited");
  }

  Future<List<Word>> getFavorites() async {
    return _filterByProperty("favorite");
  }
}
