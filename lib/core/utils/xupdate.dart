import 'dart:io';

import 'package:dayo/core/utils/toast.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';

///版本更新工具
class XUpdate {
  XUpdate._internal();

  ///版本更新检查的地址
  static const String UPDATE_URL = "https://www.dayo.net.cn/jw/ver.txt";
  static const String DOWNLOAD_URL = "";

  static void initAndCheck() {
    if (Platform.isAndroid) {
      init(url: UPDATE_URL);
    }
  }

  ///初始化XUpdate
  static void init({String url = ""}) {
    FlutterXUpdate.init(
            debug: true,
            enableRetry: false,
            retryContent: "下载失败，是否考虑重新下载？",
            retryUrl: DOWNLOAD_URL)
        .then((_result) {
      if (url.isNotEmpty) {
        checkUpdate(url);
      }
    });
    FlutterXUpdate.setErrorHandler(
        onUpdateError: (Map<String, dynamic> message) async {
      ///2004是无最新版本
      if (message['code'] != 2004) {
        ToastUtils.error("无版本");

        ///4000是下载失败
        if (message['code'] == 4000) {
          FlutterXUpdate.showRetryUpdateTipDialog(
              retryContent: "下载失败，是否考虑重新下载？", retryUrl: DOWNLOAD_URL);
        } else {
          ToastUtils.error(message['detailMsg']);
        }
      }
    });
  }

  ///初始化XUpdate
  static void checkUpdate(String url) {
    if (url != null && url.isNotEmpty) {
      FlutterXUpdate.checkUpdate(url: url, widthRatio: 0.7);
    }
  }

  ///初始化XUpdate
  static void checkUpdateWithErrorTip({String url = UPDATE_URL}) {
    FlutterXUpdate.setErrorHandler(
        onUpdateError: (Map<String, dynamic> message) async {
      ///4000是下载失败
      if (message['code'] == 4000) {
        FlutterXUpdate.showRetryUpdateTipDialog(
            retryContent: "下载失败，是否考虑重新下载？", retryUrl: DOWNLOAD_URL);
      } else {
        ToastUtils.error(message['message']);
      }
    });
    checkUpdate(url);
  }
}
