import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/bloc/bloc.dart';
import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/ui/screens/screens.dart';
import 'package:webspark_test/ui/widgets/widget.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({super.key});

  static const name = 'result_list';
  static const route = '/$name';

  @override
  State<ResultListScreen> createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  CalculateBloc get _calculateBloc => context.read<CalculateBloc>();
  CalculateData get _calculateData => _calculateBloc.state.data;

  List<ResultingData> get _resultingData => _calculateData.resultingData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: LocaleKeys.resultListScreen_appBar,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => context.push(PreviewScreen.route(_resultingData[index].id)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                _resultingData[index].result.path,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.withOpacity(0.5),
          );
        },
        itemCount: _resultingData.length,
      ),
    );
  }
}
