class Japanese {
  static isKanji(int code) {
    return (code >= '\u4e00'.codeUnitAt(0) && code <= "\u9faf".codeUnitAt(0)) ||
           (code >= '\u3400'.codeUnitAt(0) && code <= "\u4dbf".codeUnitAt(0));
  }

  static isKana(int code) {
    return (code >= '\u3040'.codeUnitAt(0) && code <= '\u309f'.codeUnitAt(0)) ||
           (code >= '\u30a0'.codeUnitAt(0) && code <= '\u30ff'.codeUnitAt(0));
  }

  static bool hasKana(String text) {
    return text.codeUnits.any((code) => isKana(code));
  }

  static bool hasKanji(String text) {
    return text.codeUnits.any((code) => isKanji(code));
  }

  static List<String> getKanji(String text) {
    var codes = text.codeUnits.where((code) => isKanji(code)).toList();
    return codes.map((c) => String.fromCharCode(c)).toList();
  }
}
