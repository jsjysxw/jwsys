import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dayo/generated/i18n.dart';
import 'package:dayo/router/router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils.dart';

//隐私弹窗工具
class PrivacyUtils {
  PrivacyUtils._internal();

  //隐私服务政策地址
  static const PRIVACY_URL = 'https://LICENSE';

  static void showPrivacyDialog(BuildContext context,
      {VoidCallback onAgressCallback}) {
    Utils.getPackageInfo().then((packageInfo) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(I18n.of(context).reminder),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(I18n.of(context).welcome(packageInfo.appName)),
                  SizedBox(height: 5),
                  Text(I18n.of(context).welcome1),
                  SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: I18n.of(context).welcome2),
                    TextSpan(
                        text: I18n.of(context).privacyName(packageInfo.appName),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            XRouter.goWeb(
                                PRIVACY_URL,
                                I18n.of(context)
                                    .privacyName(packageInfo.appName));
                          }),
                    TextSpan(text: I18n.of(context).welcome3),
                  ])),
                  SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: I18n.of(context).welcome4),
                    TextSpan(
                        text: I18n.of(context).privacyName(packageInfo.appName),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            XRouter.goWeb(
                                PRIVACY_URL,
                                I18n.of(context)
                                    .privacyName(packageInfo.appName));
                          }),
                    TextSpan(text: I18n.of(context).welcome5),
                  ])),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(I18n.of(context).disagree),
                onPressed: () {
                  Navigator.of(context).pop();
                  showPrivacySecond(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
              TextButton(
                child: Text(I18n.of(context).agree),
                onPressed: onAgressCallback == null
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : onAgressCallback,
              ),
            ],
          );
        },
      );
    });
  }

  ///第二次提醒
  static void showPrivacySecond(BuildContext context,
      {VoidCallback onAgressCallback}) {
    Utils.getPackageInfo().then((packageInfo) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(I18n.of(context).reminder),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(I18n.of(context)
                      .privacyExplainAgain(packageInfo.appName)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(I18n.of(context).stillDisagree),
                onPressed: () {
                  Navigator.of(context).pop();
                  showPrivacyThird(context, onAgressCallback: onAgressCallback);
                },
              ),
              TextButton(
                child: Text(I18n.of(context).lookAgain),
                onPressed: () {
                  Navigator.of(context).pop();
                  showPrivacyDialog(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
            ],
          );
        },
      );
    });
  }

  ///第三次提醒
  static void showPrivacyThird(BuildContext context,
      {VoidCallback onAgressCallback}) {
    Utils.getPackageInfo().then((packageInfo) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(I18n.of(context).thinkAboutItAgain),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(I18n.of(context).exitApp),
                onPressed: () {
                  //退出程序
                  // SystemNavigator.pop();
                  exit(0);
                },
              ),
              TextButton(
                child: Text(I18n.of(context).lookAgain),
                onPressed: () {
                  Navigator.of(context).pop();
                  showPrivacyDialog(context,
                      onAgressCallback: onAgressCallback);
                },
              ),
            ],
          );
        },
      );
    });
  }

  ///第三次提醒
  static void showDia(BuildContext context, String notice,
      {VoidCallback onAgressCallback}) {
    Utils.getPackageInfo().then((packageInfo) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "公告",
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 8, right: 8),
                    child: Text(
                      notice,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                        "知道了",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
                ],
              )
            ],
          );
        },
      );
    });
  }

  ///第三次提醒
  static void showIosUpdate(BuildContext context, String url,
      {VoidCallback onAgressCallback}) {
    Utils.getPackageInfo().then((packageInfo) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("应用有更新，是否前往下载？"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("下次再说"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("立即更新"),
                onPressed: () {
                  // LaunchReview.launch();
                  launch(url);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }
}
