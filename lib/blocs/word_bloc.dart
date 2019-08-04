import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jisho/data/repository.dart';
import 'package:jisho/models/word.dart';
import './bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final _repository = Repository.get();

  @override
  WordState get initialState => WordsEmpty();

  @override
  Stream<WordState> mapEventToState(
    WordEvent event,
  ) async* {
    if (event is FetchWords) {
      yield WordsLoading();
      try {
        final List<Word> words = await _repository.getWords(term: event.search);
        if (words == null || words.isEmpty)
          yield event.search.isEmpty ? WordsEmpty() : WordsLoaded([]);
        else
          yield WordsLoaded(words);
      } catch (e) {
        print(e);
        yield WordsError();
      }
    }
  }
}
