import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'input_score.dart';

void main() {
  runApp(ProviderScope(child: const InputScore()));
}
