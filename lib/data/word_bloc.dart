import 'package:jisho/data/word_dao.dart';
import 'package:jisho/models/word.dart';

import 'dart:async';

class WordBloc {
  final _wordDao = WordDao();

  final _wordsController = StreamController<List<Word>>.broadcast();

  get words => _wordsController.stream;

  WordBloc() {
    getWords();
  }

  getWords({String query}) async {
    _wordsController.sink.add(await _wordDao.getWords(search: query));
  }

  addWord(Word word) async {
    // await _wordDao.insert(word);
    getWords();
  }

  setVisited(Word word) async {
    await _wordDao.setVisited(word);
    getWords();
  }

  dispose() {
    _wordsController.close();
  }
}