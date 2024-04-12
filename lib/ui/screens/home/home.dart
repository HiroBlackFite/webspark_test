import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:webspark_test/localization/locale_keys.g.dart';
import 'package:webspark_test/logic/bloc/bloc.dart';
import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/logic/mixins/mixins.dart';
import 'package:webspark_test/logic/services/services.dart';
import 'package:webspark_test/ui/screens/screens.dart';
import 'package:webspark_test/ui/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = 'home';
  static const route = '/$name';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware, RootRouterAware {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _baseUrlController = TextEditingController();

  CalculateBloc get _calculateBloc => context.read<CalculateBloc>();

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
              title: LocaleKeys.homeScreen_appBar,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    LocaleKeys.homeScreen_title,
                    style: context.textTheme.bodyLarge,
                  ).tr(),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField.baseUrl(
                            controller: _baseUrlController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  AppButtons.primary(
                    title: LocaleKeys.homeScreen_startButton,
                    onPressed: _onStart,
                    width: context.screen.width,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _calculateBlocListener(BuildContext context, CalculateState state) {
    state.whenOrNull(
      error: (data) {
        errorHandler(context, error: data.error);
      },
      getDataSuccess: (data) => context.push(ProcessScreen.route),
    );
  }

  void _onStart() {
    final valid = _formKey.currentState?.validate() ?? false;

    if (valid) {
      _calculateBloc.add(CalculateEvent.getData(_baseUrlController.text));
    }
  }
}
