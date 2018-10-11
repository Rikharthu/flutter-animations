import 'package:flutter/material.dart';

class SimultaneousAnimationExampleScreen extends StatefulWidget {
  @override
  _SimultaneousAnimationExampleScreenState createState() =>
      _SimultaneousAnimationExampleScreenState();
}

class _SimultaneousAnimationExampleScreenState
    extends State<SimultaneousAnimationExampleScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simultaneous Animations")),
      body: AnimatedLogo(animation: animation),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // With only one animation we are animating two properties: opacity and size
    // with the help of separate tween, that manage how values between 0.0 and 1.0
    // are mapped
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
