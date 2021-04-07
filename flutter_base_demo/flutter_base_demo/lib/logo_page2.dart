import 'package:flutter/material.dart';

/// AnimatedWidget 简化 Animation 写法

/// 在不使用AnimatedWidget的情况下需要手动调用动画的addListener()并在回调中添加setState才能看到动画效果，
/// 而AnimatedWidget将为我们简化这一操作
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    print("animation 动画状态   ${animation.status}");
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class LogoPage2 extends StatefulWidget {
  @override
  _LogoPageState2 createState() => _LogoPageState2();
}

class _LogoPageState2 extends State<LogoPage2>
    with SingleTickerProviderStateMixin {
  ///创建动画两要素 animation 和 controller
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationState;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation,);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
