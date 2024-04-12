import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:webspark_test/logic/api/api.dart';
import 'package:webspark_test/logic/api/client/dio.dart';
import 'package:webspark_test/logic/models/models.dart';

enum FetchType { get, post, put, delete }

@singleton
class ApiClient {
  final AppDio _dio;

  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  const ApiClient(this._dio);

  Future<Either<AppError, Map<String, dynamic>>> fetch({
    required String path,
    required FetchType type,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? baseUrl,
  }) async {
    final options_ = options ?? Options(headers: defaultHeaders);
    Response<dynamic> response;
    try {
      switch (type) {
        case FetchType.get:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
            options: options_,
          );
          break;
        case FetchType.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options_,
          );
          break;
        case FetchType.put:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options_,
          );
          break;
        case FetchType.delete:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options_,
          );
          break;
      }
    } on SocketException catch (_) {
      return const Left(AppError.noInternetConnection());
    } on DioException catch (error) {
      return _handleDioError(error);
    }

    return Right(_getResponseData(response));
  }

  Map<String, dynamic> _getResponseData(Response? response) {
    if (response != null) {
      if (response.data is String) {
        return {'': response.data};
      }

      if (response.data is List) {
        return {'data': response.data};
      }

      return response.data as Map<String, dynamic>;
    }

    return {};
  }

  Either<AppError, Map<String, dynamic>> _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Left(AppError.timeout());
      case DioExceptionType.badResponse:
        try {
          final serverError = ServerErrorData(
            statusCode: error.response?.statusCode ?? 0,
            message: error.response?.data['message'],
          );

          switch (serverError.statusCode) {
            case ServerErrorCods.tooManyRequests:
              return Left(AppError.server(ServerError.tooManyRequests(serverError)));
            case ServerErrorCods.internalServerError:
              return Left(AppError.server(ServerError.internalServerError(serverError)));
            case ServerErrorCods.badRequests:
              return Left(AppError.server(ServerError.badRequests(serverError)));
            default:
              return Left(AppError.unhandledError(error));
          }
        } catch (e) {
          return Left(Api.createParsingError(e, StackTrace.current));
        }
      case DioExceptionType.unknown:
        if (error.message!.contains('SocketException')) {
          return const Left(AppError.noInternetConnection());
        }
        return Left(AppError.unhandledError(error));
      default:
        return Left(AppError.unhandledError(error));
    }
  }
}
