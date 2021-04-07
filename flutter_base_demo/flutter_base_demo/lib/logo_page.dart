import 'package:flutter/material.dart';

/// Animation 入门写法
class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage>
    with SingleTickerProviderStateMixin {
  ///创建动画两要素 animation 和 controller
  ///动画还可以插入除 double 以外的类型，比如 Animation<Color> 或者 Animation<Size>。
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationState;
  double animationValue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        /// 添加setState的调用这样才能触发页面重新渲染，动画才能有效
        setState(() {
          animationValue = animation.value;
        });
        // #docregion addListener
      })
      ..addStatusListener((status) {
        setState(() {
          animationState = status;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Text(
              'Start',
              textDirection: TextDirection.ltr,
              style: textStyle,
            ),
          ),
          Text(
            'State:' + animationState.toString(),
            textDirection: TextDirection.ltr,
            style: textStyle,
          ),
          Text(
            'Value:' + animationValue.toString(),
            textDirection: TextDirection.ltr,
            style: textStyle,
          ),
          Container(
            height: animation.value,
            width: animation.value,
            child: FlutterLogo(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
