import 'package:equatable/equatable.dart';
import 'package:jisho/models/word.dart';

abstract class WordState extends Equatable {
  WordState([List props = const []]) : super(props);
}

class WordsEmpty extends WordState {}

class WordsLoading extends WordState {}

class WordsLoaded extends WordState {
  final List<Word> words;

  WordsLoaded(this.words) : super([words]);
}

class WordsError extends WordState {}
