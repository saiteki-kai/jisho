import 'package:flutter/material.dart';

import 'package:jisho/models/kanji.dart';

class KanjiItem extends StatelessWidget {
  final Kanji kanji;
  KanjiItem(this.kanji);

  get radicals => kanji.radicals.map((r) => r.radValue);
  get meanings => kanji.meanings.map((m) => m.meaning).join(", ");
  get onReadings => kanji.readings
      .where((r) => r.rType == 'ja_on')
      .map((r) => r.reading)
      .join(", ");
  get kunReadings => kanji.readings
      .where((r) => r.rType == 'ja_kun')
      .map((r) => r.reading)
      .join(", ");
  get jlpt => kanji.jlpt == null ? "" : "\nJLPT N${kanji.jlpt}";
  get grade => kanji.grade == null ? "" : "\ngrade ${kanji.grade}";
  get variant => kanji.variant == null ? "" : kanji.variant.variant;

  @override
  Widget build(BuildContext context) {
    // TODO: radicals
    print(radicals);
    print(variant);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  kanji.literal,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "strokes: ${kanji.strokeCount}$jlpt$grade",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ],
        ),
        Text("$meanings\n"),
        Text("Kun: $kunReadings"),
        Text("On: $onReadings"),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
