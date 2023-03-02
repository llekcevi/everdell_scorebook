import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelIconButton extends StatelessWidget {
  final BuildContext buildContext;
  final StateNotifierProvider provider;

  const CancelIconButton(
      {Key? key,
      required this.buildContext,
      required this.ref,
      required this.provider})
      : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(buildContext).popUntil((route) => route.isFirst);
        ref.refresh(provider);
      },
      icon: const Icon(Icons.cancel),
    );
  }
}
