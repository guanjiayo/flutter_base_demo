import 'package:flutter/material.dart';

/// AnimatedBuilder 简化 Animation 写法

/// 用于将显示动画的widget的几个职责分离
/// 显示logo
/// 定义Animation对象
/// 渲染过渡效果

// #docregion LogoWidget
class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}
// #enddocregion LogoWidget

class GrowTransition extends StatelessWidget {
  GrowTransition({Key key, this.animation, this.child}) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
          child: child,
        ),
      );
}

class LogoPage3 extends StatefulWidget {
  @override
  _LogoPageState3 createState() => _LogoPageState3();
}

class _LogoPageState3 extends State<LogoPage3>
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
  Widget build(BuildContext context) => GrowTransition(
        child: LogoWidget(),
        animation: animation,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
