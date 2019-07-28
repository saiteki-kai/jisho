import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:jisho/models/word.dart';

@immutable
abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super(props);
}

class WaitForSearch extends WordEvent {

}

class LoadWords extends WordEvent {
  final String search;

  LoadWords(this.search) : super([search]);
}

class AddWord extends WordEvent {

}

class SearchWords extends WordEvent {

}

class UpdateWithRandomWord extends WordEvent {
  final Word updatedWord;

  UpdateWithRandomWord(this.updatedWord) : super([updatedWord]);
}

class DeleteWord extends WordEvent {
  final Word word;

  DeleteWord(this.word) : super([word]);
}