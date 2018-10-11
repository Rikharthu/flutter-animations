import 'package:flutter/material.dart';

class AnimationExampleScreen extends StatefulWidget {
  @override
  _AnimationExampleScreenState createState() => _AnimationExampleScreenState();
}

class _AnimationExampleScreenState extends State<AnimationExampleScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        // Every time animation generates a new number, call setState() to rebuild
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      })
      ..addStatusListener((newStatus) {
        if (newStatus == AnimationStatus.completed) {
          controller.reverse();
        } else if (newStatus == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Use current animation values to build UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation example"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
