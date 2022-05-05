import 'dart:convert';
import 'dart:io';

import 'package:dayo/core/http/http.dart';
import 'package:dayo/page/home/tab_my.dart';
import 'package:dayo/page/home/tab_notice.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:dio/dio.dart' as dio_index;
import 'package:flutter/material.dart';
import 'package:dayo/core/utils/click.dart';
import 'package:dayo/core/utils/privacy.dart';
import 'package:dayo/core/utils/toast.dart';
import 'package:dayo/core/utils/xupdate.dart';
import 'package:dayo/generated/i18n.dart';
import 'package:dayo/page/home/tab_home.dart';
import 'package:dayo/utils/provider.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'home/tab_notify.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _MainHomePageState extends State<MainHomePage> {
  List<BottomNavigationBarItem> getTabs(BuildContext context) => [
        BottomNavigationBarItem(label: "主页", icon: Icon(Icons.home)),
        // BottomNavigationBarItem(
        //     label: I18n.of(context).category, icon: Icon(Icons.list)),
        // BottomNavigationBarItem(
        //     label: I18n.of(context).activity, icon: Icon(Icons.local_activity)),
        BottomNavigationBarItem(label: "通知", icon: Icon(Icons.notifications)),
        BottomNavigationBarItem(label: "我的", icon: Icon(Icons.person)),
      ];

  List<Widget> getTabWidget(BuildContext context) => [
        TabHomePage(),
        // Center(child: Text(I18n.of(context).category)),
        // Center(child: Text(I18n.of(context).activity)),

        TabNotifyPage(),
        // Center(child: Text(I18n.of(context).message)),
        // Center(child: Text(I18n.of(context).profile)),
        TabMyPage()
      ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    XUpdate.initAndCheck();

    // String notice = SPUtils.getNotice();
    // if (notice != null && notice != "") {
    //   PrivacyUtils.showDia(context, notice, onAgressCallback: () {});
    // }

    // getVersionNum();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getPermission();

    var tabs = getTabs(context);
    return Consumer(
        builder: (BuildContext context, AppStatus status, Widget child) {
      return WillPopScope(
          child: Scaffold(
            key: _scaffoldKey,
            body: IndexedStack(
              index: status.tabIndex,
              children: getTabWidget(context),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: tabs,
              //高亮  被点击高亮
              currentIndex: status.tabIndex,
              //修改 页面
              onTap: (index) {
                status.tabIndex = index;
              },
              type: BottomNavigationBarType.fixed,
              fixedColor: Theme.of(context).primaryColor,
            ),
          ),
          //监听导航栏返回,类似onKeyEvent
          onWillPop: () =>
              ClickUtils.exitBy2Click(status: _scaffoldKey.currentState));
    });
  }

  getPermission() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
    ].request();
    print("1111111");
  }

  getVersionNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var _buildNumber = packageInfo.buildNumber; //版本构建号
    iosUpdate(_buildNumber);
  }

  iosUpdate(_buildNumber) {
    if (Platform.isIOS) {
      get("ver_ios.txt", {}).then((response) {
        var response1 = jsonDecode(response);
        print(response1);
        var number = response1['VersionCode'];
        print(number);
        int versionCode = int.parse(number.toString());

        int buildNumber = int.parse(_buildNumber.toString());
        print("versionCode is $versionCode");
        print("buildNumber is $buildNumber");
        if (versionCode > buildNumber) {
          PrivacyUtils.showIosUpdate(context, response1['DownloadUrl'],
              onAgressCallback: () {});
        }
      }).catchError((onError) {
        ToastUtils.error(onError);
      });
    }
  }

  dio_index.Dio dio = dio_index.Dio(dio_index.BaseOptions(
    baseUrl: "https://www.dayo.net.cn/jw/",
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ));

  ///get请求
  Future get(String url, [Map<String, dynamic> params]) async {
    dio_index.Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }
}
