
class FuncIcon {
  String state;
  String reason;
  List<Content> content;

  FuncIcon({this.state, this.reason, this.content});

  FuncIcon.fromJson(Map<String, dynamic> json) {
    if(json["state"] is String)
      this.state = json["state"];
    if(json["reason"] is String)
      this.reason = json["reason"];
    if(json["content"] is List)
      this.content = json["content"]==null ? null : (json["content"] as List).map((e)=>Content.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["state"] = this.state;
    data["reason"] = this.reason;
    if(this.content != null)
      data["content"] = this.content.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Content {
  String icon;
  String name;
  String url;

  Content({this.icon, this.name, this.url});

  Content.fromJson(Map<String, dynamic> json) {
    if(json["icon"] is String)
      this.icon = json["icon"];
    if(json["name"] is String)
      this.name = json["name"];
    if(json["url"] is String)
      this.url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["icon"] = this.icon;
    data["name"] = this.name;
    data["url"] = this.url;
    return data;
  }
}