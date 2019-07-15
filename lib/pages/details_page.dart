import 'package:flutter/material.dart';

import 'package:jisho/models/word.dart';
import 'package:jisho/widgets/word/word_item.dart';
import 'package:jisho/widgets/kanji/kanji_tab.dart';
import 'package:jisho/widgets/phrases/phrases_tab.dart';

class DetailPage extends StatelessWidget {
  final Word word;

  DetailPage(this.word);

  // TODO: DBPedia

  Container wordWidget(Word word) => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              WordItem(word),
              Text("DBPedia"),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _title = "";
    if (word.kanji.length > 0) {
      _title = word.kanji[0].text;
    } else {
      _title = word.kana[0].text;
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          backgroundColor: Colors.red[400],
          bottom: TabBar(
            tabs: [
              Tab(text: "WORD"),
              Tab(text: "KANJI"),
              Tab(text: "PHRASES"),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            wordWidget(word),
            KanjiTab(word),
            PhrasesTab(_title),
          ],
        ),
      ),
    );
  }
}
