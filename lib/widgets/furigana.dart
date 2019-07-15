import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Furigana extends StatelessWidget {
  final double fontSize;
  final String kana;
  final String furigana;

  Furigana({@required this.kana, @required this.furigana, this.fontSize});

  Widget buildSingle(String furigana, String kana) {
    return Column(
      children: <Widget>[
        Text(
          furigana,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize * 2 / 3),
        ),
        Text(
          kana,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSingle(furigana, kana);
  }
}
