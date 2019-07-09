import 'package:flutter/material.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/models/word.dart';
import 'package:jisho/widgets/word_list.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  Future<List<Word>> history() async =>
      await Repository.get().getVisitedWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Jisho'), backgroundColor: Colors.red[400]),
        body: FutureBuilder(
            future: history(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) return Text("Loading...");
              return WordList(snapshot.data);
            }));
  }
}
