import 'package:flutter/material.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/word/word_list.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final repository = Repository.get();

  // TODO: add date headers
  // TODO: possible settings (by day, by week, by month)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('History', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: repository.getHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null)
                  return Center(child: Text("Loading..."));
                return WordList(snapshot.data);
              },
            ),
          )
        ],
      ),
    );
  }
}
