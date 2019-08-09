import 'package:flutter/material.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/phrases/phrases_list.dart';
import 'package:jisho/widgets/results/search_results.dart';

class SentencesSearchResults extends SearchResults {
  SentencesSearchResults({message, key}) : super(message: message, key: key);

  @override
  State<StatefulWidget> createState() => _KanjiSearchResultsState();
}

class _KanjiSearchResultsState extends SearchResultsState {
  final _repository = Repository.get();

  getSentences(String text) async => await _repository.getSentences(text);

  String _value;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: getSentences(_value),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null || snapshot.data?.length == 0)
                  return Center(child: Text("No Results"));
                return PhrasesList(snapshot.data, _value);
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
    setState(() {
      _value = "";
    });
  }

  @override
  void onSearch(value) {
    print("update: $value");
    setState(() {
      _value = value;
    });
  }
}
