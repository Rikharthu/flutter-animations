import 'package:flutter/material.dart';

class ScaleTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simultaneous Animations")),
      body: ScaledLogo(),
    );
  }
}

class ScaledLogo extends StatefulWidget {
  @override
  _ScaledLogoState createState() => _ScaledLogoState();
}

class _ScaledLogoState extends State<ScaledLogo>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 1.0, end: 2.0).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: animation,
        child: FlutterLogo(size: 100.0,),
      ),
    );
  }
}
