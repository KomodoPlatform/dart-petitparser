library petitparser.core.characters.range;

import 'package:petitparser/src/core/characters/code.dart';
import 'package:petitparser/src/core/characters/parser.dart';
import 'package:petitparser/src/core/characters/predicate.dart';
import 'package:petitparser/src/core/parser.dart';

/// Returns a parser that accepts any character in the range
/// between [start] and [stop].
Parser range(Object start, Object stop, [String message]) {
  return new CharacterParser(new RangeCharPredicate(toCharCode(start), toCharCode(stop)),
      message ?? '$start..$stop expected');
}

class RangeCharPredicate implements CharacterPredicate {
  final int start;
  final int stop;

  const RangeCharPredicate(this.start, this.stop);

  @override
  bool test(int value) => start <= value && value <= stop;
}
