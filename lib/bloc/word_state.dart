import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:jisho/models/word.dart';

@immutable
abstract class WordState extends Equatable {
  WordState([List props = const []]) : super(props);
}

class Waiting extends WordState {

}

class WordsLoading extends WordState {
}

class WordsLoaded extends WordState {
  final List<Word> words;

  WordsLoaded(this.words) : super([words]);
}