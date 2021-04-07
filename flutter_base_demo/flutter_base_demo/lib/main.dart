import 'package:flutter/material.dart';
import 'package:flutter_base_demo/hero_page.dart';
import 'package:flutter_base_demo/hero_page2.dart';
import 'package:flutter_base_demo/logo_page.dart';
import 'package:flutter_base_demo/logo_page2.dart';
import 'package:flutter_base_demo/logo_page3.dart';
import 'package:flutter_base_demo/photo_app_page.dart';
import 'package:flutter_base_demo/plugin_use.dart';
import 'package:flutter_base_demo/res_page.dart';
import 'package:flutter_base_demo/statefull_group_page.dart';
import 'package:flutter_base_demo/stateless_group_page.dart';

import 'app_lifecycle.dart';
import 'flutter_layout_page.dart';
import 'flutter_widget_lifecycle.dart';
import 'gesture_page.dart';
import 'launch_page.dart';

void main() {
  runApp(DynamicTheme());
}

class DynamicTheme extends StatefulWidget {
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  ///动态修改主题
  Brightness _brightness = Brightness.light;

  ///字体下载地址：https://fonts.google.com/specimen/Rubik+Mono+One?selection.family=Rubik+Mono+One
  ///更多参考：https://flutter.dev/docs/cookbook/design/fonts
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //fontFamily: 'RubikMonoOne',//将该字体应用到全局
          brightness: _brightness,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('如何创建和使用Flutter的路由与导航？'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (_brightness == Brightness.dark) {
                          _brightness = Brightness.light;
                        } else {
                          _brightness = Brightness.dark;
                        }
                      });
                    },

                    ///局部设置字体
                    child: Text(
                      '切换主题abc',
                      style: TextStyle(fontFamily: 'RubikMonoOne'),
                    ),
                  ),
                  RouteNavigator()
                ],
              ),
            )),

        ///路由方式指定要跳转的页面
        routes: <String, WidgetBuilder>{
          'plugin': (BuildContext context) => PluginUse(),
          'less': (BuildContext context) => LessGroupPage(),
          'ful': (BuildContext context) => StatefulGroup(),
          'layout': (BuildContext context) => FlutterLayoutPage(),
        });
  }
}

class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
              title: Text('${byName ? '' : '不'}通过路由名跳转'),
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _item('如何使用Flutter包和插件？', PluginUse(), 'plugin'),
          _item('StatelessWidget与基础组件', LessGroupPage(), 'less'),
          _item('StatefulWidget与基组件', StatefulGroup(), 'ful'),
          _item('如何进行Flutter布局开发', FlutterLayoutPage(), 'layout'),
          _item('如何检测用户手势以及处理点击事件？', GesturePage(), 'gesture'),
          _item('导入和使用Flutter的资源文件', ResPage(), 'res'),
          _item('如何打开第三方应用？', LaunchPage(), 'launch'),
          _item('Flutter页面生命周期', WidgetLifecycle(), 'widgetLifecycle'),
          _item('Flutter应用生命周期', AppLifecycle(), 'appLifecycle'),
          _item('【实战尝鲜】拍照APP开发', PhotoApp(), 'photo'),
          _item('动画入门--Logo', LogoPage(), 'logo'),
          _item('动画简化1--Logo', LogoPage2(), 'logo2'),
          _item('动画简化2--Logo', LogoPage3(), 'logo3'),
          _item('Hero动画', HeroAnimation(), 'hero'),
          _item('Hero径向动画', RadialExpansionDemo(), 'hero2'),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            ///透过路由名跳转
            Navigator.pushNamed(context, routeName);
          } else {
            ///路由器直接跳转
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
