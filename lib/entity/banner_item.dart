
class BannerItem {
  String state;
  String reason;
  List<Content> content;

  BannerItem({this.state, this.reason, this.content});

  BannerItem.fromJson(Map<String, dynamic> json) {
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
  String image;
  String url;

  Content({this.image, this.url});

  Content.fromJson(Map<String, dynamic> json) {
    if(json["image"] is String)
      this.image = json["image"];
    if(json["url"] is String)
      this.url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["image"] = this.image;
    data["url"] = this.url;
    return data;
  }
}