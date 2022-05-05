import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:dayo/core/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart' as gg;
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage();
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _latitude = ""; //纬度
  String _longitude = ""; //经度
  String _address = "";

  //监听定位
  StreamSubscription<Map<String, Object>> _locationListener;
  //实例化插件
  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  // //先不使用定位功能
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   requestPermission();
  //   AMapFlutterLocation.updatePrivacyAgree(true);
  //   AMapFlutterLocation.updatePrivacyShow(true, true);
  //   AMapFlutterLocation.setApiKey(
  //       "6fbb444ad3dd82e23ce577b915a2e8f1", "9f1faedf233f8d6864515015175e9976");

  //   ///注册定位结果监听
  //   _locationListener = _locationPlugin
  //       .onLocationChanged()
  //       .listen((Map<String, Object> result) {
  //     setState(() {
  //       print(result);
  //       print("-----");
  //       print(result is Map);
  //       // _locationResult = result;
  //       _latitude = result["latitude"].toString();
  //       _longitude = result["longitude"].toString();
  //       _address = result["address"].toString();
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();

  //   ///移除定位监听
  //   if (null != _locationListener) {
  //     _locationListener.cancel();
  //   }

  //   ///销毁定位
  //   if (null != _locationPlugin) {
  //     _locationPlugin.destroy();
  //   }
  // }

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = false;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  ///  申请定位权限  授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String url = gg.Get.parameters['url'];

    return WebviewScaffold(
      url: url,
      withLocalStorage: true,
      withJavascript: true,
      resizeToAvoidBottomInset: true,
      hidden: true,
      key: _scaffoldKey,
      javascriptChannels: [
        // js代码
        //   if(window.hasOwnProperty('closePage')){
        //     window.closePage.postMessage("关闭页面");
        // }
        JavascriptChannel(
            name: 'closePage',
            onMessageReceived: (JavascriptMessage message) {
              print(message.message);
              Navigator.of(context).pop();
            }),
        JavascriptChannel(
            name: 'takepic',
            onMessageReceived: (JavascriptMessage message) {
              getImage();
            }),
        JavascriptChannel(
            name: 'getLocation',
            onMessageReceived: (JavascriptMessage message) async {
              this._startLocation();
              await Future.delayed(Duration(seconds: 1), () {
                var barcode =
                    "经度:${this._longitude}||纬度:${this._latitude}||地址:${this._address}";

                print(barcode);
                //flutter调用js
                final flutterWebViewPlugin = FlutterWebviewPlugin();
                final future = flutterWebViewPlugin
                    .evalJavascript("address_add('" + barcode + "')");
                future.then((String result) {
                  print('调用js后的返回值...');
                });
              });
            }),
        JavascriptChannel(
            name: 'shareUrl',
            onMessageReceived: (JavascriptMessage message) {
              Share.share(message.message);
            }),
      ].toSet(),
      appBar: AppBar(
        title: Text(gg.Get.parameters['title'], style: TextStyle(fontSize: 15)),
        titleSpacing: 0,
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.share),
          //     onPressed: () {
          //       Share.share(url);
          //     }),
        ],
      ),
    );
  }

// //这里是js调用flutter
//   final Set<JavascriptChannel> jsChannels = [
//     JavascriptChannel(
//         name: 'closePage',
//         onMessageReceived: (JavascriptMessage message) {
//           print(message.message);
//           Navigator.of(_context).pop();
//         }),
//     JavascriptChannel(
//         name: 'getLocation',
//         onMessageReceived: (JavascriptMessage message) {
//           var barcode = "经度||维度||地址";
//           //flutter调用js
//           final flutterWebViewPlugin = FlutterWebviewPlugin();
//           final future = flutterWebViewPlugin
//               .evalJavascript("address_add('" + barcode + "')");
//           future.then((String result) {
//             print('调用js后的返回值...');
//           });
//         }),
//   ].toSet();

//签到拍照
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    print("=============99"); //打印图片路径，用于调试
    //创建picker对象，用于调用摄像机拍照或者录像
    var image = await picker.getImage(source: ImageSource.camera);

    //刷新界面
    setState(() {
      if (image != null) {
        _image = File(image.path); //创建文件对像
        print(image.path); //打印图片路径，用于调试
        _uploadImage(_image); //上传图片到服务器
      } else {
        print('没有图片');
      }
    });
  }

  //上传图片方法
  _uploadImage(File _imageDir) async {
    var fileDir = _imageDir.path; //图片路径
    //post参数，这里只上传文件upload为文件参数名
    FormData formData =
        FormData.fromMap({"file": await MultipartFile.fromFile(fileDir)});
    //发起post请求上传文件
    var response = await Dio()
        .post(XHttp.Web_Base_Url + "common_upload.php", data: formData);
    // print("===${response.toString()}"); //打印响应结果
    final flutterWebViewPlugin = FlutterWebviewPlugin();
    // print("filename_add('" + response.toString() + "')");
    final future = flutterWebViewPlugin
        .evalJavascript("filename_add('" + response.toString() + "')");
    future.then((String result) {
      print('调用js后的返回值...');
    });
  }

//文件上传
// filename_add

}
