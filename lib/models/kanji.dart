class Kanji {
  String literal;
  int freq;
  int grade;
  int jlpt;
  int strokeCount;
  Variant variant;
  List<Meaning> meanings;
  List<Radical> radicals;
  List<Reading> readings;

  Kanji({
    this.freq,
    this.grade,
    this.jlpt,
    this.literal,
    this.meanings,
    this.radicals,
    this.readings,
    this.strokeCount,
    this.variant,
  });

  factory Kanji.fromMap(Map<String, dynamic> map) => new Kanji(
    freq: map["freq"],
    grade: map["grade"],
    jlpt: map["jlpt"],
    literal: map["literal"],
    meanings: new List<Meaning>.from(map["meanings"].map((x) => Meaning.fromMap(x))),
    radicals: new List<Radical>.from(map["radicals"].map((x) => Radical.fromMap(x))),
    readings: new List<Reading>.from(map["readings"].map((x) => Reading.fromMap(x))),
    strokeCount: map["stroke_count"],
    variant: map["variant"] == null ? null : Variant.fromMap(map["variant"]),
  );

  Map<String, dynamic> toMap() => {
    "freq": freq,
    "grade": grade,
    "jlpt": jlpt,
    "literal": literal,
    "meanings": new List<dynamic>.from(meanings.map((x) => x.toMap())),
    "radicals": new List<dynamic>.from(radicals.map((x) => x.toMap())),
    "readings": new List<dynamic>.from(readings.map((x) => x.toMap())),
    "stroke_count": strokeCount,
    "variant": variant == null ? null : variant.toMap(),
  };
}

class Meaning {
  String meaning;

  Meaning({
    this.meaning,
  });

  factory Meaning.fromMap(Map<String, dynamic> map) => new Meaning(
    meaning: map["meaning"],
  );

  Map<String, dynamic> toMap() => {
    "meaning": meaning,
  };
}

class Radical {
  String radType;
  int radValue;

  Radical({
    this.radType,
    this.radValue,
  });

  factory Radical.fromMap(Map<String, dynamic> map) => new Radical(
    radType: map["rad_type"],
    radValue: map["rad_value"],
  );

  Map<String, dynamic> toMap() => {
    "rad_type": radType,
    "rad_value": radValue,
  };
}

class Reading {
  String rType;
  String reading;

  Reading({
    this.rType,
    this.reading,
  });

  factory Reading.fromMap(Map<String, dynamic> map) => new Reading(
    rType: map["r_type"],
    reading: map["reading"],
  );

  Map<String, dynamic> toMap() => {
    "r_type": rType,
    "reading": reading,
  };
}

class Variant {
  String varType;
  String variant;

  Variant({
    this.varType,
    this.variant,
  });

  factory Variant.fromMap(Map<String, dynamic> map) => new Variant(
    varType: map["var_type"],
    variant: map["variant"],
  );

  Map<String, dynamic> toMap() => {
    "var_type": varType,
    "variant": variant,
  };
}
