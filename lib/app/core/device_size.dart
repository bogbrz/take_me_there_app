import 'package:flutter/material.dart';

class DeviceSize {
  BuildContext context;

  DeviceSize(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}