library petitparser.core.characters.digit;

import 'package:petitparser/src/core/characters/parser.dart';
import 'package:petitparser/src/core/characters/predicate.dart';
import 'package:petitparser/src/core/parser.dart';

/// Returns a parser that accepts any digit character.
Parser<String> digit([String message = 'digit expected']) {
  return CharacterParser(const DigitCharPredicate(), message);
}

class DigitCharPredicate implements CharacterPredicate {
  const DigitCharPredicate();

  @override
  bool test(int value) => 48 <= value && value <= 57;
}
