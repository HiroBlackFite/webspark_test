part of 'calculate_bloc.dart';

@freezed
class CalculateEvent with _$CalculateEvent {
  const factory CalculateEvent.init() = _Init;

  const factory CalculateEvent.getData(String path) = _GetData;

  const factory CalculateEvent.sendResultingData(List<ResultingData> data) = _SendResultingData;
}
