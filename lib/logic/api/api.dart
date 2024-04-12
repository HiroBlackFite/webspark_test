import 'package:injectable/injectable.dart';

import 'package:webspark_test/logic/api/custom_trace/custom_trace.dart';
import 'package:webspark_test/logic/api/roots/roots.dart';
import 'package:webspark_test/logic/models/models.dart';

@LazySingleton()
class Api {
  final CalculateClient _calculate;

  Api(
    this._calculate,
  );

  CalculateClient get calculate => _calculate;

  static AppError createParsingError(dynamic e, StackTrace stackTrace) {
    var error = '';
    try {
      final functionName = CustomTrace(stackTrace).functionName;
      error = '🛑🛑🛑PARSING_ERROR $functionName: $e🛑🛑🛑';

      return AppError.parsingModel(error);
    } catch (_) {
      error = '🛑🛑🛑PARSING_ERROR $e🛑🛑🛑';

      return AppError.parsingModel(error);
    }
  }
}
