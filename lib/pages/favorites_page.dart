import 'package:flutter/material.dart';

import 'package:jisho/widgets/furigana.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jisho'),
        backgroundColor: Colors.red[400],
      ),
      body: Center(
        child: Furigana(
          fontSize: 40.0,
          kana: "時間外",
          furigana: "じかんがい",
        ),
      ),
    );
  }
}