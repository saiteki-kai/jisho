import 'package:flutter/material.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/phrases/phrases_list.dart';

class PhrasesTab extends StatelessWidget {
  final String word;
  PhrasesTab(this.word);

  getPhrases(text) async {
    return await Repository.get().findPhrases(text);
  }

  final fallbackMessage = Text("Sorry, no phrases for this word.");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPhrases(word),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return fallbackMessage;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text(
                  'Error:\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                );
              else if (snapshot.data == null)
                return fallbackMessage;
              else
                return PhrasesList(snapshot.data, word);
          }
        });
  }
}
