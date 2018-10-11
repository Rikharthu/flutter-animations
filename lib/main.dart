import 'package:animations/screens/animated_builder_example_screen.dart';
import 'package:animations/screens/animated_widget_example_screen.dart';
import 'package:animations/screens/animation_example_screen.dart';
import 'package:animations/screens/implicitly_animated_widget_example_screen.dart';
import 'package:animations/screens/simultaneous_animations_example_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => MenuScreen(),
        "/sandbox": (context) => Sandbox(),
        "/example1": (context) => AnimationExampleScreen(),
        "/example2": (context) => AnimatedWidgetExampleScreen(),
        "/example3": (context) => AnimatedBuilderExampleScreen(),
        "/example4": (context) => SimultaneousAnimationExampleScreen(),
        "/example5": (context) => ImplicitlyAnimatedWidgetExampleScreen(),
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations"),
      ),
      body: Column(
        children: <Widget>[
          MenuListItem(
              title: "Cat in a box",
              onTap: () {
                Navigator.of(context).pushNamed("/sandbox");
              }),
          MenuListItem(
              title: "Example 1",
              onTap: () {
                Navigator.of(context).pushNamed("/example1");
              }),
          MenuListItem(
              title: "Animated Widget",
              onTap: () {
                Navigator.of(context).pushNamed("/example2");
              }),
          MenuListItem(
              title: "Animated Builder",
              onTap: () {
                Navigator.of(context).pushNamed("/example3");
              }),
          MenuListItem(
              title: "Simultaneous animations",
              onTap: () {
                Navigator.of(context).pushNamed("/example4");
              }),
          MenuListItem(
              title: "Implicitly animated widget",
              onTap: () {
                Navigator.of(context).pushNamed("/example5");
              }),
        ],
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  VoidCallback onTap;
  String title;

  MenuListItem({this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          title: Container(
            width: double.infinity,
            height: 50.0,
            child: Center(child: Text(title)),
          ),
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}

class Sandbox extends StatefulWidget {
  @override
  _SandboxState createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with TickerProviderStateMixin {
  // Linearly produces numbers form 0.0 to 1.0 during a given duration
  // Allows controlling animations (start/stop/etc)
  AnimationController _controller;

  // Knows it's current value and statue
  Animation<double> _animation;

  // Will fully animate from 0 to 1 when controller's value >0.5 and <0.75 (will fully animate in a given interval)
  // Can be used to delay animations
  Curve curve = Interval(0.5, .75, curve: Curves.easeOut);

  // AnimationController ranges from 0.0 to 1.0.
  // Tween allows to specify different range/data type to interpolate over
  // It only maps input to according output
  // It's evaluate() function applies the mapping to the current value of the animation
  Tween<double> tween;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    tween = new Tween(begin: 0.0, end: 100.0);
    _animation = tween.animate(_controller)..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final value = curve.transform(_controller.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("SandBox"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child:
                Text("Animation value: ${_animation.value.toStringAsFixed(2)}"),
          ),
          Container(
            child: Text("Curve value: ${value.toStringAsFixed(2)}"),
          ),
          Container(
            child: Text(
                "Controller value: ${_controller.value.toStringAsFixed(2)}"),
          ),
          RaisedButton(
            onPressed: () {
              _controller.forward();
            },
            child: Text("Start animation"),
          ),
        ],
      ),
    );
  }
}
