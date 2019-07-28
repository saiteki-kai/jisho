import 'dart:convert';

class Kanji {
  String literal;
  int freq;
  int grade;
  int jlpt;
  int strokeCount;
  Variant variant;
  List<String> meanings;
  List<Radical> radicals;
  List<String> kunReadings;
  List<String> onReadings;

  Kanji({
    this.freq,
    this.grade,
    this.jlpt,
    this.literal,
    this.meanings,
    this.radicals,
    this.kunReadings,
    this.onReadings,
    this.strokeCount,
    this.variant,
  });

  factory Kanji.fromRecord(Map<String, dynamic> map) => Kanji(
        freq: map["freq"],
        grade: map["grade"],
        jlpt: map["jlpt"],
        literal: map["literal"],
        strokeCount: map["stroke_count"],
        meanings: map["meanings"] == null
            ? []
            : List<String>.from(jsonDecode(map["meanings"])),
        radicals: map["radicals"] == null
            ? []
            : List<Radical>.from(
                jsonDecode(map["radicals"]).map((x) => Radical.fromMap(x))),
        kunReadings: map["kun_readings"] == null
            ? []
            : List<String>.from(jsonDecode(map["kun_readings"])),
        onReadings: map["on_readings"] == null
            ? []
            : List<String>.from(jsonDecode(map["on_readings"])),
        variant: map["variant"] == null
            ? null
            : Variant.fromMap(jsonDecode(map["variant"])),
      );

  factory Kanji.fromMap(Map<String, dynamic> map) => Kanji(
        freq: map["freq"],
        grade: map["grade"],
        jlpt: map["jlpt"],
        literal: map["literal"],
        strokeCount: map["stroke_count"],
        meanings:
            map["meanings"] == null ? [] : List<String>.from(map["meanings"]),
        radicals: map["radicals"] == null
            ? []
            : List<Radical>.from(
                map["radicals"].map((x) => Radical.fromMap(x))),
        kunReadings: map["kun_readings"] == null
            ? []
            : List<String>.from(map["kun_readings"]),
        onReadings: map["on_readings"] == null
            ? []
            : List<String>.from(map["on_readings"]),
        variant:
            map["variant"] == null ? null : Variant.fromMap(map["variant"]),
      );

  Map<String, dynamic> toMap() => {
        "freq": freq,
        "grade": grade,
        "jlpt": jlpt,
        "literal": literal,
        "meanings": List<String>.from(meanings),
        "radicals": List<Radical>.from(radicals.map((x) => x.toMap())),
        "kun_readings": List<String>.from(kunReadings),
        "on_readings": List<String>.from(onReadings),
        "stroke_count": strokeCount,
        "variant": variant == null ? null : variant.toMap(),
      };
}

class Radical {
  String radType;
  int radValue;

  Radical({
    this.radType,
    this.radValue,
  });

  factory Radical.fromMap(Map<String, dynamic> map) => Radical(
        radType: map["rad_type"],
        radValue: map["rad_value"],
      );

  Map<String, dynamic> toMap() => {
        "rad_type": radType,
        "rad_value": radValue,
      };
}

class Variant {
  String varType;
  String variant;

  Variant({
    this.varType,
    this.variant,
  });

  factory Variant.fromMap(Map<String, dynamic> map) => Variant(
        varType: map["var_type"],
        variant: map["variant"],
      );

  Map<String, dynamic> toMap() => {
        "var_type": varType,
        "variant": variant,
      };
}
