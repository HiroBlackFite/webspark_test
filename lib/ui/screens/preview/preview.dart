import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/bloc/bloc.dart';
import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/ui/widgets/widget.dart';

class PreviewScreen extends StatefulWidget {
  final String id;
  const PreviewScreen({
    super.key,
    required this.id,
  });

  static const name = 'preview';
  static const path = '/$name/:id';

  static String route(String id) {
    return '/$name/$id';
  }

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  CalculateBloc get _calculateBloc => context.read<CalculateBloc>();
  CalculateData get _calculateData => _calculateBloc.state.data;

  ResultingData get _resultingData => _calculateData.resultingDataById(widget.id);
  Grid get _grid => _calculateData.gridById(widget.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: LocaleKeys.previewScreen_appBar,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            AppGrid(
              grid: _grid.getGrid,
              start: _grid.start,
              end: _grid.end,
              path: _resultingData.result.steps,
            ),
            Text(_resultingData.result.path),
          ],
        ),
      ),
    );
  }
}
