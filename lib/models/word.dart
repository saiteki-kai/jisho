import 'dart:convert';
import 'package:equatable/equatable.dart';

class Word extends Equatable {
  String id;
  List<Pair> writings;
  List<Sense> senses;

  Word({this.id, this.writings, this.senses}) : super([id, writings, senses]);

  factory Word.fromRecord(String id, List<dynamic> records) {
    var pairs = Set<Pair>();
    var senses = Set<Sense>();

    for (var r in records) {
      pairs.add(
        Pair(
          Kana(
            text: r["kanji_text"],
            common: r["kanji_common"] == 1 ? true : false,
            tags: r["kanji_tags"] == null
                ? []
                : List<String>.from(jsonDecode(r["kanji_tags"])),
          ),
          Kana(
            text: r["kana_text"],
            common: r["kana_common"] == 1 ? true : false,
            tags: List<String>.from(jsonDecode(r["kana_tags"])),
          ),
        ),
      );

      senses.add(
        Sense(
          info: r["info"],
          dialect: List<String>.from(jsonDecode(r["dialect"])),
          field: List<String>.from(jsonDecode(r["field"])),
          misc: List<String>.from(jsonDecode(r["misc"])),
          partOfSpeech: List<String>.from(jsonDecode(r["partOfSpeech"])),
          gloss: List<String>.from(jsonDecode(r["gloss"])),
          languageSource: jsonDecode(r["languageSource"]),
        ),
      );
    }

    return Word(id: id, writings: pairs.toList(), senses: senses.toList());
  }

  factory Word.fromMap(Map<String, dynamic> map) => Word(
      id: map["text"],
      writings: List<Pair>.from(map["writings"]),
      senses: List<Sense>.from(map["sense"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "writings": writings,
        "senses": senses,
      };
}

class Pair extends Equatable {
  Kana kanji;
  Kana kana;

  Pair(this.kanji, this.kana) : super([kanji, kana]);

  @override
  String toString() {
    return "$kanji - $kana";
  }
}

class Kana extends Equatable {
  String text;
  bool common;
  List<String> tags;

  Kana({this.text, this.common, this.tags}) : super([text, common, tags]);

  factory Kana.fromMap(Map<String, dynamic> map) => Kana(
        text: map["text"],
        common: map["common"],
        tags: List<String>.from(map["tags"]),
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "common": common,
        "tags": tags,
      };

  @override
  String toString() {
    return 'Kana{text: $text}';
  }
}

class Sense extends Equatable {
  List<String> partOfSpeech;
  List<String> field;
  List<String> dialect;
  List<String> misc;
  List<String> gloss;
  String info;
  List<dynamic> languageSource;

  Sense({
    this.partOfSpeech,
    this.field,
    this.dialect,
    this.misc,
    this.gloss,
    this.info,
    this.languageSource,
  }) : super([partOfSpeech, field, dialect, misc, gloss, info, languageSource]);

  factory Sense.fromMap(Map<String, dynamic> map) => Sense(
        partOfSpeech: List<String>.from(map["partOfSpeech"]),
        field: List<String>.from(map["field"]),
        dialect: List<String>.from(map["dialect"]),
        misc: List<String>.from(map["misc"]),
        languageSource: List<dynamic>.from(map["languageSource"]),
        gloss: List<String>.from(map["gloss"]),
        info: map["info"],
      );

  Map<String, dynamic> toMap() => {
        "partOfSpeech": partOfSpeech,
        "field": field,
        "dialect": dialect,
        "misc": misc,
        "gloss": gloss,
        "info": info,
        "languageSource": languageSource,
      };
}
