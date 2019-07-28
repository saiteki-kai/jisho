import 'package:flutter/material.dart';

import 'package:jisho/data/history_dao.dart';
import 'package:jisho/models/word.dart';
import 'package:jisho/widgets/word/word_list.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<Word>> history() async => await HistoryDao().getHistory();

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: history(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
                return Center(child: Text("Loading..."));
              return WordList(snapshot.data);
            },
          ),
        )
      ],
    );
  }
}
