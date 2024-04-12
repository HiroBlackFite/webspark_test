part of 'calculate_bloc.dart';

@freezed
class CalculateState with _$CalculateState {
  const factory CalculateState.initial(CalculateData data) = _Initial;
  const factory CalculateState.loading(CalculateData data) = _Loading;

  const factory CalculateState.error(CalculateData data) = _Error;

  const factory CalculateState.getDataSuccess(CalculateData data) = _GetDataSuccess;
  const factory CalculateState.sendResultingDataSuccess(CalculateData data) =
      _SendResultingDataSuccess;
}

@freezed
class CalculateData with _$CalculateData {
  const CalculateData._();

  const factory CalculateData({
    @Default([]) List<Grid> data,
    @Default([]) List<ResultingData> resultingData,
    String? link,
    AppError? error,
    @Default(false) bool isLoading,
  }) = _CalculateData;

  ResultingData resultingDataById(String id) => resultingData.firstWhere(
        (element) => element.id == id,
      );

  Grid gridById(String id) => data.firstWhere(
        (element) => element.id == id,
      );
}
