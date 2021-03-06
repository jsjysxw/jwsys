import 'dart:convert';

import 'package:dayo/core/http/http.dart';
import 'package:dayo/core/utils/toast.dart';
import 'package:dayo/core/widget/list/article_item.dart';
import 'package:dayo/core/widget/list/common_item.dart';
import 'package:dayo/entity/article_item.dart';
import 'package:dayo/generated/i18n.dart';
import 'package:dayo/router/router.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class TabNoticePage extends StatefulWidget {
  var title = "";
  var type = "";
  TabNoticePage(this.title, this.type, {Key key}) : super(key: key);

  @override
  _TabNoticePageState createState() => _TabNoticePageState();
}

class _TabNoticePageState extends State<TabNoticePage> {
  var _page = 0;
  List<Data> datas = new List();
  var _view_page = "";
  var _add_page = "";
  var _time_flag = "";
  TextEditingController mycontroller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticleInfos();
    mycontroller.addListener(_printLatestValue);
  }

  _printLatestValue() {
    getArticleInfos();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return
        // Scaffold(
        //     appBar: AppBar(
        //       title: Text(widget.title, style: TextStyle(fontSize: 18)),
        //       centerTitle: true,
        //       actions: <Widget>[
        //         Offstage(
        //           offstage: _add_page == "" ? true : false,
        //           child: IconButton(
        //               icon: Icon(Icons.add),
        //               onPressed: () {
        //                 XRouter.goWeb(
        //                     XHttp.Web_Base_Url +
        //                         _add_page +
        //                         "?user_id=" +
        //                         SPUtils.getUserId(),
        //                     "??????" + widget.title,
        //                     ffff: getArticleInfos);
        //                 setState(() {
        //                   _page = 0;
        //                 });
        //               }),
        //         ), //??????????????????
        //       ],
        //     ),
        //     body:
        EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _page = 0;
            getArticleInfos();
          });
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _page += 1;
            getArticleInfos();
          });
        });
      },
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: 38, bottom: 8),
            decoration: BoxDecoration(
              color: Color(0xFFEBEEFC),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 0),
                    //?????? child ??????
                    alignment: Alignment.center,
                    height: width * 1 / 8.3,
                    width: width - 24,
                    //????????????
                    decoration: new BoxDecoration(
                      //??????
                      color: Color(0xFFFAFAFA),
                      //?????????????????? ?????? ???????????????????????? ???Container height ?????????
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      //??????????????????
                      border: new Border.all(width: 1, color: Colors.white12),
                    ),
                    child: TextFormField(
                      controller: mycontroller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(top: 3),

                          border: InputBorder.none,
                          hintText: '??????????????????...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                              iconSize: 22,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  mycontroller.text = "";
                                });
                              })),
                    ),
                  ),
                ),
                Offstage(
                  offstage: _time_flag == "0" ? true : false,
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        //?????? child ??????
                        alignment: Alignment.center,
                        height: width * 1 / 9,
                        width: width,
                        //????????????
                        decoration: new BoxDecoration(
                          //??????
                          color: Color(0xFFEBEEFC),
                          // //?????????????????? ?????? ???????????????????????? ???Container height ?????????
                          // borderRadius:
                          //     BorderRadius.all(Radius.circular(25.0)),
                          // //??????????????????
                          // border:
                          //     new Border.all(width: 1, color: Colors.white12),
                        ),
                        child: InkWell(
                            onTap: () async {
                              final List<DateTime> picked =
                                  await DateRagePicker.showDatePicker(
                                      context: context,
                                      initialFirstDate: new DateTime.now(),
                                      initialLastDate: (new DateTime.now())
                                          .add(new Duration(days: 7)),
                                      firstDate: new DateTime(2015),
                                      lastDate: new DateTime(
                                          DateTime.now().year + 2));
                              if (picked != null && picked.length == 2) {
                                DateTime start_time = picked[0];
                                DateTime end_time = picked[1];
                                setState(() {
                                  _time_title =
                                      "${start_time.year}-${start_time.month}-${start_time.day} ~ ${end_time.year}-${end_time.month}-${end_time.day}";
                                  _start_time =
                                      "${start_time.year}-${start_time.month}-${start_time.day}";
                                  _end_time =
                                      "${end_time.year}-${end_time.month}-${end_time.day}";
                                  getArticleInfos();
                                });
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: Text(_time_title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333)))))),
                  ),
                ),
              ],
            ),
          ),
        ),
        //=====??????=====//
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Data info = datas[index];
              return CommonListItem(
                articleUrl: XHttp.Web_Base_Url +
                    _view_page +
                    "?user_id=" +
                    SPUtils.getUserId() +
                    "&id=" +
                    info.id,
                title: info.title,
                content: info.content,
                state_name: info.stateName,
                fun: getArticleInfos,
              );
            },
            childCount: datas.length,
          ),
        ),
      ],
      // )
    );
  }

  String _time_title = "????????????";
  String _start_time = "";
  String _end_time = "";
  getArticleInfos() async {
    print("mycontroller${mycontroller.text}");
    print("type${widget.type}");
    print("getUserId${SPUtils.getUserId()}");
    print("_page$_page");
    print("_start_time$_start_time");
    print("_end_time$_end_time");
    await XHttp.post("method=common_list", {
      "key": mycontroller.text,
      "type": widget.type,
      "user_id": SPUtils.getUserId(),
      "page": _page,
      "start_time": _start_time,
      "end_time": _end_time
    }).then((response) {
      var response1 = jsonDecode(response);
      print(response1);
      if (response1["state"] == "1") {
        var articleItem = ArticleItem.fromJson(response1);

        setState(() {
          _view_page = articleItem.content.viewPage;
          _add_page = articleItem.content.addPage;
          _time_flag = articleItem.content.timeFlag;
          if (articleItem.content.data != null) {
            if (_page == 0) {
              datas.clear();
              datas.addAll(articleItem.content.data);
            } else {
              datas.addAll(articleItem.content.data);
            }
          }
        });
      } else if (response1["state"] == "0") {
        var articleItem = ArticleItem.fromJson(response1);
        setState(() {
          _view_page = articleItem.content.viewPage;
          _add_page = articleItem.content.addPage;
          _time_flag = articleItem.content.timeFlag;
          if (_page == 0) {
            datas.clear();
          }
        });
      }
    }).catchError((onError) {
      ToastUtils.error(onError);
    });
  }

  String _dateSelectText;
}
