import 'package:jisho/models/word.dart';

class Cache<T> {
  final _cache = Map<String, T>();

  T get(String term) => _cache[term];

  void set(String term, T result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
