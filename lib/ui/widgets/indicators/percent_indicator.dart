import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:webspark_test/logic/extensions/extensions.dart';

class AppCircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double percent;
  final Widget? center;
  const AppCircularPercentIndicator({
    super.key,
    this.radius = 60,
    required this.percent,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      percent: percent,
      animation: true,
      animateFromLastPercent: true,
      progressColor: context.colorScheme.primary,
      center: center,
    );
  }
}
