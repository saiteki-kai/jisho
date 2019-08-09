import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho/blocs/bloc.dart';
import 'package:jisho/blocs/word_state.dart';
import 'package:jisho/widgets/results/search_results.dart';
import 'package:jisho/widgets/word/word_list.dart';

class WordsSearchResults extends SearchResults {
  WordsSearchResults({message, key}) : super(message: message, key: key);

  @override
  State<StatefulWidget> createState() => _WordsSearchResultsState();
}

class _WordsSearchResultsState extends SearchResultsState {
  final _wordBloc = WordBloc();

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: BlocBuilder<WordBloc, WordState>(
            bloc: _wordBloc,
            builder: (BuildContext context, WordState state) {
              if (state is WordsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                );
              } else if (state is WordsLoaded) {
                if (state.words.isEmpty)
                  return Center(
                    child: Text("No Results"),
                  );
                return WordList(state.words);
              } else {
                return widget.message;
              }
            },
          ),
        )
      ],
    );
  }

  @override
  void onClear() {
    print("close");
    _wordBloc.dispatch(FetchWords(""));
  }

  @override
  void onSearch(value) {
    print("update: $value");
    if (_wordBloc.currentState is WordsLoading) {
      // cancel previous dispatch in some way...??
    }
    _wordBloc.dispatch(FetchWords(value));
  }
}
