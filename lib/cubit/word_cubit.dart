import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jisho/data/model/word.dart';
import 'package:jisho/data/repositories/word.dart';

part 'word_state.dart';

class WordCubit extends Cubit<WordsState> {
  final WordRepository repository;

  WordCubit({required this.repository}) : super(const WordsInitial()) {
    // getWords();
  }

  Future<void> getWords() async {
    emit(const WordsLoading());
    final words = await repository.getWords();
    emit(WordsLoaded(words));
  }
}