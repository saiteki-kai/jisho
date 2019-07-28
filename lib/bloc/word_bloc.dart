import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jisho/data/word_dao.dart';
import './bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final _wordDao = WordDao();

  @override
  WordState get initialState => Waiting();

  @override
  Stream<WordState> mapEventToState(
    WordEvent event,
  ) async* {
    if (event is WaitForSearch) {
      yield Waiting();
    } else if (event is LoadWords) {
      yield WordsLoading();
      yield* _reloadWords(search: event.search);
    }
  }

  Stream<WordState> _reloadWords({String search}) async* {
    final words = await _wordDao.getWords(search: search);
    yield WordsLoaded(words);
  }
}
