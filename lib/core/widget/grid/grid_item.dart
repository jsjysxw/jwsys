import 'package:cached_network_image/cached_network_image.dart';
import 'package:dayo/core/http/http.dart';
import 'package:flutter/material.dart';

/// 列表项
class GridItem extends StatelessWidget {
  // 文字
  final String title;
  // 颜色
  final String image;
  //是否可点击
  final bool enabled;
  //点击事件
  final GestureTapCallback onTap;

  // 构造函数
  const GridItem(
      {Key key, this.title, this.image, this.enabled = true, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(children: <Widget>[
            // ClipOval(
            //   child: Container(
            //     alignment: Alignment.center,
            //     color: color,
            //     child: Text(title.substring(0, 1),
            //         style: TextStyle(color: Colors.white, fontSize: 16)),
            //     width: 40,
            //     height: 40,
            //   ),
            // ),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                image: new DecorationImage(
                    image: CachedNetworkImageProvider(
                      XHttp.Web_Base_Url + image,
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(title, style: TextStyle(fontSize: 12)))
          ]),
        ));
  }
}

class ActionItem {
  final String title;
  final String image;
  final String type;
  const ActionItem(this.title, this.image, this.type);
}
