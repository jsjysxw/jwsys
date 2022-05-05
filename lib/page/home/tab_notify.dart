import 'package:dayo/core/http/http.dart';
import 'package:dayo/utils/sputils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabNotifyPage extends StatefulWidget {
  @override
  _TabNotifyPageState createState() => _TabNotifyPageState();
}

class _TabNotifyPageState extends State<TabNotifyPage> {
  @override
  Widget build(BuildContext context) {
    return getBott();
  }

  Widget getBott() {
    String url = XHttp.Web_Base_Url +
        "notice_app.php?user_id=" +
        SPUtils.getUserId() +
        "&web_user_id=" +
        SPUtils.getWebUserId();
    return Container(
      margin: EdgeInsets.only(top: 12),
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
}
