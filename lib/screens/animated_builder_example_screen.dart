import 'package:flutter/material.dart';

/*
An AnimatedBuilder understands how to render the transition.

An AnimatedBuilder doesn’t know how to render the widget, nor does it manage the Animation object.

Use AnimatedBuilder to describe an animation as part of a build method for another widget.
If you simply want to define a widget with a reusable animation, use AnimatedWidget.

Examples of AnimatedBuilders in the Flutter API:
BottomSheet, ExpansionTile, PopupMenu, ProgressIndicator,
RefreshIndicator, Scaffold, SnackBar, TabBar, TextField.
 */

class AnimatedBuilderExampleScreen extends StatefulWidget {
  @override
  _AnimatedBuilderExampleScreenState createState() =>
      _AnimatedBuilderExampleScreenState();
}

class _AnimatedBuilderExampleScreenState
    extends State<AnimatedBuilderExampleScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Builder Example")),
      body: GrowTransition(child: LogoWidget(), animation: animation),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: FlutterLogo(),
    );
  }
}
