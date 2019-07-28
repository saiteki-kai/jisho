import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho/bloc/bloc.dart';

import 'package:jisho/widgets/word/word_list.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  WordBloc _wordBloc;

  _message() => Container(
        child: Center(
          child: Text(
            "辞書",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              fontSize: 120.0,
            ),
          ),
        ),
      );

  updateSearch(value) {
    print("update: $value");
    _wordBloc.dispatch(LoadWords(value));
  }

  clearSearch() {
    _wordBloc.dispatch(WaitForSearch());
  }

  @override
  void initState() {
    super.initState();

    _wordBloc = BlocProvider.of<WordBloc>(context);
    _wordBloc.dispatch(WaitForSearch());
  }

  @override
  void dispose() {
    _wordBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: BlocBuilder(
            bloc: _wordBloc,
            builder: (BuildContext context, WordState state) {
              switch (state.runtimeType) {
                case WordsLoading:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  );
                case WordsLoaded:
                  return WordList((state as WordsLoaded).words);
                case Waiting:
                default:
                  return _message();
              }
            },
          ),
        )
      ],
    );
  }
}
