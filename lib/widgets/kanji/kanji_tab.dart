import 'package:flutter/material.dart';

import 'package:jisho/widgets/kanji/kanji_list.dart';
import 'package:jisho/data/kanji_dao.dart';
import 'package:jisho/utils/japanese.dart';
import 'package:jisho/models/word.dart';

class KanjiTab extends StatelessWidget {
  final Word word;
  KanjiTab(this.word);

  getKanji(list) async {
    return await KanjiDao().getKanjiList(list);
  }

  final fallbackMessage = Text("No Kanji");

  @override
  Widget build(BuildContext context) {
    if (word.writings.length > 0 && word.writings[0].kanji != null) {
      var set = Set<String>();
      for (var k in word.writings) {
        var a = Japanese.getKanji(k.kanji.text);
        set.addAll(a);
      }

      return Container(
        child: FutureBuilder(
          future: getKanji(set.toList()),
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
                  return KanjiList(snapshot.data);
            }
          },
        ),
      );
    } else {
      return Container(child: Center(child: fallbackMessage));
    }
  }
}
