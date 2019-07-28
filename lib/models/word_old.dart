class Word {
  String id;
  List<Kanji> kanji;
  List<Kana> kana;
  List<Sense> sense;
  bool favorited;
  bool visited;

  Word({
    this.id,
    this.kanji,
    this.kana,
    this.sense,
    this.favorited,
    this.visited
  });

  factory Word.fromMap(Map<String, dynamic> map) => new Word(
      id: map["id"],
      kanji: map["kanji"] == null
          ? null
          : new List<Kanji>.from(map["kanji"].map((x) => Kanji.fromMap(x))),
      kana: map["kana"] == null
          ? null
          : new List<Kana>.from(map["kana"].map((x) => Kana.fromMap(x))),
      sense: map["sense"] == null
          ? null
          : new List<Sense>.from(map["sense"].map((x) => Sense.fromMap(x))),
      favorited: map["favorited"],
      visited: map["visited"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "kanji": kanji == null
            ? []
            : new List<dynamic>.from(kanji.map((x) => x.toMap())),
        "kana": kana == null
            ? []
            : new List<dynamic>.from(kana.map((x) => x.toMap())),
        "sense": sense == null
            ? []
            : new List<dynamic>.from(sense.map((x) => x.toMap())),
        "favorited": favorited,
        "visited": visited
      };
}

class Kana {
  bool common;
  String text;
  List<dynamic> tags;
  List<String> appliesToKanji;

  Kana({
    this.common,
    this.text,
    this.tags,
    this.appliesToKanji,
  });

  factory Kana.fromMap(Map<String, dynamic> map) => new Kana(
        common: map["common"],
        text: map["text"],
        tags: new List<dynamic>.from(map["tags"].map((x) => x)),
        appliesToKanji:
            new List<String>.from(map["appliesToKanji"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "common": common,
        "text": text,
        "tags": new List<dynamic>.from(tags.map((x) => x)),
        "appliesToKanji": new List<dynamic>.from(appliesToKanji.map((x) => x)),
      };
}

class Kanji {
  bool common;
  String text;
  List<String> tags;

  Kanji({
    this.common,
    this.text,
    this.tags,
  });

  factory Kanji.fromMap(Map<String, dynamic> map) => new Kanji(
        common: map["common"],
        text: map["text"],
        tags: new List<String>.from(map["tags"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "common": common,
        "text": text,
        "tags": new List<dynamic>.from(tags.map((x) => x)),
      };
}

class Sense {
  List<String> partOfSpeech;
  List<String> appliesToKanji;
  List<String> appliesToKana;
  List<List<dynamic>> related;
  List<dynamic> antonym;
  List<dynamic> field;
  List<dynamic> dialect;
  List<String> misc;
  List<String> info;
  List<dynamic> languageSource;
  List<Gloss> gloss;

  Sense({
    this.partOfSpeech,
    this.appliesToKanji,
    this.appliesToKana,
    this.related,
    this.antonym,
    this.field,
    this.dialect,
    this.misc,
    this.info,
    this.languageSource,
    this.gloss,
  });

  factory Sense.fromMap(Map<String, dynamic> map) => Sense(
        partOfSpeech: new List<String>.from(map["partOfSpeech"].map((x) => x)),
        appliesToKanji:
            new List<String>.from(map["appliesToKanji"].map((x) => x)),
        appliesToKana:
            new List<String>.from(map["appliesToKana"].map((x) => x)),
        related: new List<List<dynamic>>.from(
            map["related"].map((x) => new List<dynamic>.from(x.map((x) => x)))),
        antonym: new List<dynamic>.from(map["antonym"].map((x) => x)),
        field: new List<dynamic>.from(map["field"].map((x) => x)),
        dialect: new List<dynamic>.from(map["dialect"].map((x) => x)),
        misc: new List<String>.from(map["misc"].map((x) => x)),
        info: new List<String>.from(map["info"].map((x) => x)),
        languageSource:
            new List<dynamic>.from(map["languageSource"].map((x) => x)),
        gloss: new List<Gloss>.from(map["gloss"].map((x) => Gloss.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "partOfSpeech": new List<dynamic>.from(partOfSpeech.map((x) => x)),
        "appliesToKanji": new List<dynamic>.from(appliesToKanji.map((x) => x)),
        "appliesToKana": new List<dynamic>.from(appliesToKana.map((x) => x)),
        "related": new List<dynamic>.from(
            related.map((x) => new List<dynamic>.from(x.map((x) => x)))),
        "antonym": new List<dynamic>.from(antonym.map((x) => x)),
        "field": new List<dynamic>.from(field.map((x) => x)),
        "dialect": new List<dynamic>.from(dialect.map((x) => x)),
        "misc": new List<dynamic>.from(misc.map((x) => x)),
        "info": new List<dynamic>.from(info.map((x) => x)),
        "languageSource": new List<dynamic>.from(languageSource.map((x) => x)),
        "gloss": new List<dynamic>.from(gloss.map((x) => x.toMap())),
      };
}

class Gloss {
  String lang;
  String text;

  Gloss({
    this.lang,
    this.text,
  });

  factory Gloss.fromMap(Map<String, dynamic> map) => new Gloss(
        lang: map["lang"],
        text: map["text"],
      );

  Map<String, dynamic> toMap() => {
        "lang": lang,
        "text": text,
      };
}
