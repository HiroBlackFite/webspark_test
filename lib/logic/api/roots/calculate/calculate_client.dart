import 'package:dartz/dartz.dart';

import 'package:webspark_test/logic/models/models.dart';

abstract class CalculateClient {
  Future<Either<AppError, List<Grid>>> getData(String path);
  Future<Either<AppError, dynamic>> sendResultingData({
    required String path,
    required List<ResultingData> data,
  });
}
