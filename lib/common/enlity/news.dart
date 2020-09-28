
///新闻分页 request
class NewPageListResuestEntity{
  String categoryCode;
  String channelCode;
  String tag;
  String keyword;

  NewPageListResuestEntity({
    this.categoryCode,
    this.channelCode,
    this.tag,
    this.keyword
  });
  Map<String,dynamic> toJson()=>{
    "categoryCode": categoryCode,
    "channelCode": channelCode,
    "tag": tag,
    "keyword": keyword,
  };
}
///response
class NewPageListResponseEntity{
  int counts;
  int pagesize;
  int pages;
  int page;
  List<NewItem> items;


  NewPageListResponseEntity({
    this.counts,
    this.pagesize,
    this.pages,
    this.page,
    this.items
  });
  factory NewPageListResponseEntity.fromJson(Map<String,dynamic> json)=>
      NewPageListResponseEntity(
        counts: json["counts"],
        pagesize: json["pagesize"],
        pages: json["pages"],
        page: json["page"],
        items: List<NewItem>.from(json["items"].map((x)=>NewItem.fromJson(x))),
      );
  Map<String,dynamic> toJson()=>{
    "counts":counts,
    "pagesize":pagesize,
    "pages":pages,
    "page":page,
    "items":List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class NewItem{
  String id;
  String title;
  String category;
  String thumbnail;
  String author;
  DateTime addtime;
  String url;
  NewItem({
   this.id,
   this.title,
   this.category,
    this.thumbnail,
    this.author,
    this.addtime,
    this.url
});
  factory NewItem.fromJson(Map<String,dynamic> json)=>NewItem(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    author: json["author"],
    addtime: DateTime.parse(json["addTime"]),
    url: json["url"]
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "title":title,
    "category":category,
    "thumbnail":thumbnail,
    "author":author,
    "addtime":addtime.toIso8601String(),
    "url":url,
  };
}

/// 新闻推荐 request
class NewsRecommendRequestEntity {
  String categoryCode;
  String channelCode;
  String tag;
  String keyword;

  NewsRecommendRequestEntity({
    this.categoryCode,
    this.channelCode,
    this.tag,
    this.keyword,
  });

  Map<String, dynamic> toJson() => {
    "categoryCode": categoryCode,
    "channelCode": channelCode,
    "tag": tag,
    "keyword": keyword,
  };
}

/// 新闻推荐 response
class NewsRecommendResponseEntity {
  String thumbnail;
  String title;
  String category;
  DateTime addtime;
  String author;
  String url;
  String id;

  NewsRecommendResponseEntity({
    this.thumbnail,
    this.title,
    this.category,
    this.addtime,
    this.author,
    this.url,
    this.id,
  });

  factory NewsRecommendResponseEntity.fromJson(Map<String, dynamic> json) =>
      NewsRecommendResponseEntity(
        thumbnail: json["thumbnail"],
        title: json["title"],
        category: json["category"],
        addtime: DateTime.parse(json["addtime"]),
        author: json["author"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "title": title,
    "category": category,
    "addtime": addtime.toIso8601String(),
    "author": author,
    "url": url,
    "id": id,
  };
}