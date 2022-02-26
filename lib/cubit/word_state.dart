part of 'word_cubit.dart';

@immutable
abstract class WordsState extends Equatable {
  const WordsState();
}

class WordsInitial extends WordsState {
  const WordsInitial();

  @override
  List<Object?> get props => [];
}

class WordsLoading extends WordsState {
  const WordsLoading();

  @override
  List<Object?> get props => [];
}

class WordsLoaded extends WordsState {
  final List<WordEntry> words;
  const WordsLoaded(this.words);

  @override
  List<Object?> get props => [words];
}
