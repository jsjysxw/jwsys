import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dayo/core/http/http.dart';
import 'package:dayo/entity/banner_item.dart' as bannerItem;
import 'package:dayo/entity/func_icon.dart' as funcicon;
import 'package:dayo/page/home/tab_detail.dart';
import 'package:dayo/router/router.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dayo/core/utils/toast.dart';
import 'package:dayo/core/widget/grid/grid_item.dart';
import 'package:dayo/core/widget/list/article_item.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  int _count = 5;
  var _rid = "";

  // String _long_unvisit_num = "";
  // String _unvisit_num = "";
  // String _chance_num = "";

  // getWebNet() {
  //   XHttp.post("method=home_num", {
  //     "user_id": SPUtils.getUserId(),
  //   }).then((response) {
  //     var response1 = jsonDecode(response);
  //     print(response1);
  //     if (response1["state"] == "1") {
  //       setState(() {
  //         _long_unvisit_num = response1["content"]["long_unvisit_num"];
  //         _unvisit_num = response1["content"]["unvisit_num"];
  //         _chance_num = response1["content"]["chance_num"];
  //       });
  //     } else {
  //       ToastUtils.error("无数据");
  //     }
  //   }).catchError((onError) {
  //     ToastUtils.error(onError);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getWebNet();
    getFuncInfos();
    getBannerInfos();

    String notice = SPUtils.getNotice();
    if (notice != null && notice != "") {}

    JPush jpush = new JPush();
    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );

    jpush.setup(
      appKey: "b0cb5e00b099e302f71a4dcb",
      channel: "theChannel",
      production: false,
      debug: false, // 设置是否打印 debug 日志
    );
    jpush.getRegistrationID().then((rid) {
      print("rid=$rid");
      setState(() {
        _rid = rid;
      });
      update_registration_id();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _count = 5;
          });
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _count += 5;
          });
        });
      },
      slivers: <Widget>[
        // SliverToBoxAdapter(child: getavatar()),
        //=====轮播图=====//
        // SliverToBoxAdapter(child: getBannerWidget()),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
              image: new DecorationImage(
                image: AssetImage('assets/image/main_top_bg.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getavatar(),
                // Container(
                //   margin: EdgeInsets.only(top: 0),
                //   height: 200.0,
                //   // child: new ListView(
                //   //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: <Widget>[
                //       getTopBan1(),
                //       getTopBan2(),
                //       getTopBan3(),
                //     ],
                //   ),
                // ),
                getBannerWidget(),

                getFunc()
              ],
            ),
          ),
        ),

        //=====网格菜单=====//
        SliverPadding(
            padding: EdgeInsets.only(top: 10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 40,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  var action = actionsData[index];
                  return GridItem(
                      title: action.title,
                      image: action.image,
                      onTap: () {
                        // ToastUtils.toast('点击-->${action.title}');

                        XRouter.goWeb(
                            XHttp.Web_Base_Url + action.type, action.title);
                      });
                },
                childCount: actionsData.length,
              ),
            )),

        // SliverToBoxAdapter(
        //     child: Padding(
        //         padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        //         child: Text(
        //           '资讯',
        //           style: TextStyle(fontSize: 18),
        //         ))),

        //=====列表=====//
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       ArticleInfo info = articles[index % 5];
        //       return ArticleListItem(
        //           articleUrl: info.articleUrl,
        //           imageUrl: info.imageUrl,
        //           title: info.title,
        //           author: info.author,
        //           description: info.description,
        //           summary: info.summary);
        //     },
        //     childCount: _count,
        //   ),
        // ),
        SliverToBoxAdapter(child: getBott()),
      ],
    );
  }

  // //这里是演示，所以写死
  // final List<String> urls = [
  //   "https://z3.ax1x.com/2021/07/12/WCvW2d.jpg", //伪装者:胡歌演绎"痞子特工"
  //   // "https://z3.ax1x.com/2021/07/12/WCv7a8.jpg", //无心法师:生死离别!月牙遭虐杀
  //   // "https://z3.ax1x.com/2021/07/12/WCv4KI.jpg", //花千骨:尊上沦为花千骨
  //   // "https://z3.ax1x.com/2021/07/12/WCvIqP.jpg", //综艺饭:胖轩偷看夏天洗澡掀波澜
  //   // "https://z3.ax1x.com/2021/07/12/WCv5rt.jpg", //碟中谍4:阿汤哥高塔命悬一线,超越不可能
  // ];

  Widget getBannerWidget() {
    return SizedBox(
      height: 175,
      child: Swiper(
        autoplay: true,
        duration: 2000,
        autoplayDelay: 5000,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                    XHttp.Web_Base_Url + datas2[index].image,
                  ),
                )),
          );
        },
        onTap: (value) {
          XRouter.goWeb(XHttp.Web_Base_Url + datas2[value].url, "详情");
        },
        itemCount: datas2.length,
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget getavatar() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: 90,
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
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 20,
      decoration: BoxDecoration(
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        image: new DecorationImage(
          image: AssetImage('assets/image/main_title_func.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget getBott() {
    String url =
        // XHttp.Web_Base_Url + "temperature.php?user_id=" + SPUtils.getUserId();
        XHttp.Web_Base_Url + "news_app.php";
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
      height: 200,
      decoration: BoxDecoration(
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        // image: new DecorationImage(
        //     image: AssetImage('assets/image/main_bmyzq.png'),
        //     fit: BoxFit.fill,
        //     alignment: Alignment.center),
      ),
      child: WebView(
        initialUrl: url,
        gestureRecognizers: [Factory(() => EagerGestureRecognizer())].toSet(),
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) async {},
        gestureNavigationEnabled: true,
      ),
    );
  }

  //这里是演示，所以写死
  // final List<ActionItem> actions = [
  //   ActionItem('走访管理', "wb_scgl", "visit_list"),
  //   ActionItem('长期未走访', "wb_jzdd", "unvisit_list"),
  //   ActionItem('商机管理', "wb_ddgl", "chance_list"),
  //   ActionItem('合同管理', "wb_qjbx", "contract_list"),
  //   ActionItem('产品资料库', "wb_ywzs", "product_list"),
  //   ActionItem('营销活动库', "wb_xyxdu", "market_list"),
  //   ActionItem('集团列表', "wb_lcyq", "company_list"),
  //   ActionItem('商机发现', "wb_jkh5", "chance_all_list"),
  //   ActionItem('服务问题管理', "wb_qrssp", "order_list"),
  //   ActionItem('走访统计', "wb_rxsjpd", "visit_stc"),
  // ];

  List<ActionItem> actionsData = new List();
  List<bannerItem.Content> datas2 = new List();
  getFuncInfos() async {
    print("getUserId${SPUtils.getUserId()}");
    print("getWebUserId${SPUtils.getWebUserId()}");
    print("getTypeId${SPUtils.getTypeId()}");
    await XHttp.post("method=home_page", {
      "user_id": SPUtils.getUserId(),
      "web_user_id": SPUtils.getWebUserId(),
      "type_id": SPUtils.getTypeId(),
    }).then((response) {
      var response1 = jsonDecode(response);
      print("funciconitem=$response1");
      if (response1["state"] == "1") {
        var funciconitem = funcicon.FuncIcon.fromJson(response1);

        setState(() {
          if (funciconitem.content != null) {
            actionsData.clear();

            for (var item in funciconitem.content) {
              var act = ActionItem(item.name, item.icon, item.url);
              actionsData.add(act);
            }
          }
        });
      }
    }).catchError((onError) {
      ToastUtils.error(onError);
    });
  }

  getBannerInfos() async {
    await XHttp.post("method=banner_list", {
      // "user_id": SPUtils.getUserId(),
      // "web_user_id": SPUtils.getWebUserId(),
      // "type_id": SPUtils.getTypeId(),
    }).then((response) {
      var response1 = jsonDecode(response);
      print(response1);
      if (response1["state"] == "1") {
        var banneritem = bannerItem.BannerItem.fromJson(response1);

        setState(() {
          if (banneritem.content != null) {
            datas2.clear();
            datas2.addAll(banneritem.content);
          }
        });
      }
    }).catchError((onError) {
      ToastUtils.error(onError);
    });
  }

  update_registration_id() async {
    await XHttp.post("method=update_registration_id", {
      "user_id": SPUtils.getUserId(),
      "registration_id": _rid,
    }).then((response) {}).catchError((onError) {
      ToastUtils.error(onError);
    });
  }
}
