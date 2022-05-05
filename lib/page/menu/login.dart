import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dayo/core/http/http.dart';
import 'package:dayo/core/utils/privacy.dart';
import 'package:dayo/core/utils/toast.dart';
import 'package:dayo/core/widget/loading_dialog.dart';
import 'package:dayo/generated/i18n.dart';
import 'package:dayo/page/index.dart';
import 'package:dayo/page/menu/register.dart';
import 'package:dayo/utils/provider.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 响应空白处的焦点的Node
  bool _isShowPassWord = false;

  FocusNode blankNode = FocusNode();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // if (!SPUtils.isAgreePrivacy()) {
    //   PrivacyUtils.showPrivacyDialog(context, onAgressCallback: () {
    //     Navigator.of(context).pop();
    //     SPUtils.saveIsAgreePrivacy(true);
    //     ToastUtils.success(I18n.of(context).agreePrivacy);
    //   });
    // }

    _unameController.text = SPUtils.getNickName();

    getVersionNum();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          // appBar: AppBar(
          //   // leading: _leading(context),
          //   title: Text(
          //     I18n.of(context).login,
          //     style: TextStyle(fontSize: 19),
          //   ),
          //   centerTitle: true,
          //   // actions: <Widget>[
          //   //   TextButton(
          //   //     child: Text(I18n.of(context).register,
          //   //         style: TextStyle(color: Colors.white)),
          //   //     onPressed: () {
          //   //       Get.to(() => RegisterPage());
          //   //     },
          //   //   )
          //   // ],
          // ),
          body: GestureDetector(
            onTap: () {
              // 点击空白页面关闭键盘
              closeKeyboard(context);
            },
            child: SingleChildScrollView(
              // padding:
              //     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: buildForm(context),
            ),
          ),
        ),
        onWillPop: () async {
          return Future.value(true);
        });
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    // LocaleModel localeModel = Provider.of<LocaleModel>(context);
    // localeModel.locale = "zh_CN";
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        decoration: BoxDecoration(
          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
          image: new DecorationImage(
            image: AssetImage('assets/image/login_bg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
          color: Color(0xFFf6f6f6),
        ),
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 180, bottom: 36),
              height: 100,
              child: Image(
                image: AssetImage('assets/image/logo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            TextFormField(
                autofocus: false,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: I18n.of(context).loginName,
                    hintText: I18n.of(context).loginNameHint,
                    hintStyle: TextStyle(fontSize: 12),
                    icon: Icon(Icons.person)),
                //校验用户名
                validator: (v) {
                  return v.trim().length > 0
                      ? null
                      : I18n.of(context).loginNameError;
                }),
            TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: I18n.of(context).password,
                    hintText: I18n.of(context).passwordHint,
                    hintStyle: TextStyle(fontSize: 12),
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isShowPassWord
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: showPassWord)),
                obscureText: !_isShowPassWord,
                //校验密码
                validator: (v) {
                  return v.trim().length >= 6
                      ? null
                      : I18n.of(context).passwordError;
                }),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Builder(builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: Color(0xFF1A97F3)),
                      child: TextButton(
                        // style: TextButton.styleFrom(
                        //   primary: Theme.of(context).primaryColor,
                        //   // padding: EdgeInsets.all(15.0)
                        // ),
                        child: Text(I18n.of(context).login,
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                          if (Form.of(context).validate()) {
                            onSubmit(context);
                          }
                        },
                      ),
                    );
                  })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  var _version = "";
  var _buildNumber = "";
  getVersionNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version; //版本号
      _buildNumber = packageInfo.buildNumber; //版本构建号
    });
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            showContent: false,
            backgroundColor: Colors.black38,
            loadingView: SpinKitCircle(color: Colors.white),
          );
        });

    UserProfile userProfile = Provider.of<UserProfile>(context, listen: false);
    var version = "ios:";
    if (Platform.isAndroid) {
      version = "android:";
    }
    version = version + _buildNumber;
    print(version);
    XHttp.post("method=login", {
      "tel": _unameController.text,
      "password": _pwdController.text,
    }).then((response) {
      var response1 = jsonDecode(response);
      print(response1);
      Navigator.pop(context);
      if (response1["state"] == "1") {
        userProfile.nickName = response1['content']['tel'];
        userProfile.userId = response1['content']['user_id'];
        userProfile.webUserId = response1['content']['web_user_id'];
        userProfile.typeId = response1['content']['type_id'];
        userProfile.name = response1['content']['name'];
        // userProfile.notice = response1['content']['notice'];
        ToastUtils.toast(I18n.of(context).loginSuccess);
        Get.off(() => MainHomePage());
      } else {
        ToastUtils.error(response1['reason']);
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      ToastUtils.error(onError);
    });

    // userProfile.nickName = "123";
    // Navigator.pop(context);
    // ToastUtils.toast(I18n.of(context).loginSuccess);
    // Get.off(() => MainHomePage());
  }
}
