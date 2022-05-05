import 'package:dayo/core/http/http.dart';
import 'package:dayo/page/menu/login.dart';
import 'package:dayo/page/menu/motifypwd.dart';
import 'package:dayo/router/router.dart';
import 'package:dayo/utils/provider.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class TabMyPage extends StatefulWidget {
  @override
  _TabMyPageState createState() => _TabMyPageState();
}

class _TabMyPageState extends State<TabMyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersionNum();
  }

  var _version = "";
  getVersionNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version; //版本号
    });

    // String buildNumber = packageInfo.buildNumber; //版本构建号
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        image: new DecorationImage(
          image: AssetImage('assets/image/my_bg.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
        color: Color(0xFFf6f6f6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [getavatar(), getFunc()],
      ),
    );
  }

  Widget getavatar() {
    return Container(
      margin: EdgeInsets.only(top: 45),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: 100,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Image(
                image: AssetImage('assets/image/main_avatar.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      SPUtils.getName(),
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "电话：${SPUtils.getNickName()}",
                      maxLines: 3,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget getFunc() {
    return Column(
      children: [
        // Container(
        //   margin: EdgeInsets.only(top: 25, left: 30, right: 30),
        //   decoration: BoxDecoration(
        //       //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        //       borderRadius: BorderRadius.all(Radius.circular(12.0)),
        //       color: Colors.white),
        //   child: Column(
        //     children: [
        //       // 商机统计
        //       InkWell(
        //         onTap: () {
        //           XRouter.goWeb(
        //               XHttp.Web_Base_Url + "display/chance.php", "商机统计");
        //         },
        //         child: Row(
        //           children: <Widget>[
        //             Container(
        //               margin: EdgeInsets.symmetric(vertical: 10),
        //               padding: EdgeInsets.only(left: 20, right: 10),
        //               height: 36,
        //               child: AspectRatio(
        //                 aspectRatio: 1.2,
        //                 child: Image(
        //                   image: AssetImage('assets/image/my_sjtj.png'),
        //                   fit: BoxFit.contain,
        //                 ),
        //               ),
        //             ),
        //             // Expanded(
        //             //   flex: 1,
        //             //   child: Container(
        //             //       padding:
        //             //           EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        //             //       child: Column(
        //             //         crossAxisAlignment: CrossAxisAlignment.start,
        //             //         children: <Widget>[
        //             //           Text(
        //             //             "商机统计",
        //             //             maxLines: 3,
        //             //             style: TextStyle(
        //             //                 fontSize: 13, color: Color(0xFF222222)),
        //             //           ),
        //             //         ],
        //             //       )),
        //             // ),

        //             Container(
        //                 padding:
        //                     EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: <Widget>[
        //                     Text(
        //                       "商机统计",
        //                       maxLines: 3,
        //                       style: TextStyle(
        //                           fontSize: 13, color: Color(0xFF222222)),
        //                     ),
        //                   ],
        //                 )),
        //             Expanded(
        //               flex: 1,
        //               child: Container(
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisSize: MainAxisSize.max,
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: <Widget>[
        //                       Container(
        //                         margin: EdgeInsets.only(right: 20),
        //                         width: 11,
        //                         child: Image(
        //                           image:
        //                               AssetImage('assets/image/my_right.png'),
        //                           fit: BoxFit.fitWidth,
        //                         ),
        //                       ),
        //                     ],
        //                   )),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         height: 1,
        //         margin: EdgeInsets.only(left: 20),
        //         decoration: BoxDecoration(color: Color(0xFFE7E9F6)),
        //       ),

        //       // 走访统计
        //       InkWell(
        //         onTap: () {
        //           XRouter.goWeb(
        //               XHttp.Web_Base_Url + "display/visit.php", "走访统计");
        //         },
        //         child: Row(
        //           children: <Widget>[
        //             Container(
        //               margin: EdgeInsets.symmetric(vertical: 10),
        //               padding: EdgeInsets.only(left: 20, right: 10),
        //               height: 36,
        //               child: AspectRatio(
        //                 aspectRatio: 1.2,
        //                 child: Image(
        //                   image: AssetImage('assets/image/my_zftj.png'),
        //                   fit: BoxFit.contain,
        //                 ),
        //               ),
        //             ),
        //             // Expanded(
        //             //   flex: 1,
        //             //   child: Container(
        //             //       padding:
        //             //           EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        //             //       child: Column(
        //             //         crossAxisAlignment: CrossAxisAlignment.start,
        //             //         children: <Widget>[
        //             //           Text(
        //             //             "走访统计",
        //             //             maxLines: 3,
        //             //             style: TextStyle(
        //             //                 fontSize: 13, color: Color(0xFF222222)),
        //             //           ),
        //             //         ],
        //             //       )),
        //             // ),

        //             Container(
        //                 padding:
        //                     EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: <Widget>[
        //                     Text(
        //                       "走访统计",
        //                       maxLines: 3,
        //                       style: TextStyle(
        //                           fontSize: 13, color: Color(0xFF222222)),
        //                     ),
        //                   ],
        //                 )),
        //             Expanded(
        //               flex: 1,
        //               child: Container(
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisSize: MainAxisSize.max,
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: <Widget>[
        //                       Container(
        //                         margin: EdgeInsets.only(right: 20),
        //                         width: 11,
        //                         child: Image(
        //                           image:
        //                               AssetImage('assets/image/my_right.png'),
        //                           fit: BoxFit.fitWidth,
        //                         ),
        //                       ),
        //                     ],
        //                   )),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // 修改密码
        Container(
          margin: EdgeInsets.only(top: 12, left: 30, right: 30),
          decoration: BoxDecoration(
              //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Colors.white),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // XRouter.goWeb(
                  //     XHttp.Web_Base_Url + "display/visit.php", "走访统计");
                  Get.to(() => MotifyPwdPage());
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 20, right: 10),
                      height: 36,
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: Image(
                          image: AssetImage('assets/image/my_xgmm.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //       padding:
                    //           EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: <Widget>[
                    //           Text(
                    //             "修改密码",
                    //             maxLines: 3,
                    //             style: TextStyle(
                    //                 fontSize: 13, color: Color(0xFF222222)),
                    //           ),
                    //         ],
                    //       )),
                    // ),

                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "修改密码",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF222222)),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 11,
                                child: Image(
                                  image:
                                      AssetImage('assets/image/my_right.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),

              Container(
                height: 1,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(color: Color(0xFFE7E9F6)),
              ),

              // 隐私协议
              InkWell(
                onTap: () {
                  XRouter.goWeb(XHttp.Web_Base_Url + "yinsi.html", "隐私协议");
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 20, right: 10),
                      height: 36,
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: Image(
                          image: AssetImage('assets/image/my_ysxy.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //       padding:
                    //           EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: <Widget>[
                    //           Text(
                    //             "隐私协议",
                    //             maxLines: 3,
                    //             style: TextStyle(
                    //                 fontSize: 13, color: Color(0xFF222222)),
                    //           ),
                    //         ],
                    //       )),
                    // ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "隐私协议",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF222222)),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 11,
                                child: Image(
                                  image:
                                      AssetImage('assets/image/my_right.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(color: Color(0xFFE7E9F6)),
              ),

              //当前版本
              InkWell(
                onTap: () {
                  //当前版本
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 20, right: 10),
                      height: 36,
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: Image(
                          image: AssetImage('assets/image/my_dqbb.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "当前版本",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF222222)),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5, right: 16),
                                child: Text(
                                  _version,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //退出登录
        InkWell(
          onTap: () {
            // Get.to(() => TabDetailPage("走访管理", "visit_list"));
            UserProfile userProfile =
                Provider.of<UserProfile>(context, listen: false);
            userProfile.userId = "";
            Navigator.pushAndRemoveUntil(context,
                new MaterialPageRoute(builder: (BuildContext c) {
              return new LoginPage();
            }), (r) => r == null);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 60),
            margin: EdgeInsets.only(top: 16, left: 40, right: 40),
            decoration: BoxDecoration(
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Color(0xFF1A97F3)),
            child: Text(
              "退出登录",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
