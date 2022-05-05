import 'dart:convert';

import 'package:dayo/utils/sputils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dayo/core/http/http.dart';
import 'package:dayo/core/utils/toast.dart';
import 'package:dayo/core/widget/loading_dialog.dart';
import 'package:dayo/generated/i18n.dart';

class MotifyPwdPage extends StatefulWidget {
  @override
  _MotifyPwdPageState createState() => _MotifyPwdPageState();
}

class _MotifyPwdPageState extends State<MotifyPwdPage> {
  // 响应空白处的焦点的Node
  bool _isShowPassWord_old = false;
  bool _isShowPassWord = false;
  bool _isShowPassWordRepeat = false;
  FocusNode blankNode = FocusNode();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwdRepeatController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "密码重置",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          closeKeyboard(context);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: buildForm(context),
        ),
      ),
    );
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: <Widget>[
          // TextFormField(
          //     autofocus: false,
          //     controller: _unameController,
          //     decoration: InputDecoration(
          //         labelText: I18n.of(context).loginName,
          //         hintText: I18n.of(context).loginNameHint,
          //         hintStyle: TextStyle(fontSize: 12),
          //         icon: Icon(Icons.person)),
          //     //校验用户名
          //     validator: (v) {
          //       return v.trim().length > 0
          //           ? null
          //           : I18n.of(context).loginNameError;
          //     }),

          TextFormField(
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: "旧密码",
                  hintText: "请输入旧密码",
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isShowPassWord_old
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: showOldPassWord)),
              obscureText: !_isShowPassWord_old,
              //校验密码
              validator: (v) {
                return v.trim().length >= 6
                    ? null
                    : I18n.of(context).passwordError;
              }),

          TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "新密码",
                  hintText: "请输入新密码",
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

          TextFormField(
              controller: _pwdRepeatController,
              decoration: InputDecoration(
                  labelText: "重复新密码",
                  hintText: "请再次输入新密码",
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isShowPassWordRepeat
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: showPassWordRepeat)),
              obscureText: !_isShowPassWordRepeat,
              //校验密码
              validator: (v) {
                return v.trim() == _pwdController.text.trim()
                    ? null
                    : "两次密码输入不一样";
              }),

          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Builder(builder: (context) {
                  return ElevatedButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(15.0)),
                    child: Text("密码重置", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                      if (Form.of(context).validate()) {
                        onSubmit(context);
                      }
                    },
                  );
                })),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///点击控制密码是否显示
  void showOldPassWord() {
    setState(() {
      _isShowPassWord_old = !_isShowPassWord_old;
    });
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  ///点击控制密码是否显示
  void showPassWordRepeat() {
    setState(() {
      _isShowPassWordRepeat = !_isShowPassWordRepeat;
    });
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return LoadingDialog(
    //         showContent: false,
    //         backgroundColor: Colors.black38,
    //         loadingView: SpinKitCircle(color: Colors.white),
    //       );
    //     });

    XHttp.post("method=change_password", {
      "user_id": SPUtils.getUserId(),
      "old_password": _unameController.text,
      "new_password": _pwdRepeatController.text
    }).then((response) {
      var response1 = jsonDecode(response);
      print(response1);
      if (response1["state"] == "1") {
        ToastUtils.toast("修改成功");
        Navigator.of(context).pop();
      } else {
        ToastUtils.error(response1['reason']);
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      ToastUtils.error(onError);
    });
  }
}
