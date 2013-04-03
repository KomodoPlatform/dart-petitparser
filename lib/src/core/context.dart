// Copyright (c) 2013, Lukas Renggli <renggli@gmail.com>

part of petitparser;

/**
 * An immutable parse context.
 */
class Context {

  final dynamic _buffer;
  final int _position;

  const Context(this._buffer, this._position);

  /** The buffer we are working on. */
  dynamic get buffer => _buffer;

  /** The current position in the buffer. */
  int get position => _position;

  /** Returns a result indicating a parse success. */
  Result success(dynamic result, [int position]) {
    return new Success(_buffer, position == null ? _position : position, result);
  }

  /** Returns a result indicating a parse failure. */
  Result failure(String message, [int position]) {
    return new Failure(_buffer, position == null ? _position : position, message);
  }

  /** Returns a human readable string of the current context */
  String toString() => 'Context[$_position]';

}

/**
 * An immutable parse result.
 */
abstract class Result extends Context {

  const Result(buffer, position) : super(buffer, position);

  /** Returns [true] if this result indicates a parse success. */
  bool get isSuccess => false;

  /** Returns [true] if this result indicates a parse failure. */
  bool get isFailure => false;

  /** Returns the parse result of the current context. */
  dynamic get result;

  /** Returns the parse message of the current context. */
  String get message;

}

/**
 * An immutable parse result in case of a successful parse.
 */
class Success extends Result {

  final dynamic _result;

  const Success(buffer, position, this._result) : super(buffer, position);

  bool get isSuccess => true;

  dynamic get result => _result;

  String get message => null;

  String toString() => 'Success[$_position]: $_result';

}

/**
 * An immutable parse result in case of a failed parse.
 */
class Failure extends Result {

  final String _message;

  const Failure(buffer, position, this._message) : super(buffer, position);

  bool get isFailure => true;

  dynamic get result { throw new ParserError(this); }

  String get message => _message;

  String toString() => 'Failure[$_position]: $_message';

}

/**
 * An exception raised in case of a parse error.
 */
class ParserError implements Error {

  final Failure _failure;

  ParserError(this._failure);

  Failure get failure => _failure;

  String toString() => '${_failure.message} at ${_failure.position}';

}