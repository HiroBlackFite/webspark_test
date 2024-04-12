import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:webspark_test/logic/api/api.dart';
import 'package:webspark_test/logic/api/client/api_client.dart';
import 'package:webspark_test/logic/api/roots/calculate/calculate_client.dart';
import 'package:webspark_test/logic/models/models.dart';

@LazySingleton(as: CalculateClient)
class APICategoriesClient implements CalculateClient {
  final ApiClient _api;

  APICategoriesClient(this._api);

  @override
  Future<Either<AppError, List<Grid>>> getData(String path) async {
    final response = await _api.fetch(path: path, type: FetchType.get);

    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          final response = List.from(r['data']);
          return Right(response.map((e) => Grid.fromJson(e)).toList());
        } catch (error) {
          log('$error');
          return Left(Api.createParsingError(error, StackTrace.current));
        }
      },
    );
  }

  @override
  Future<Either<AppError, dynamic>> sendResultingData({
    required String path,
    required List<ResultingData> data,
  }) async {
    final json = jsonEncode(data.map((e) => e.toJson()).toList());
    return await _api.fetch(path: path, type: FetchType.post, data: json);
  }
}
