import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:take_me_there_app/app/core/device_size.dart';

final isWritingProvider = StateProvider<bool>((ref) => false);

final isTypingProvider = StateProvider<bool>((ref) => false);

final bottomPanelControllerProvider = StateProvider<PanelController>((ref) {
  return PanelController();
});

final topPanelControllerProvider = StateProvider<PanelController>((ref) {
  return PanelController();
});
final destinationTextControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final lenghtProvider = StateProvider<double>((ref) => 0);
