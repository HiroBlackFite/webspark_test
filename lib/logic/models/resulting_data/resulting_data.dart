import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webspark_test/logic/models/models.dart';

part 'resulting_data.freezed.dart';
part 'resulting_data.g.dart';

@freezed
class ResultingData with _$ResultingData {
  const factory ResultingData({
    required String id,
    required ResultingPath result,
  }) = _ResultingData;

  factory ResultingData.fromJson(Map<String, Object?> json) => _$ResultingDataFromJson(json);
}

@freezed
class ResultingPath with _$ResultingPath {
  const factory ResultingPath({
    required List<Cell> steps,
    required String path,
  }) = _ResultingPath;

  factory ResultingPath.fromJson(Map<String, Object?> json) => _$ResultingPathFromJson(json);
}
