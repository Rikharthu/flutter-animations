import 'package:flutter/material.dart';

final sizeLogoKey = GlobalKey<_SizedLogoState>(debugLabel: "Size_logo");

class SizeTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simultaneous Animations")),
      body: Column(
        children: <Widget>[
          Expanded(child: SizedLogo(key: sizeLogoKey)),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Animate"),
              onPressed: () {
                sizeLogoKey.currentState.toggleAnimation();
              },
            ),
          )
        ],
      ),
    );
  }
}

class SizedLogo extends StatefulWidget {
  @override
  _SizedLogoState createState() => _SizedLogoState();

  SizedLogo({key: Key}) : super(key: key);
}

class _SizedLogoState extends State<SizedLogo>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 0.15, end: 1.0).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizeTransition(
        sizeFactor: animation,
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
