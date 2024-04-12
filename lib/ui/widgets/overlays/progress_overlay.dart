import 'package:flutter/material.dart';

class ProgressOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ProgressOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        IgnorePointer(
          ignoring: !isLoading,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            color: isLoading ? Colors.black.withOpacity(0.6) : Colors.transparent,
            child: Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
