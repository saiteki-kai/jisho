part of 'word_cubit.dart';

@immutable
abstract class WordsState {
  const WordsState();
}

class WordsInitial extends WordsState {
  const WordsInitial();
}

class WordsLoading extends WordsState {
  const WordsLoading();
}

class WordsLoaded extends WordsState {
  final List<WordEntry> words;
  const WordsLoaded(this.words);
}
