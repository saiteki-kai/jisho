import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super(props);
}

class FetchWords extends WordEvent {
  final String search;

  FetchWords(this.search) : super([search]);
}
