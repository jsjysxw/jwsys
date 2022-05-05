
class ArticleItem {
  String state;
  Content content;

  ArticleItem({this.state, this.content});

  ArticleItem.fromJson(Map<String, dynamic> json) {
    if(json["state"] is String)
      this.state = json["state"];
    if(json["content"] is Map)
      this.content = json["content"] == null ? null : Content.fromJson(json["content"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["state"] = this.state;
    if(this.content != null)
      data["content"] = this.content.toJson();
    return data;
  }
}

class Content {
  String timeFlag;
  String keyName;
  String addPage;
  String viewPage;
  List<Data> data;

  Content({this.timeFlag, this.keyName, this.addPage, this.viewPage, this.data});

  Content.fromJson(Map<String, dynamic> json) {
    if(json["time_flag"] is String)
      this.timeFlag = json["time_flag"];
    if(json["key_name"] is String)
      this.keyName = json["key_name"];
    if(json["add_page"] is String)
      this.addPage = json["add_page"];
    if(json["view_page"] is String)
      this.viewPage = json["view_page"];
    if(json["data"] is List)
      this.data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["time_flag"] = this.timeFlag;
    data["key_name"] = this.keyName;
    data["add_page"] = this.addPage;
    data["view_page"] = this.viewPage;
    if(this.data != null)
      data["data"] = this.data.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Data {
  String id;
  String title;
  String content;
  String stateName;

  Data({this.id, this.title, this.content, this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String)
      this.id = json["id"];
    if(json["title"] is String)
      this.title = json["title"];
    if(json["content"] is String)
      this.content = json["content"];
    if(json["state_name"] is String)
      this.stateName = json["state_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["content"] = this.content;
    data["state_name"] = this.stateName;
    return data;
  }
}