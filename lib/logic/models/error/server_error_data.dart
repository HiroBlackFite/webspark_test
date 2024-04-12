import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error_data.freezed.dart';
part 'server_error_data.g.dart';

@freezed
class ServerError with _$ServerError {
  const factory ServerError.internalServerError(ServerErrorData error) = _InternalServerError;
  const factory ServerError.tooManyRequests(ServerErrorData error) = _TooManyRequests;
  const factory ServerError.badRequests(ServerErrorData error) = _BadRequests;
}

@freezed
class ServerErrorData with _$ServerErrorData {
  const factory ServerErrorData({
    int? statusCode,
    String? message,
  }) = _ServerErrorData;

  factory ServerErrorData.fromJson(Map<String, dynamic> json) => _$ServerErrorDataFromJson(json);
}

class ServerErrorCods {
  const ServerErrorCods._();

  static const badRequests = 400;
  static const tooManyRequests = 429;
  static const internalServerError = 500;
}
