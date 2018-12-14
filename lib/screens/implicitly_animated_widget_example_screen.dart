import 'package:flutter/material.dart';

class ImplicitlyAnimatedWidgetExampleScreen extends StatefulWidget {
  @override
  _AnimatedWidgetExampleScreenState createState() =>
      _AnimatedWidgetExampleScreenState();
}

class _AnimatedWidgetExampleScreenState
    extends State<ImplicitlyAnimatedWidgetExampleScreen>
    with SingleTickerProviderStateMixin {
  var isOpen = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Widget Example")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ImplicitlyAnimatedLogo(size: isOpen ? 300.0 : 0.0),
            ),
          ),
          RaisedButton(
            child: Text(isOpen ? "Shrink" : "Expand"),
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
          )
        ],
      ),
    );
  }
}

/*
 The idea behind ImplicitlyAnimatedWidget is that whenever the owning Widget
 changes its configuration, instead of that change happening immediately,
 the change is animated. So you need to start with the owning Widget having
 an opacity of 1.0, then you need to trigger something either with a Timer
 or a user interaction, and then you build that Widget with an opacity of, say,
 0.5 and the change should animate instead of happening immediately.
 */

class ImplicitlyAnimatedLogo extends ImplicitlyAnimatedWidget {
  final double size;

  @override
  ImplicitlyAnimatedLogoState createState() => ImplicitlyAnimatedLogoState();

  ImplicitlyAnimatedLogo({this.size})
      : super(duration: const Duration(milliseconds: 250));
}

class ImplicitlyAnimatedLogoState
    extends AnimatedWidgetBaseState<ImplicitlyAnimatedLogo> {
  Tween<double> _size;

  @override
  Widget build(BuildContext context) {
    final evaluatedValue = _size.evaluate(animation);
    print(
        // ignore: unnecessary_brace_in_string_interps
        "build: evaluated value=$evaluatedValue, animation value: ${animation.value}, _size: ${_size}");
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: _size.evaluate(animation),
        width: _size.evaluate(animation),
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    print("forEachTween");
    _size = visitor(_size, widget.size, (value) {
      print("visitor, value=$value");
      return Tween<double>(begin: value);
    });
  }
}

//class AnimatedLogo extends AnimatedWidget {
//  AnimatedLogo({Key key, Animation<double> animation})
//      : super(key: key, listenable: animation);
//
//  @override
//  Widget build(BuildContext context) {
//    // get current animation
//    final Animation<double> animation = listenable;
//    // AnimatedWidget uses the current value of animation when drawing itself
//    // Thus there is no need to call setState({})
//    return Center(
//      child: Container(
//        margin: EdgeInsets.symmetric(vertical: 10.0),
//        height: animation.value,
//        width: animation.value,
//        child: FlutterLogo(),
//      ),
//    );
//  }
//}
