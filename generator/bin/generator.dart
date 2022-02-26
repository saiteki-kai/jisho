import 'dart:convert';
import 'dart:io';

import 'package:generator/objectbox.g.dart';
import 'package:generator/word.dart';

Future<List<WordEntry>> getWordEntries() async {
  final file = await File('../data/dst/words.json').readAsString();
  var data = jsonDecode(file);

  final entries = <WordEntry>[];

  for (dynamic word in data) {
    final id = word["ent_seq"][0];

    // skip last entry
    if (id == "9999999") continue;

    final wordEntry = WordEntry(id: int.parse(id));

    final kanji = <Kanji>[];

    if (word["k_ele"] != null) {
      word["k_ele"].forEach((ke) {
        var kePri = ke["ke_pri"];
        var common = false;
        if (kePri != null && kePri is List) {
          common = kePri.isNotEmpty;
        }

        kanji.add(Kanji(
          text: ke["keb"][0],
          info: List<String>.from(ke["ke_inf"] ?? []),
          common: common,
        ));
      });
    }

    final readings = <Reading>[];

    word["r_ele"].forEach((re) {
      var rePri = re["re_pri"];
      var common = false;
      if (rePri != null && rePri is List) {
        common = rePri.isNotEmpty;
      }

      readings.add(Reading(
        text: re["reb"][0],
        info: List<String>.from(re["re_inf"] ?? []),
        restrictedTo: List<String>.from(re["re_restr"] ?? []),
        common: common,
      ));
    });

    final senses = <Sense>[];
    word["sense"].forEach((se) {
      final sense = Sense(
        pos: se["pos"].join(", "),
        related: List<String>.from(se["xref"] ?? []), // capire
        antonym: List<String>.from(se["ant"] ?? []),
        field: List<String>.from(se["field"] ?? []), // resolve acronyms
        dialect: List<String>.from(se["dial"] ?? []), // resolve acronyms
        misc: List<String>.from(se["misc"] ?? []), // resolve acronyms
        info: List<String>.from(se["s_inf"] ?? []),
        stagk: List<String>.from(se["stagk"] ?? []), // only applies to kanji
        stagr: List<String>.from(se["stagr"] ?? []), // only applies to stagr
        // languageSource: null,
      );

      final glosses = se["gloss"].map<Gloss>((ge) {
        return Gloss(type: ge["type"], text: ge["text"]);
      }).toList();

      sense.gloss.addAll(glosses.isNotEmpty ? glosses : null);

      senses.add(sense);
    });

    if (kanji.isNotEmpty) wordEntry.kanji.addAll(kanji);
    if (readings.isNotEmpty) wordEntry.reading.addAll(readings);
    if (senses.isNotEmpty) wordEntry.sense.addAll(senses);

    entries.add(wordEntry);
  }

  return Future.value(entries);
}

void main(List<String> args) async {
  List<WordEntry> words = await getWordEntries();

  Store _store = openStore();
  _store.box<WordEntry>().putMany(words);
}
