import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dayo/router/router.dart';

/// 资讯列表详情
class CommonListItem extends StatelessWidget {
  //文章地址
  final String title;

  //图片地址
  final String content;

  //文章标题
  final String state_name;

  //文章标题
  final String articleUrl;

  final Function fun;

  const CommonListItem(
      {Key key,
      this.title = '',
      this.content = '',
      this.state_name = '',
      this.fun,
      this.articleUrl = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          XRouter.goWeb(articleUrl, title, ffff: fun);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            child: Row(
              children: <Widget>[
                // Container(
                //   padding: EdgeInsets.only(left: 10, right: 5),
                //   width: 100.0,
                //   child: AspectRatio(
                //     aspectRatio: 1.2,
                //     child: CachedNetworkImage(
                //         fit: BoxFit.fill,
                //         placeholder: (context, url) => Container(
                //               color: Colors.grey[200],
                //             ),
                //         imageUrl: imageUrl),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 230,
                                child: Text(title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ),
                              getTextStack(content)
                              // Container(
                              //   margin: EdgeInsets.only(top: 2.0),
                              //   child: Text(
                              //     content,
                              //     style: TextStyle(
                              //         fontSize: 12, color: Colors.grey),
                              //   ),
                              // ),

                              // SizedBox(
                              //   height: 4,
                              // ),
                              // Text(
                              //   summary,
                              //   maxLines: 3,
                              //   style:
                              //       TextStyle(fontSize: 12, color: Colors.black87),
                              //   overflow: TextOverflow.ellipsis,
                              // )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Offstage(
                              offstage: state_name != null && state_name != ""
                                  ? false
                                  : true,
                              child: Container(
                                alignment: Alignment.center,
                                width: 90,
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 5, bottom: 5),
                                margin: EdgeInsets.only(top: 16),
                                decoration: BoxDecoration(
                                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Color(0xFFFF621F)),
                                child: Text(
                                  state_name != null && state_name != ""
                                      ? state_name
                                      : "",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getTextStack(String content) {
    var first_step = content.split("||");
    List<Container> list = List();
    if (first_step != null && first_step.length > 0) {
      for (var item in first_step) {
        var con = Container(
          margin: EdgeInsets.only(top: 6.0),
          alignment: Alignment.centerLeft,
          child: Text(
            item,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        );
        list.add(con);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
