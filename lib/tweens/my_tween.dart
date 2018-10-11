import 'package:flutter/material.dart';

class MyTween extends Tween<String> {
  @override
  String evaluate(Animation<double> animation) {
    return animation.value.toString();
  }
}
