import 'package:flutter/material.dart';

final slideLogoKey = GlobalKey<_SlidedLogoState>(debugLabel: "slide_logo");

class SlideTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simultaneous Animations")),
      body: Column(
        children: <Widget>[
          Expanded(child: SlidedLogo(key: slideLogoKey)),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Animate"),
              onPressed: () {
                slideLogoKey.currentState.toggleAnimation();
              },
            ),
          )
        ],
      ),
    );
  }
}

class SlidedLogo extends StatefulWidget {
  @override
  _SlidedLogoState createState() => _SlidedLogoState();

  SlidedLogo({key: Key}) : super(key: key);
}

class _SlidedLogoState extends State<SlidedLogo>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: Offset(0, 0), end: Offset(1, -0.5)).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: animation,
        child: FlutterLogo(
          size: 100.0,
        ),
      ),
    );
  }

  void toggleAnimation() {
    if (animation.status == AnimationStatus.completed) {
      controller.reverse();
    } else if (animation.status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }
}
