import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/bloc/bloc.dart';
import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/logic/mixins/mixins.dart';
import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/logic/services/services.dart';
import 'package:webspark_test/ui/screens/screens.dart';
import 'package:webspark_test/ui/widgets/widget.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  static const name = 'process';
  static const route = '/$name';

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> with RouteAware, RootRouterAware {
  CalculateBloc get _calculateBloc => context.read<CalculateBloc>();
  CalculateData get _calculateData => _calculateBloc.state.data;

  double _progress = 0;
  List<ResultingData> _resultingData = [];

  @override
  void initState() {
    _calculate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculateBloc, CalculateState>(
      listenWhen: (_, __) => listenWhen,
      listener: _calculateBlocListener,
      builder: (context, state) {
        return ProgressOverlay(
          isLoading: state.data.isLoading,
          child: Scaffold(
            appBar: const AppHeader(
              title: LocaleKeys.processScreen_appBar,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: context.screen.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_progress == 1) ...[
                      const Text(
                        LocaleKeys.processScreen_calculateResultText,
                        textAlign: TextAlign.center,
                      ).tr(),
                      const SizedBox(height: 10),
                    ],
                    AppCircularPercentIndicator(
                      percent: _progress,
                      center: Text('${(_progress * 100)}'.removeTrailingZeros() + '%'),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _progress == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: AppButtons.primary(
                      title: LocaleKeys.processScreen_sendButton,
                      onPressed: _onSendResults,
                      width: context.screen.width,
                      isActive: !state.data.isLoading,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  void _calculateBlocListener(BuildContext context, CalculateState state) {
    state.whenOrNull(
      error: (data) => errorHandler(context, error: data.error),
      sendResultingDataSuccess: (data) => context.push(ResultListScreen.route),
    );
  }

  void _calculate(BuildContext context) async {
    try {
      final data = _calculateData.data;
      var resData = <ResultingData>[];

      for (var element in data) {
        final aStar = AStar(
          grid: element.getGrid,
          start: Node(element.start.x, element.start.y),
          goal: Node(element.end.x, element.end.y),
        );
        final path = aStar.findPath();

        resData.add(_nodesToResultingData(id: element.id, path: path));

        setState(() {
          _progress = resData.length / data.length;
        });
      }

      setState(() {
        _resultingData = resData;
      });
    } catch (e) {
      errorHandler(context);
    }
  }

  ResultingData _nodesToResultingData({
    required String id,
    required List<Node> path,
  }) {
    final steps = path.map((e) => Cell(x: e.x, y: e.y)).toList();
    final formattingPath = path.map((e) => '(${e.x},${e.y})').toList().join('->');

    final result = ResultingPath(
      steps: steps,
      path: formattingPath,
    );

    return ResultingData(
      id: id,
      result: result,
    );
  }

  void _onSendResults() {
    if (_resultingData.isNotEmpty) {
      _calculateBloc.add(CalculateEvent.sendResultingData(_resultingData));
    }
  }
}
