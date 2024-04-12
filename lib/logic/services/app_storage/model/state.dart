import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webspark_test/logic/utils/utils.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    AppSupportedLocale? language,
  }) = _AppState;

  factory AppState.fromJson(Map<String, Object?> json) => _$AppStateFromJson(json);
}
