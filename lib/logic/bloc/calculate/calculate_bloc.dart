import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:webspark_test/logic/api/api.dart';
import 'package:webspark_test/logic/models/models.dart';

part 'calculate_event.dart';
part 'calculate_state.dart';
part 'calculate_bloc.freezed.dart';

@singleton
class CalculateBloc extends Bloc<CalculateEvent, CalculateState> {
  final Api _api;
  late Emitter<CalculateState> _emit;

  CalculateBloc(this._api) : super(const CalculateState.initial(CalculateData())) {
    on<CalculateEvent>(
      (event, emit) async {
        _emit = emit;
        await event.when(
          init: _init,
          getData: _getData,
          sendResultingData: _sendResultingData,
        );
      },
    );
  }

  Future<void> _init() async {
    _emit(const CalculateState.initial(CalculateData()));
  }

  Future<void> _getData(String path) async {
    _emit(CalculateState.loading(state.data.copyWith(isLoading: true)));
    final response = await _api.calculate.getData(path);

    response.fold(
      _handleError,
      (data) {
        _emit(
          CalculateState.getDataSuccess(
            state.data.copyWith(
              isLoading: false,
              error: null,
              data: data,
              link: path,
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendResultingData(List<ResultingData> data) async {
    _emit(CalculateState.loading(state.data.copyWith(isLoading: true)));
    final response =
        await _api.calculate.sendResultingData(path: state.data.link ?? '', data: data);

    response.fold(
      _handleError,
      (_) {
        _emit(
          CalculateState.sendResultingDataSuccess(
            state.data.copyWith(
              isLoading: false,
              error: null,
              resultingData: data,
            ),
          ),
        );
      },
    );
  }

  void _handleError(AppError error) => _emit(
        CalculateState.error(state.data.copyWith(
          error: error,
          isLoading: false,
        )),
      );
}
