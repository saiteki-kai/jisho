import 'package:flutter/material.dart';

import 'package:jisho/widgets/furigana.dart';

class SettingsPage extends StatelessWidget {
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
