import 'package:flutter/material.dart';

import 'package:jisho/widgets/furigana.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Furigana(
        fontSize: 40.0,
        kana: "時間外",
        furigana: "じかんがい",
      ),
    );
  }
}
