import 'dart:math' as math;

import 'package:flutter/material.dart';

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(t * math.pi * 2);
  }
}
