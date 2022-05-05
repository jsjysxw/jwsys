import 'package:flutter/material.dart';
import 'package:dayo/core/widget/web_view_page.dart';
import 'package:dayo/init/splash.dart';
import 'package:dayo/page/index.dart';
import 'package:dayo/page/menu/about.dart';
import 'package:dayo/page/menu/login.dart';
import 'package:dayo/page/menu/settings.dart';
import 'package:get/get.dart';

class RouteMap {
  static List<GetPage> getPages = [
    GetPage(name: '/', page: () => SplashPage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/home', page: () => MainHomePage()),
    GetPage(name: '/web', page: () => WebViewPage()),
    GetPage(name: '/menu/settings-page', page: () => SettingsPage()),
    GetPage(name: '/menu/about-page', page: () => AboutPage()),
  ];

  /// 页面切换动画
  static Widget getTransitions(
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
              //1.0为右进右出，-1.0为左进左出
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }
}
