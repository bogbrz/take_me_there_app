import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:take_me_there_app/app/core/device_size.dart';

class Providers {}

final isWritingProvider = StateProvider<bool>((ref) => false);

final isTypingProvider = StateProvider<bool>((ref) => false);

final searchingProvider = StateProvider<bool>((ref) => false);
final focusNumberProvider = StateProvider<int>((ref) => 1);

final bottomPanelControllerProvider = StateProvider<PanelController>((ref) {
  return PanelController();
});
final textValueProvider = StateProvider<String>(
  (ref) => '',
);
final topPanelControllerProvider = StateProvider<PanelController>((ref) {
  return PanelController();
});
final destinationTextControllerProvider =
    StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final lenghtProvider = StateProvider<double>((ref) => 0);
final panelHeightProvider = StateProvider<double>((ref) => 600);
