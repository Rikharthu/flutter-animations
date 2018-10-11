import 'package:flutter/material.dart';

class AnimatedWidgetExampleScreen extends StatefulWidget {
  @override
  _AnimatedWidgetExampleScreenState createState() =>
      _AnimatedWidgetExampleScreenState();
}

class _AnimatedWidgetExampleScreenState
    extends State<AnimatedWidgetExampleScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Widget Example")),
      body: AnimatedLogo(animation: animation),
    );
  }

  // AnimationController needs to be disposed along with state
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

/*
AnimatedWidget can be used to create a reusable animation

The AnimatedWidget class allows you to separate out the widget code from the
animation code in the setState() call. AnimatedWidget doesn’t need to maintain
a State object to hold the animation.


 */
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // get current animation
    final Animation<double> animation = listenable;
    // AnimatedWidget uses the current value of animation when drawing itself
    // Thus there is no need to call setState({})
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
