import 'package:flutter/material.dart';
import 'package:jisho/data/repository.dart';

import 'package:jisho/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho/blocs/word_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Repository.get().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => WordBloc(),
      child: MaterialApp(
        home: SearchPage(),
        locale: Locale("ja", "JP"),
      ),
    );
  }
}
