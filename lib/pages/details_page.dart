import 'package:flutter/material.dart';

import 'package:jisho/model/word.dart';
import 'package:jisho/widgets/word_item.dart';

class DetailPage extends StatelessWidget {
  final Word word;

  DetailPage(this.word);

  // DBPedia, Frasi Tatoeba, Kanji Usati...

  Container wordWidget(Word word) =>
      new Container(child: Column(children: [WordItem(word), Text("DBPedia")]));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
              title: new Text(word.kanji[0].text),
              backgroundColor: Colors.red[400],
              bottom: TabBar(
                tabs: [
                  Tab(text: "WORD"),
                  Tab(text: "KANJI"),
                  Tab(text: "PHRASES"),
                ],
              )),
          body: TabBarView(
            children: [
              wordWidget(word),
              Text("kanji used in this word"),
              Text("example phrases"),
            ],
          ),
        ));
  }
}
